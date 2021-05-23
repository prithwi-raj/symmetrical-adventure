#!/bin/bash
# prepare container host

#variables used in script:

echo "Installing docker ..."

# update your existing list of packages
sudo apt update

# install a few prerequisite packages which let apt use packages over HTTPS
sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

# Then add the GPG key for the official Docker repository to your system
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add the Docker repository to APT sources
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# update the package database with the Docker packages from the newly added repo
sudo apt update

# Make sure you are about to install from the Docker repo instead of the default Ubuntu repo
apt-cache policy docker-ce

# install Docker
sudo apt install -y docker-ce docker-ce-cli containerd.io
sudo systemctl enable docker
sudo systemctl enable containerd
#docker version


echo "Adding user to the 'docker' group"
sudo groupadd docker
sudo usermod -aG docker ${USER}
#su - ${USER}
#id -nG
newgrp docker

## For AWS image
# sudo gpasswd -a $USER docker
# newgrp docker

# Required to remove warning in Redis container
sudo sysctl vm.overcommit_memory=1

echo "Installing Docker Compose ..."
# sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose && docker-compose --version
sudo apt  install -y docker-compose

echo "Preparing GIT repo ..."
sudo apt install -y git
git config --global credential.helper store

echo "Initial preparation completed."

# clone git repo

