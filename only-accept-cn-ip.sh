#! /bin/sh

# clear filter
iptables -t filter -F
# rm list cn
ipset -X cn
# Create the ipset list
ipset -N cn hash:net

for i in $(wget -qO- http://www.ipdeny.com/ipblocks/data/countries/cn.zone)
do
    ipset -A cn $i
done

# Restore iptables
/sbin/iptables-restore < iptables.firewall.rules

