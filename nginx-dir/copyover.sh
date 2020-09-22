#!/bin/sh
usage="$(basename "$0") [FQDN]
-- copies over and arranges the certs from certbot

where:
	FQDN	Full qualified domain name of this server"

if [ -z "$1" ]; 
then
	echo "$usage"
else
echo beginning... moving old crt and key to .old
mv domain.crt domain.crt.old
cat /etc/letsencrypt/live/$1/cert.pem /etc/letsencrypt/live/$1/fullchain.pem > domain.crt
mv domain.key domain.key.old
cp /etc/letsencrypt/live/$1/privkey.pem domain.key
echo done
fi

