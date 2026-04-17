#!/bin/bash

# Remove IPs from kernel routing table (route unreachable)
# These were added by fail2ban route action

BLACKLIST="/etc/fail2ban/ip-blacklist.txt"

if [[ ! -f "$BLACKLIST" ]]; then
    echo "ERROR: blacklist file not found: $BLACKLIST"
    exit 1
fi

while read -r ip; do
    [[ -z "$ip" || "$ip" == \#* ]] && continue
    if ip route show type unreachable "$ip" 2>/dev/null | grep -q "$ip"; then
        ip route del unreachable "$ip"
        echo "REMOVED $ip from route unreachable"
    else
        echo "SKIP    $ip not in route unreachable"
    fi
done < "$BLACKLIST"

echo "Done."
