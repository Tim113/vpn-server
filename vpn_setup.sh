# Name the dock volumne with the CA
OVPN_DATA="ovpn-data-main"

# Create the docker volumne
docker volume create --name $OVPN_DATA

# Add the files needed to run the ovpn servace into the docker voumne
######### Need to check what the VPN.SERVERNAME.COM sould be
docker run \
    -v $OVPN_DATA:/etc/openvpn \
    --log-driver=none \
    --rm kylemanna/openvpn ovpn_genconfig \
    -C 'AES-256-CBC' \
    -a 'SHA384' \
    -u udp://VPN.SERVERNAME.COM

docker run \
    -v $OVPN_DATA:/etc/openvpn \
    -e EASYRSA_KEY_SIZE=4096 \
    --log-driver=none --rm \
    -it kylemanna/openvpn ovpn_initpki

# Start the OVPN service
docker run \
	-v $OVPN_DATA:/etc/openvpn -d -p \
	1194:1194/udp \
	--cap-add=NET_ADMIN kylemanna/openvpn

# Create the clinat cert 
docker run \
	-v $OVPN_DATA:/etc/openvpn \
	-e EASYRSA_KEY_SIZE=4096 \
	--log-driver=none --rm \
	-it kylemanna/openvpn easyrsa build-client-full CLIENTNAME nopass

# Cet the clinat cert in a usable form, with the certificates
docker run \
	-v $OVPN_DATA:/etc/openvpn \
       --log-driver=none \
       --rm kylemanna/openvpn ovpn_getclient CLIENTNAME > CLIENTNAME.ovpn
