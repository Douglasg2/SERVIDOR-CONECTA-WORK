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





