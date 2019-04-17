sudo apt-get update -y
sudo apt-get install -y docker.io git openvpn iptables-persistent
[ -d /data/docker ] || sudo mkdir -p /data/docker


# Network adapter : eno1
############# Modify firewall rules
# Accept loopback
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A OUTPUT -o lo -j ACCEPT

# Accept input etablished/related connection
sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Accept output etablished connection
sudo iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED -j ACCEPT

# Allow SSH
sudo iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT

# Drop INPUT / Accept OUTPUT
sudo iptables -A INPUT -i eno1 -j DROP
sudo iptables -A OUTPUT -o eno1 -j ACCEPT

############# Save firewall rules
sudo netfilter-persistent save
