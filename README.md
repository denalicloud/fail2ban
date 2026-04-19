## centralized Fail2ban service

### ip-blacklist

ip-blacklist.txt contains all IPs to block. one for each line. In order to automatically block when system reboots, there is new unit to setup. You should avoid to double block both in kernel route and UFW. so

```
# What is it really banned? in route or UFW
ufw status numbered | grep -c "Fail2Ban"
ip route show type unreachable | wc -l
```

flush everything is actually banned with route

```
# show what is unreachable on route
ip route show type unreachable
```

Now flush

```
# Flush unreachable
ip route flush type unreachable

# Verify
ip route show type unreachable | wc -l
```

Now you can activate the fail2ban centralized ban by activating the unit

```
fail2ban-load-blacklist.service
```

remember to deactivate

```
ip-blacklist-persistent-service.service
```


