# Peerplays Docker

## Docker compose

Edit docker-compose and do

```
# You can maintain the image from PBSA directly
1) git clone https://github.com/peerplays-network/peerplays.git or git fetch if it already exists
2) cd peerplays
3) Mainnet: git checkout tags/1.4.4 || Testnet: git checkout tags/test-1.4.5
4) docker build --tag peerplays-network:test-1.4.5 .
5) certbot
6) edit nginx copyover.sh and enter your path/FQDN, cp default.conf.example to default.conf and edit with FQDN
7) run ./copyover.sh
7) ./restart.sh
```
