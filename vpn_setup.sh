# Name the dock volumne with the CA
TOP_LEVEL_NAME="main"
OVPN_DATA="ovpn-data-main"
OVPN_NETWORK="ovpn-net-main"
OVPN_CONTAINER_NAME='ovnp-main'
OVPN_PORT=1195
OVPN_SERVER_NAME="vpn.thj113.com"I
OVPN_DNS=1.1.1.1

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
    --cap-add=NET_ADMIN kylemanna/openvpn \
    --name=$OVPN_CONTAINER_NAME

## Create the clinat cert 
#docker run \
#    -v $OVPN_DATA:/etc/openvpn \
#    -e EASYRSA_KEY_SIZE=4096 \
#    --network=$OVPN_NETWORK \
#    --log-driver=none --rm \
#    -it kylemanna/openvpn easyrsa build-client-full CLIENTNAME nopass

## Cet the clinat cert in a usable form, with the certificates
#docker run \
#    -v $OVPN_DATA:/etc/openvpn \
#    --network=$OVPN_NETWORK \
#    --log-driver=none \
#    --rm kylemanna/openvpn ovpn_getclient CLIENTNAME > CLIENTNAME.ovpn
