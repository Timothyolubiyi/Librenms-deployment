#!/bin/bash


# install Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
> /etc/apt/sources.list.d/docker.list
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io


# install docker-compose plugin
apt-get install -y jq
mkdir -p /usr/local/lib/docker/cli-plugins
DOCKER_COMPOSE_VERSION="v2.20.2"
curl -SL "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-linux-x86_64" -o /usr/local/lib/docker/cli-plugins/docker-compose
chmod +x /usr/local/lib/docker/cli-plugins/docker-compose


# enable and start docker
systemctl enable docker
systemctl start docker


# create directories for LibreNMS
mkdir -p /opt/librenms
cd /opt/librenms


# write a docker-compose.yml
cat > docker-compose.yml <<'EOF'
version: '3.7'


services:
db:
image: mariadb:10.5
container_name: librenms-db
environment:
- MYSQL_ROOT_PASSWORD=${Sentient123&}
- MYSQL_DATABASE=librenms
- MYSQL_USER=Sentient-librenms
- MYSQL_PASSWORD=${Sentient123&}
volumes:
- db-data:/var/lib/mysql
restart: unless-stopped


librenms:
image: librenms/librenms:latest
container_name: librenms-app
depends_on:
- db
ports:
- "80:80"
- "443:443"
environment:
- DB_HOST=db
- DB_USER=librenms
- DB_PASS=${Sentient123&}
- DB_NAME=librenms
volumes:
- librenms-data:/data
restart: unless-stopped


volumes:
db-data:
librenms-data:
EOF


# create .env with passwords (cloud-init does not expand variables in heredoc above)
cat > .env <<EOF
LIBRENMS_DB_ROOT_PASSWORD=${Sentient123&}
LIBRENMS_DB_PASSWORD=${Sentient123&:-ChangeMeDBPass}
EOF


# ensure permissions and start
chown -R ubuntu:ubuntu /opt/librenms || true
/usr/local/lib/docker/cli-plugins/docker-compose up -d


# finished