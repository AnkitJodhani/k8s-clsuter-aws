#!/bin/bash

sudo apt update -y

sudo swapoff -a

sudo hostnamectl set-hostname worker-2

# Command setup

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter


cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF


sudo sysctl --system


#############################-------------lets install & configure containerd--------------###################################

cd /tmp

wget https://github.com/containerd/containerd/releases/download/v1.6.24/containerd-1.6.24-linux-amd64.tar.gz

sudo tar Cxzvf /usr/local containerd-1.6.24-linux-amd64.tar.gz


wget https://raw.githubusercontent.com/containerd/containerd/main/containerd.service

sudo mkdir -p /usr/local/lib/systemd/system/

sudo mv containerd.service /usr/local/lib/systemd/system/containerd.service


sudo systemctl daemon-reload

sudo systemctl enable --now containerd


#############

wget https://github.com/opencontainers/runc/releases/download/v1.1.9/runc.amd64

sudo install -m 755 runc.amd64 /usr/local/sbin/runc


#############

wget https://github.com/containernetworking/plugins/releases/download/v1.3.0/cni-plugins-linux-amd64-v1.3.0.tgz

sudo mkdir -p /opt/cni/bin

sudo tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.3.0.tgz


sudo apt update -y




sudo mkdir -p /etc/containerd/

sudo chown ubuntu:root /etc/containerd

sudo containerd config default > /etc/containerd/config.toml

sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml

sudo systemctl restart containerd.service

sudo systemctl enable containerd.service


#############################-------------lets install Kubeadm, Kubelet & Kubectl --------------###################################

sudo apt-get update

sudo apt-get install -y apt-transport-https ca-certificates curl

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list


sudo apt-get update

sudo apt update -y

# Note $apt-cache madison kubeadm

sudo apt-get install -y kubelet=1.28.1-1.1 kubeadm=1.28.1-1.1 kubectl=1.28.1-1.1

sudo apt-mark hold kubelet kubeadm kubectl





