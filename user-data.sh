#!/bin/bash

sudo apt-get update
sudo apt-get install git

# install docker
 sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get --yes install docker-ce docker-ce-cli containerd.io docker-compose-plugin

# clone application
git clone --branch challenge-2 https://github.com/muhammetkoele/tf-labs-ec2-challenge.git
cd tf-labs-ec2-challenge/challenge-2

# build application image
sudo docker build -t challenge-2-image .

# run application container
sudo docker run  --env AWS_DEFAULT_REGION=eu-central-1 \
                 -d --name challenge-2-container -p 80:80 challenge-2-image
