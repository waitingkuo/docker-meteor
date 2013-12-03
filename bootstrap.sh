# Add docker in the apt source list
wget -qO- https://get.docker.io/gpg | apt-key add -
echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list

# Install Docker
apt-get update
apt-get install -y lxc-docker
