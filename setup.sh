sudo apt-get update

# iptable
apt-get install -y iptables-persistent
firewall.sh

# docker
apt-get install -y docker.io
systemctl start docker
systemctl enable docker

apt-get install -y openvpn


# For speedtest
apt-get install gnupg1 apt-transport-https -y
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 379CE192D401AB61
export DEB_DISTRO=$(lsb_release -sc)
echo "deb https://ookla.bintray.com/debian ${DEB_DISTRO} main" | sudo tee  /etc/apt/sources.list.d/speedtest.list

sudo apt-get update
apt-get install speedtest
