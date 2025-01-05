#!/bin/bash

# Definindo o modo não interativo para evitar prompts
export DEBIAN_FRONTEND=noninteractive

# Atualizando o sistema
apt-get update -y
apt-get upgrade -y

# Instalando Docker e Docker Compose
apt-get install -y docker.io docker-compose

# Habilitando o Docker para iniciar automaticamente
systemctl enable docker
systemctl start docker

# Configuração de segurança do sistema (Hardening)

## Configurando firewall com UFW
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow http
ufw allow https
ufw enable

## Instalando fail2ban para proteger contra ataques de força bruta
apt-get install -y fail2ban

## Desabilitando login de root via SSH
sed -i 's/^PermitRootLogin .*/PermitRootLogin no/' /etc/ssh/sshd_config
systemctl restart sshd

## Configurando atualizações automáticas
apt-get install -y unattended-upgrades
dpkg-reconfigure --priority=low unattended-upgrades

# Iniciando os contêineres
cd /vagrant
docker-compose up -d

# Finalizando provisionamento
echo "Provisionamento completo"
