**Projeto Data Warehouse em SQL Server**
**Visão Geral**

Este projeto tem como objetivo demonstrar a construção de um Data Warehouse utilizando SQL Server, aplicando conceitos de ETL, modelagem dimensional e boas práticas de organização de dados, simulando um cenário real corporativo de BI.

O projeto contempla:
Separação clara entre Banco de Stage e Banco de Data Warehouse
Uso de procedures SQL para carga de dados
Modelo dimensional (Star Schema)
Estrutura preparada para automação e expansão

**Arquitetura do Projeto**

**Fluxo de dados implementado:**
Fonte de Dados
   ↓
Banco STAGE (tratamento e padronização)
   ↓
Procedures de carga (ETL em SQL)
   ↓
Data Warehouse (modelo dimensional)

**Estrutura de Bancos**
**Banco STAGE**
Responsável por armazenar os dados tratados provenientes das fontes operacionais.
Neste projeto, o Stage expõe os dados por meio de VIEWS, garantindo padronização e desacoplamento das fontes.

Exemplo:
VW_D_CLIENTES

**Banco DATA WAREHOUSE**
Responsável por armazenar os dados consolidados, prontos para análise e consumo em ferramentas de BI.

**Modelo adotado:** Dimensional (Star Schema)

**Modelagem Dimensional**
**Dimensões:**
D_CLIENTE
D_PRODUTO
D_EMPRESA
D_VENDEDOR

**Fato**
F_VENDAS

🔎 Neste repositório, a Dimensão Cliente é apresentada como exemplo completo de implementação.
O mesmo padrão de estrutura e carga foi aplicado às demais dimensões e à tabela fato.

**Estratégia de Carga (ETL)**
**Tipo de carga**

Carga Full
Estratégia: TRUNCATE + INSERT

Essa abordagem foi escolhida por:
Simplicidade

Facilidade de reprocessamento

Confiabilidade em ambientes controlados

Exemplo de Implementação – Dimensão Cliente
📄 📊 Projeto Data Warehouse em SQL Server
📌 Visão Geral

Este projeto tem como objetivo demonstrar a construção de um Data Warehouse utilizando SQL Server, aplicando conceitos de ETL, modelagem dimensional e boas práticas de organização de dados, simulando um cenário real corporativo de BI.

O projeto contempla:

Separação clara entre Banco de Stage e Banco de Data Warehouse

Uso de procedures SQL para carga de dados

Modelo dimensional (Star Schema)

Estrutura preparada para automação e expansão

🏗️ Arquitetura do Projeto

Fluxo de dados implementado:

Fonte de Dados
   ↓
Banco STAGE (tratamento e padronização)
   ↓
Procedures de carga (ETL em SQL)
   ↓
Data Warehouse (modelo dimensional)

🗂️ Estrutura de Bancos
📦 Banco STAGE

Responsável por armazenar os dados tratados provenientes das fontes operacionais.
Neste projeto, o Stage expõe os dados por meio de VIEWS, garantindo padronização e desacoplamento das fontes.

Exemplo:

VW_D_CLIENTES

📊 Banco DATA WAREHOUSE

Responsável por armazenar os dados consolidados, prontos para análise e consumo em ferramentas de BI.

Modelo adotado: Dimensional (Star Schema)

📐 Modelagem Dimensional
Dimensões

D_CLIENTE

D_PRODUTO

D_EMPRESA

D_VENDEDOR

Fato

F_VENDAS

🔎 Neste repositório, a Dimensão Cliente é apresentada como exemplo completo de implementação.
O mesmo padrão de estrutura e carga foi aplicado às demais dimensões e à tabela fato.

🔄 Estratégia de Carga (ETL)
Tipo de carga

Carga Full

Estratégia: TRUNCATE + INSERT

**Essa abordagem foi escolhida por:**
Simplicidade
Facilidade de reprocessamento
Confiabilidade em ambientes controlados

**Exemplo de Implementação – Dimensão Cliente**
**Procedure:** USP_FULL_D_CLIENTE

**Lógica aplicada:**
Verifica se a tabela de dimensão existe
Cria a tabela caso não exista
Limpa completamente a dimensão
Insere os dados a partir da VIEW do Stage

**Código SQL**
CREATE PROCEDURE USP_FULL_D_CLIENTE 
AS
BEGIN

    -- CRIA TABELA CASO NÃO EXISTA
    IF OBJECT_ID('D_CLIENTE') IS NULL
    BEGIN
        CREATE TABLE D_CLIENTE
        (
            COD_CLIENTE    NUMERIC(15)   PRIMARY KEY,
            NOME           VARCHAR(160),
            NOME_FANTASIA  VARCHAR(80),
            CLASSSIFICACAO VARCHAR(160),
            CIDADE         VARCHAR(80),
            ESTADO         VARCHAR(80),
            UF             CHAR(2)
        )
    END

    -- LIMPA TABELA DE DIMENSÃO
    TRUNCATE TABLE D_CLIENTE

    -- POPULA DIMENSÃO
    INSERT INTO D_CLIENTE
    SELECT *
    FROM PBS_PROCFIT_ST.DBO.VW_D_CLIENTES

END

**Execução da Procedure**
EXEC USP_FULL_D_CLIENTE;


Essa procedure pode ser facilmente orquestrada por ferramentas de agendamento como SQL Server Agent ou pipelines de dados.
✅ Boas Práticas Aplicadas
Separação entre Stage e Data Warehouse
Uso de VIEWS no Stage para padronização
Procedures reutilizáveis
Carga reprocessável
Estrutura escalável para novas dimensões e fatos
Código organizado e documentado

**Evoluções Futuras**
Implementação de carga incremental
Integração com ferramentas de BI

**Tecnologias Utilizadas**
SQL Server
Modelagem Dimensional
ETL via Stored Procedures

📌 **Considerações Finais**
Este projeto foi desenvolvido com foco em clareza, organização e aplicabilidade prática, simulando um ambiente real de Data Warehouse utilizado em cenários corporativos de BI.Procedure: USP_FULL_D_CLIENTE
