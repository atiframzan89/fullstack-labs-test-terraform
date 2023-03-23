#!/bin/bash
set -x

echo "Nodejs package is installed"
curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
sudo apt install nodejs -y
echo "Installing pm2"
sudo npm install pm2 -g
echo "Creating direcotry fullstack-node-app"
mkdir -p /tmp/fullstack-node-app
sudo chown ubuntu:ubuntu /tmp/fullstack-node-app





