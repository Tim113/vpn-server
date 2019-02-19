# Name the dock volumne with the CA
OVPN_DATA="ovpn-data-main"

docker rm -f ovpn-main 

# Start the OVPN service
docker run \
	-v $OVPN_DATA:/etc/openvpn -d -p \
	1194:1194/udp \
	--name ovpn-main \
	--cap-add=NET_ADMIN kylemanna/openvpn

