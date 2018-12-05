#! /bin/sh

# clear filter
iptables -t filter -F
# rm list cn
ipset -X cn
# Create the ipset list
ipset -N cn hash:net

# add local ip
for i in $(ip a | grep 'inet ' | awk '{print $2}')
do
    ipset -A cn $i
done

# add cn ip
for i in $(wget -qO- http://www.ipdeny.com/ipblocks/data/countries/cn.zone)
do
    ipset -A cn $i
done

# Restore iptables
/sbin/iptables-restore < iptables.firewall.rules

