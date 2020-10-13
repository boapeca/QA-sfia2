#!/bin/bash

curl https://get.docker.com | sudo bash

sudo usermod -aG docker $(whoami)

sudo chmod 666 /var/run/docker.sock

sudo systemctl restart docker

sudo curl -L "https://github.com/docker/compose/releases/download/1.27.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

