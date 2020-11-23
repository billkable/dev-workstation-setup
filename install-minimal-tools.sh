#!/bin/bash

# Create workspace
mkdir -p ~/workspace
cd ~/workspace

# Prep repos
sudo apt install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt update
sudo apt upgrade -y

sudo apt install openjdk-11-jdk-headless jq curl wget xclip -y
sudo apt install gnome-session gnome-terminal gnome-tweaks -y
sudo apt install ubuntu-desktop-minimal -y
sudo apt install docker-ce docker-ce-cli containerd.io -y
sudo apt install zsh -y

# Snaps
sudo snap install --classic microk8s
sudo snap install --classic kubectl
sudo snap install --classic code
sudo snap install --classic postman
sudo snap install --classic intellij-idea-ultimate

# Configure docker
sudo groupadd docker
sudo usermod -aG docker ubuntu

# Configure microk8s
mkdir ~/.kube
sudo microk8s enable rbac dns storage
sudo microk8s config > ~/.kube/config
sudo usermod -aG microk8s ubuntu
sudo chown -fR ubuntu ~/.kube
kubectl apply -f https://projectcontour.io/quickstart/contour.yaml
