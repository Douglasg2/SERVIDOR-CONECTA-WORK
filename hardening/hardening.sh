#!/bin/bash

# Atualizando o sistema
echo "Atualizando o sistema..."
sudo apt update -y && sudo apt upgrade -y && sudo apt dist-upgrade -y

# Remover pacotes desnecessários
echo "Removendo pacotes desnecessários..."
sudo apt autoremove -y

# Desabilitar serviços desnecessários
echo "Desabilitando serviços desnecessários..."
sudo systemctl disable avahi-daemon.service
sudo systemctl stop avahi-daemon.service
sudo systemctl disable cups.service
sudo systemctl stop cups.service

# Configuração do firewall (UFW)
echo "Configurando o firewall..."
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22/tcp      # Porta padrão para SSH
sudo ufw allow 80/tcp      # Para HTTP
sudo ufw allow 443/tcp     # Para HTTPS
sudo ufw enable

# Configuração do SSH
echo "Mantendo configuração padrão do SSH..."
sudo systemctl restart sshd

# Aplicando hardening no MySQL (sem interação)
echo "Aplicando hardening no MySQL..."
sudo mysql -u root -e "UPDATE mysql.user SET Host='localhost' WHERE User='root';"  # Limitar o acesso do root para localhost
sudo mysql -u root -e "DROP DATABASE IF EXISTS test;"  # Remover banco de dados de teste
sudo mysql -u root -e "DELETE FROM mysql.user WHERE User='';"  # Remover usuários vazios
sudo mysql -u root -e "FLUSH PRIVILEGES;"  # Atualizar as permissões no MySQL

# Configuração de segurança do Apache
sudo apt update
sudo apt install -y apache2
echo "Configurando segurança do Apache..."
sudo a2dismod status  # Desabilitar o módulo de status
sudo a2dismod autoindex  # Desabilitar o módulo autoindex
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

# Instalar e configurar o Fail2Ban
echo "Instalando e configurando o Fail2Ban..."
sudo apt install -y fail2ban
sudo systemctl enable fail2ban
sudo systemctl start fail2ban
echo -e "[DEFAULT]\nmaxretry = 3\nbantime = 600" | sudo tee /etc/fail2ban/jail.local

# Ajustar permissões de arquivos e diretórios sensíveis
echo "Ajustando permissões de arquivos e diretórios..."
sudo chmod 700 /etc/ssh/
sudo chmod 600 /etc/ssh/sshd_config
sudo chown root:root /etc/ssh/sshd_config

# Confirmando o status dos serviços
echo "Confirmando o status dos serviços..."
sudo ufw status
sudo systemctl status fail2ban
sudo systemctl status apache2

# Finalizando o hardening
echo "Hardening do servidor Conecta Work completo!"
