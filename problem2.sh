#!/bin/bash

while read LINE;
do
domain=$( echo $LINE|awk -F[/:] '{print $4}')
IP=$(dig $domain +short)
Status=$(curl  --output /dev/null --silent --head --write-out '%{http_code}\n' $LINE)
echo $domain "|" $IP "|" $Status |  jq -R -s -c 'split("\n")[:-1]'
done < domains.txt
