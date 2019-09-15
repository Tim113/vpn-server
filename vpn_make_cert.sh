# source the envs
. ./envs.sh
CERT_NAME="tim_oneplus6"

# # Create the clinat cert 
# docker run \
#     -v $OVPN_DATA:/etc/openvpn \
#     -e EASYRSA_KEY_SIZE=4096 \
#     --network=$OVPN_NETWORK \
#     --log-driver=none --rm \
#     -it kylemanna/openvpn easyrsa build-client-full $CERT_NAME nopass

echo $CERT_NAME

# Cet the clinat cert in a usable form, with the certificates
docker run \
    -v $OVPN_DATA:/etc/openvpn \
    --network=$OVPN_NETWORK \
    --log-driver=none \
    --rm kylemanna/openvpn ovpn_getclient $CERT_NAME > certs/$CERT_NAME.ovpn
