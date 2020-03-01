# source the envs
. ./envs.sh

######### Need to check what the VPN.SERVERNAME.COM sould be
docker-compose run \
    --rm ovpn ovpn_genconfig \
    -u udp://
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

. ./restart_vpn.sh