apt-get update -y
apt-get install -y docker.io git openvpn iptables-persistent
mkdir -p /data/docker

# Network adapter : eno1
############# Modify firewall rulese
# Accept loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Accept input etablished/related connection
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Accept output etablished connection
iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED -j ACCEPT

# Allow SSH
iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT

# Drop INPUT / Accept OUTPUT
iptables -A INPUT -i eno1 -j DROP
iptables -A OUTPUT -o eno1 -j ACCEPT

############# Save firewall rules
netfilter-persistent save
