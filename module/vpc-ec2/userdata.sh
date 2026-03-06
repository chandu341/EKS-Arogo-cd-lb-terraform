#!/bin/bash
set -e

# Log output
exec > /var/log/user-data.log 2>&1

echo "===== Updating system ====="
sudo apt update -y
sudo apt upgrade -y

echo "===== Installing dependencies ====="
sudo apt install -y curl unzip tar apt-transport-https ca-certificates gnupg lsb-release

############################################################
# Install AWS CLI v2 (Latest)
############################################################
echo "===== Installing AWS CLI v2 ====="

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -o awscliv2.zip
sudo ./aws/install

aws --version

############################################################
# Install kubectl (Latest stable version dynamically)
############################################################
echo "===== Installing kubectl ====="

KUBECTL_VERSION=$(curl -s https://dl.k8s.io/release/stable.txt)

curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

kubectl version --client

############################################################
# Install Helm (Official method - recommended)
############################################################
echo "===== Installing Helm ====="

curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

helm version

############################################################
# Install eksctl (Latest)
############################################################
echo "===== Installing eksctl ====="

ARCH=amd64
PLATFORM=$(uname -s)_$ARCH

curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_${PLATFORM}.tar.gz"

tar -xzf eksctl_${PLATFORM}.tar.gz
sudo mv eksctl /usr/local/bin/

eksctl version

echo "===== Installation Completed Successfully ====="