# Servidor Web Conecta Work

## Objetivo do Servidor

O projeto pelo qual o nosso servidor servidor será criado é o Conecta Work, um aplicativo onde é possível criar demandas de serviços a fim de encontrar um profissional que possa resolver esta demanda. O servidor será responsável por armazenar as informações dos usuários, processar demandas e propostas, e garantir que tudo aconteça de forma rápida e segura. O nosso objetivo é começar em Rubiataba onde possui aproximadamente 20 mil habitantes e esperamos inicialmente cerca de 500 usuários ativos, planejamos um servidor com capacidade suficiente para atender a essa demanda e que possa ser ampliado conforme o número de usuários crescer.

## 1 Planejamento do Hardware

### Processador:
- Modelo: Intel Xeon E5-2680 v4
- 14 núcleos e 28 threads.
- Frequência base: 2.4 GHz (Turbo Boost: 3.3 GHz).
- TDP: 120W.

**Justificativa:**
<br>
Oferece desempenho robusto para multitarefa e processamento intensivo. Ideal para gerenciamento de múltiplos contêineres, banco de dados e servidores web.

### Memória RAM:
- Quantidade: 32GB DDR4.
- 4 módulos de 8 GB (compatíveis com quad-channel na placa X99).
- Frequência suportada: até 2400 MHz (limitação do controlador de memória do Xeon).

**Justificativa:**
<br>
Oferece desempenho robusto para multitarefa e processamento intensivo. Ideal para gerenciamento de múltiplos contêineres, banco de dados e servidores web.

### Placa-Mãe:
- Modelo: X99-8 da Asus LGA 2011-3.
- Suporte a processadores Intel Xeon série E5-2600 v3/v4.
- 4 slots de RAM DDR4 (até 64 GB).
- 1 slot M.2 NVMe PCIe 3.0.
- Vários conectores PCIe para expansão (GPU, placas de rede etc.).

**Justificativa:**
<br>
Oferece compatibilidade total com o processador Xeon. Suporte a recursos modernos como SSDs NVMe e boa capacidade de expansão.

### Armazenamento:
- Modelo: SSD NVMe de 2 TB.
- Velocidade de leitura: 3.500 MB/s.
- Velocidade de gravação: 3.000 MB/s.

**Justificativa:**
<br>
Altíssima velocidade para carregamento de aplicativos e bancos de dados. Capacidade suficiente para hospedar aplicações, logs, backups e até arquivos estáticos.

### Fonte de Alimentação:
- Modelo: Fonte de 600W 80 Plus Bronze.
- O Xeon E5-2680 v4 tem um TDP de 120W.
- A placa-mãe, memória RAM e SSD consomem 50W adicionais.

**Justificativa:**
<br>
Reserva de energia suficiente para picos de consumo e possível expansão.

## 2 Estrutura do Projeto

### Estrutura de Pastas:

- `.vagrant`: Diretório usado pelo Vagrant para armazenar metadados das máquinas virtuais.
- `hardening`: Contém o script `hardening.sh` responsável pelo reforço das configurações de segurança no servidor.
- `vagrant`: Contém o script `web_provision.sh` usado para provisionar o servidor web.
- `wait-for-it`: Contém o script `wait-for-it.sh` para garantir que os serviços estejam prontos antes de iniciar o servidor.
- `www`: Contém o arquivo `index.html` para a página inicial do servidor.
- Arquivos principais:
  - `docker-compose.yml`: Configuração do Docker Compose para os serviços do servidor.
  - `Dockerfile`: Configuração do container Docker.
  - `init.sql`: Script de inicialização do banco de dados.
  - `Vagrantfile`: Arquivo de configuração do Vagrant para gerenciar as máquinas virtuais.

## 3 Requisitos para Execução

- **Software necessário:**
  - [Vagrant](https://www.vagrantup.com/) (versão mais recente).
  - [VirtualBox](https://www.virtualbox.org/) (versão compatível com o Vagrant).
  - [Docker](https://www.docker.com/) e [Docker Compose](https://docs.docker.com/compose/).



## 4 Instruções de Execução

1. Clone o repositório do projeto:
   ```bash
   git clone https://github.com/Douglasg2/SERVIDOR-CONECTA-WORK/blob/main/README.md
   cd conecta-work
   ```

2. Inicialize as máquinas virtuais com o Vagrant:
   ```bash
   vagrant up
   ```

3. Acesse a máquina virtual do servidor web:
   ```bash
   vagrant ssh web_server
   ```

4. Configure e inicie os serviços Docker:
   ```bash
   cd /vagrant
   docker-compose up -d
   ```

5. Acesse o servidor no navegador:
   ```
   http://localhost:80
   ```

## 5 Scripts Principais

### `hardening.sh`
- Local: `hardening/`
- Função: Implementa práticas de segurança no servidor, incluindo:
  - Configuração de firewall com `iptables`.
  - Desabilitação de serviços desnecessários.
  - Configuração de permissões de arquivos.

### `web_provision.sh`
- Local: `vagrant/`
- Função: Provisiona o ambiente web, instalando dependências necessárias e configurando o servidor.

### `wait-for-it.sh`
- Local: `wait-for-it/`
- Função: Aguarda a inicialização de serviços dependentes antes de iniciar o servidor.

## 6 Banco de Dados

- **Script de inicialização:** `init.sql`
- **Tecnologia utilizada:** MySQL
- **Estrutura básica:**
  - Configuração inicial incluída no script `init.sql`.
