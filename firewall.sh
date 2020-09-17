# Accept loopback
iptables -F INPUT
iptables -F OUTPUT
iptables -F FORWARD

iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Accept input etablished/related connection
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Accept output etablished connection
iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED -j ACCEPT

# Accept ICMP
iptables -A INPUT -p icmp -j ACCEPT

# Allow SSH
iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT

#DOCKER-USER  all  --  anywhere             anywhere
#DOCKER-ISOLATION-STAGE-1  all  --  anywhere             anywhere


# Drop INPUT / Accept OUTPUT
iptables -A INPUT -i eno1 -j DROP
iptables -A OUTPUT -o eno1 -j ACCEPT

############# Save firewall rules
netfilter-persistent save

