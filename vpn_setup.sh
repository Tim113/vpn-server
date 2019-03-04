# Name the dock volumne with the CA
OVPN_DATA="ovpn-data-pi-hole"
OVPN_PORT=1195
OVPN_SERVER_NAME="vpn.thj113.com"I
OVPN_DNS=167.99.211.211

# Create the docker volumne
docker volume create --name $OVPN_DATA

# Add the files needed to run the ovpn servace into the docker voumne
######### Need to check what the VPN.SERVERNAME.COM sould be
docker run \
    -e OVPN_DNS_SERVERS=$OVPN_DNS \
    -e OVPN_DNS='1' \
    -v $OVPN_DATA:/etc/openvpn \
    --log-driver=none \
    --rm kylemanna/openvpn ovpn_genconfig \
    -C 'AES-256-CBC' \
    -a 'SHA384' \
    -u udp://$OVPN_SERVER_NAME

docker run \
    -e EASYRSA_KEY_SIZE=4096 \
    -v $OVPN_DATA:/etc/openvpn \
    --log-driver=none --rm \
    -it kylemanna/openvpn ovpn_initpki

# Start the OVPN service
docker run \
	-v $OVPN_DATA:/etc/openvpn -d -p \
	$OVPN_PORT:1194/udp \
	--cap-add=NET_ADMIN kylemanna/openvpn
	--name=$OVPN_DATA

## Create the clinat cert 
#docker run \
#	-v $OVPN_DATA:/etc/openvpn \
#	-e EASYRSA_KEY_SIZE=4096 \
#	--log-driver=none --rm \
#	-it kylemanna/openvpn easyrsa build-client-full CLIENTNAME nopass

## Cet the clinat cert in a usable form, with the certificates
#docker run \
#	-v $OVPN_DATA:/etc/openvpn \
#       --log-driver=none \
#       --rm kylemanna/openvpn ovpn_getclient CLIENTNAME > CLIENTNAME.ovpn
