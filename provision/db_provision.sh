#!/bin/bash

# Definindo o modo não interativo para evitar prompts
export DEBIAN_FRONTEND=noninteractive

# Atualizando o sistema
apt-get update -y
apt-get upgrade -y

# Instalando o MySQL e dependências necessárias
apt-get install -y mysql-server mysql-client

# Configurando o MySQL para iniciar automaticamente
systemctl enable mysql
systemctl start mysql

# Configuração de segurança básica do MySQL
mysql_secure_installation <<EOF

y
rootpassword
rootpassword
y
y
y
y
EOF

# Configurando o MySQL para aceitar conexões externas (remotas)
sed -i 's/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

# Reiniciando o MySQL para aplicar a configuração de acesso remoto
systemctl restart mysql

# Criando banco de dados e usuário
mysql -u root -prootpassword <<EOF
CREATE DATABASE conecta_work;
CREATE USER 'app_user'@'%' IDENTIFIED BY 'app_password';
GRANT ALL PRIVILEGES ON conecta_work.* TO 'app_user'@'%';
FLUSH PRIVILEGES;
EOF

# Finalizando provisionamento
echo "Provisionamento do banco de dados completo"
