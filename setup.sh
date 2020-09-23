apt-get update

# iptable
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
apt-get install -y iptables-persistent
firewall.sh

# install dev
apt-get install -y ruby
apt-get install -y ruby-dev
gem install bundler jekyll

# snapd / certbot
apt-get remove certbot
apt install -y snapd
snap install --classic certbot

# docker
apt-get install -y docker.io
apt-get install -y docker-compose
systemctl start docker
systemctl enable docker

apt-get install -y openvpn openvpn-systemd-resolved
ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

# For speedtest
apt-get install gnupg1 apt-transport-https -y
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 379CE192D401AB61
export DEB_DISTRO=$(lsb_release -sc)
echo "deb https://ookla.bintray.com/debian ${DEB_DISTRO} main" | sudo tee  /etc/apt/sources.list.d/speedtest.list

sudo apt-get update
apt-get install speedtest
