OVPN_DATA="ovpn-data-main"

# Create the clinat cert 
docker run \
	-v $OVPN_DATA:/etc/openvpn \
	-e EASYRSA_KEY_SIZE=4096 \
	--log-driver=none --rm \
	-it kylemanna/openvpn easyrsa build-client-full TEST nopass

# Cet the clinat cert in a usable form, with the certificates
docker run \
	-v $OVPN_DATA:/etc/openvpn \
       --log-driver=none \
       --rm kylemanna/openvpn ovpn_getclient TEST > TEST.ovpn.tst
