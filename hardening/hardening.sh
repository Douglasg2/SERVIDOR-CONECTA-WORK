#!/bin/bash

# Atualizando o sistema
echo "Atualizando o sistema..."
sudo apt update -y && sudo apt upgrade -y

# Remover pacotes desnecessários
echo "Removendo pacotes desnecessários..."
sudo apt autoremove -y

# Desabilitar serviços desnecessários
echo "Desabilitando serviços desnecessários..."
sudo systemctl disable avahi-daemon.service
sudo systemctl stop avahi-daemon.service
sudo systemctl disable cups.service
sudo systemctl stop cups.service

# Configurando o firewall (UFW) para apenas liberar as portas essenciais
echo "Configurando o firewall..."
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 80/tcp      # Para HTTP
sudo ufw allow 443/tcp     # Para HTTPS
sudo ufw allow 2222/tcp    # Para SSH (porta personalizada)
sudo ufw enable

# Configuração do SSH para maior segurança
echo "Configurando o SSH..."
# Alterando a porta do SSH
sudo sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config
# Desabilitando o login como root via SSH
sudo sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
# Habilitando autenticação por chave pública
sudo sed -i 's/^PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
# Reiniciando o serviço SSH para aplicar as alterações
sudo systemctl restart sshd

# Segurança do MySQL
echo "Aplicando hardening no MySQL..."
# Configurando o MySQL para bloquear acesso remoto ao usuário root
sudo mysql_secure_installation

# Desabilitar acesso remoto ao usuário root
echo "Desabilitando acesso remoto ao usuário root no MySQL..."
sudo mysql -u root -e "UPDATE mysql.user SET Host='localhost' WHERE User='root';"
sudo mysql -u root -e "FLUSH PRIVILEGES;"

# Remover usuários e bancos de dados desnecessários no MySQL
echo "Removendo bancos de dados e usuários desnecessários..."
sudo mysql -u root -e "DROP DATABASE IF EXISTS test;"
sudo mysql -u root -e "DELETE FROM mysql.user WHERE User='';"
sudo mysql -u root -e "FLUSH PRIVILEGES;"

# Configuração de segurança do Apache
echo "Configurando segurança do Apache..."
# Desabilitando módulos desnecessários
sudo a2dismod status
sudo a2dismod autoindex
# Configurações de headers de segurança
sudo bash -c 'cat > /etc/apache2/conf-available/security.conf << EOF
ServerTokens Prod
ServerSignature Off
TraceEnable Off
Header always set X-Content-Type-Options "nosniff"
Header always set X-XSS-Protection "1; mode=block"
Header always set X-Frame-Options "SAMEORIGIN"
EOF'
sudo a2enconf security
sudo systemctl restart apache2

# Habilitar logs de erros detalhados no Apache
echo "Habilitando logs de erros detalhados no Apache..."
sudo sed -i 's/^ErrorLog.*/ErrorLog ${APACHE_LOG_DIR}\/error.log/' /etc/apache2/sites-available/000-default.conf
sudo sed -i 's/^LogLevel.*/LogLevel warn/' /etc/apache2/apache2.conf
sudo systemctl restart apache2

# Habilitar e configurar o Fail2Ban para proteger contra tentativas de login indevidas
echo "Instalando e configurando o Fail2Ban..."
sudo apt install -y fail2ban
sudo systemctl enable fail2ban
sudo systemctl start fail2ban
# Configuração de fail2ban básica
echo -e "[DEFAULT]\nmaxretry = 3\nbantime = 600" | sudo tee /etc/fail2ban/jail.local

# Habilitar logs detalhados de falhas de login (fail2ban)
echo "Configurando logs de falhas no fail2ban..."
sudo bash -c 'cat > /etc/fail2ban/filter.d/ssh.conf << EOF
[Definition]
failregex = ^%(__prefix_line)sFailed password for .* from <HOST> port .*
ignoreregex =
EOF'

# Configurações adicionais de segurança
echo "Aplicando configurações adicionais de segurança..."
# Desabilitar o kernel em ping de ICMP
echo "1" | sudo tee /proc/sys/net/ipv4/icmp_echo_ignore_all

# Atualizar permissões e configurando as permissões de arquivos sensíveis
echo "Ajustando permissões de arquivos e diretórios..."
sudo chmod 700 /etc/ssh/
sudo chmod 600 /etc/ssh/sshd_config
sudo chown root:root /etc/ssh/sshd_config

# Confirmando o status de serviços
echo "Confirmando o status dos serviços..."
sudo ufw status
sudo systemctl status fail2ban
sudo systemctl status apache2

# Finalizando o hardening
echo "Hardening do servidor Conecta Work completo!"
