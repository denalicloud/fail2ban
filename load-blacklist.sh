#!/bin/bash

# Load IPs list from ip-blacklist.txt and
# ban with ip-blacklist.conf jail

fail2ban-client reload

while read ip; do
  [[ -z "$ip" || "$ip" == \#* ]] && continue
  fail2ban-client set ip-blacklist banip "$ip"
done < /etc/fail2ban/ip-blacklist.txt
