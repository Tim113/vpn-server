# source the envs
. ./envs.sh

# Create the network that will be used to 
sudo docker network create $OVPN_NETWORK

# Create the docker volumne
docker volume create --name $OVPN_DATA

# Add the files needed to run the ovpn servace into the docker voumne
######### Need to check what the VPN.SERVERNAME.COM sould be
docker run \
    -e OVPN_DNS_SERVERS=$OVPN_DNS \
    -e OVPN_DNS='1' \
    -v $OVPN_DATA:/etc/openvpn \
    --log-driver=none \
    --network=$OVPN_NETWORK \
    --rm kylemanna/openvpn ovpn_genconfig \
    -C 'AES-256-CBC' \
    -a 'SHA384' \
    -u udp://$OVPN_SERVER_NAME

# First fix the ran file issue if it has not been fixed:
# https://github.com/angristan/openvpn-install/issues/454#issue-473796843

docker run \
    -e EASYRSA_KEY_SIZE=4096 \
    -v $OVPN_DATA:/etc/openvpn \
    --network=$OVPN_NETWORK \
    --log-driver=none --rm \
    -it kylemanna/openvpn ovpn_initpki

# Start the OVPN service
docker run \
    -v $OVPN_DATA:/etc/openvpn -d \
    --publish $OVPN_PORT:1194/udp \
    --network=$OVPN_NETWORK \
    --log-driver=none \
    --name=$OVPN_CONTAINER_NAME \
    --cap-add=NET_ADMIN kylemanna/openvpn 

