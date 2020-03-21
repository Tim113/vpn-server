docker-compose run --rm openvpn ovpn_genconfig -u udp://VPN.SERVERNAME.COM
# vpn-server
Scripts for creating a server running https://github.com/kylemanna/docker-openvpn

The supported way of running this is with docker-compose.

Steps:
Inintalise the Ovpn contaner 
```
docker-compose run --rm openvpn ovpn_genconfig -u udp://VPN.SERVERNAME.COM  -C 'AES-256-CBC' -a 'SHA384'
docker-compose run --rm openvpn ovpn_initpki
```

Start everthing up
```
docker-compose up -d
```

Make a cert for the user:
```
export CLIENTNAME="your_client_name"
# with a passphrase (recommended)
docker-compose run --rm openvpn easyrsa build-client-full $CLIENTNAME

# Get the file back out of the image
docker-compose run --rm openvpn ovpn_getclient $CLIENTNAME > $CLIENTNAME.ovpn

```