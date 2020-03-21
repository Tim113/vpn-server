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

# Settings in the cert
Once the cert has been made you want to add some more setting to it so that it will force all of the trafic to the pi hole.  Add the voloowing lines to the file.

Note that you may or may not what the `192.168.0.0` to be allowed through depending on your local network.  Also the DNS is set to the fixed local ip of the docker image running pi hole. 

```
# Allow local traffic to connect without vpn
route 192.168.0.0 255.255.0.0 net_gateway

# Force the trafic to my dns
dhcp-option DNS 10.5.0.4
block-outside-dns
```
