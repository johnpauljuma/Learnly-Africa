#!/bin/bash

# Simple script to install Docker, enable it, and run Apache with a custom page (Amazon Linux 2 / CentOS)

echo "Updating system..."
sudo yum update -y

echo "Installing Docker..."
sudo amazon-linux-extras install docker -y || sudo yum install -y docker

echo "Starting Docker..."
sudo systemctl start docker

echo "Enabling Docker to start on boot..."
sudo systemctl enable docker

echo "Adding ec2-user to docker group (optional)..."
sudo usermod -aG docker ec2-user

echo "Pulling Apache (httpd) image..."
sudo docker pull httpd

echo "Creating a custom webpage..."
echo "<h1>Welcome to Learnly Server</h1>" > index.html

echo "Running Apache container with custom page..."
sudo docker run -d --name my-apache -p 80:80 -v $(pwd)/index.html:/usr/local/apache2/htdocs/index.html httpd

# Get public IP address using ifconfig.me
IP=$(curl -s ifconfig.me)

echo "----------------------------------"
echo "Apache is running in Docker!"
echo "Visit: http://$IP"
echo "----------------------------------"
