CREATE DATABASE IF NOT EXISTS conecta_work;
CREATE USER 'app_user'@'%' IDENTIFIED BY 'app_password';
GRANT ALL PRIVILEGES ON conecta_work.* TO 'app_user'@'%';
FLUSH PRIVILEGES;
