FROM ubuntu:20.04

# Atualizando e instalando pacotes necessários
RUN apt-get update && apt-get install -y \
    apache2 \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Certificando-se de que o Apache é configurado corretamente para rodar em primeiro plano
RUN a2enmod rewrite
RUN service apache2 start

# Definindo a pasta de trabalho no contêiner
WORKDIR /var/www/html

# Expondo a porta 80
EXPOSE 80

# Copiando o conteúdo do diretório ./www do host para o contêiner
COPY ./www /var/www/html

# Comando para iniciar o Apache
CMD ["apache2ctl", "-D", "FOREGROUND"]
