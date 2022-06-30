#!/bin/bash

if [ $# -lt 3 ]; then
  echo "Argument manquant: <url_console_voulue> <username_console> <password>"
  exit 1
fi
url=$1
username=$2
password=$3
htpasswd -bc auth_file $2 $3
encoded_auth=$(cat auth_file|base64)
values_file="values_final.yaml"

echo -e "host: $url\nauth: $encoded_auth" > $values_file

cat $values_file
helm upgrade --install origin-console -f $values_file . -norigin-console 
rm auth_file $values_file
