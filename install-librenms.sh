#!/bin/bash

set -e

echo "=== Installing Docker ==="
apt-get update -y
apt-get install -y ca-certificates curl gnupg

mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
    | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
> /etc/apt/sources.list.d/docker.list

apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io

echo "=== Installing Docker Compose v2 plugin ==="
mkdir -p /usr/local/lib/docker/cli-plugins/
curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 \
  -o /usr/local/lib/docker/cli-plugins/docker-compose
chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

systemctl enable docker
systemctl start docker

echo "=== Preparing LibreNMS directories ==="
mkdir -p /opt/librenms
cd /opt/librenms

echo "=== Creating .env file ==="
cat > .env <<EOF
MYSQL_ROOT_PASSWORD=Sentient123!
MYSQL_DATABASE=librenms
MYSQL_USER=librenms
MYSQL_PASSWORD=Sentient123!
EOF

echo "=== Creating docker-compose.yml ==="
cat > docker-compose.yml <<'EOF'
services:

  db:
    image: mariadb:10.5
    container_name: librenms-db
    restart: unless-stopped
    env_file:
      - .env
    environment:
      - MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
      - MYSQL_DATABASE=${MYSQL_DATABASE}
      - MYSQL_USER=${MYSQL_USER}
      - MYSQL_PASSWORD=${MYSQL_PASSWORD}
    volumes:
      - db-data:/var/lib/mysql

  librenms:
    image: librenms/librenms:latest
    container_name: librenms-app
    restart: unless-stopped
    depends_on:
      - db
    env_file:
      - .env
    environment:
      - DB_HOST=db
      - DB_NAME=${MYSQL_DATABASE}
      - DB_USER=${MYSQL_USER}
      - DB_PASS=${MYSQL_PASSWORD}
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - librenms-data:/data

volumes:
  db-data:
  librenms-data:
EOF

echo "=== Setting Permissions ==="
chmod -R 755 /opt/librenms
chown -R ubuntu:ubuntu /opt/librenms || true

echo "=== Starting LibreNMS Containers ==="
/usr/local/lib/docker/cli-plugins/docker-compose up -d

echo "=== LibreNMS Installation Completed ==="
echo "Access via: http://YOUR_PUBLIC_IP/"
echo "If behind AWS Load Balancer, point ALB → Target group → EC2 port 80"
