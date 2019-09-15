# source the envs
. ./envs.sh

docker rm -f $OVPN_CONTAINER_NAME

# Start the OVPN service
docker run \
    -v $OVPN_DATA:/etc/openvpn -d \
    --publish $OVPN_PORT:1194/udp \
    --network=$OVPN_NETWORK \
	--log-driver=none \
	--cap-add=NET_ADMIN \
    --name=$OVPN_CONTAINER_NAME \
	kylemanna/openvpn 


docker ps