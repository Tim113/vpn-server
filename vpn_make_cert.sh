# Name the dock volumne with the CA
TOP_LEVEL_NAME="basis"
OVPN_DATA="ovpn-data-basis"
OVPN_NETWORK="ovpn-basis"
OVPN_PORT=1195
OVPN_SERVER_NAME="vpn.thj113.com"I
OVPN_DNS=167.99.211.211
CERT_NAME='tim_oneplus6'

# Create the clinat cert 
docker run \
    -v $OVPN_DATA:/etc/openvpn \
    -e EASYRSA_KEY_SIZE=4096 \
    --network=$OVPN_NETWORK \
    --log-driver=none --rm \
    -it kylemanna/openvpn easyrsa build-client-full $CERT_NAME nopass

# Cet the clinat cert in a usable form, with the certificates
docker run \
    -v $OVPN_DATA:/etc/openvpn \
    --network=$OVPN_NETWORK \
    --log-driver=none \
    --rm kylemanna/openvpn ovpn_getclient $CERT_NAME > $CERT_NAME.ovpn
