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
docker-compose up -d openvpn

```