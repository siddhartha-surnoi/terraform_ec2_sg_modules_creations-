#!/bin/bash
set -e

# Simple NGINX install and start script

# Detect OS
if [ -f /etc/os-release ]; then
  . /etc/os-release
  OS=$ID
else
  OS="unknown"
fi

echo "Detected OS: $OS"

# Install NGINX
if [[ "$OS" == "ubuntu" || "$OS" == "debian" ]]; then
  sudo apt-get update -y
  sudo apt-get install -y nginx

elif [[ "$OS" == "amzn" || "$OS" == "rhel" || "$OS" == "centos" ]]; then
  sudo yum install -y nginx || sudo amazon-linux-extras install -y nginx1
else
  echo "Unsupported OS: $OS"
  exit 1
fi

# Enable and start NGINX
sudo systemctl enable nginx
sudo systemctl start nginx

echo "✅ NGINX installed and started successfully!"
echo "You can verify by visiting: http://<your-server-ip>"
