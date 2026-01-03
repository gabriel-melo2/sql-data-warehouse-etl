## **SQL Server Data Warehouse Project**

## **Overview**
This project demonstrates the design and implementation of a Data Warehouse using SQL Server, applying ETL concepts, dimensional modeling, and data organization best practices, simulating a real-world corporate BI scenario.

## **The project includes:**
Clear separation between Stage Database and Data Warehouse
Use of SQL stored procedures for data loading
Dimensional model (Star Schema)
Architecture designed for automation and scalability
Project Architecture

## **Implemented data flow:**
Source Systems
↓
STAGE Database (data cleansing and standardization)
↓
Load Procedures (ETL in SQL)
↓
Data Warehouse (dimensional model)

## **Database Structure**

**STAGE Database**
Responsible for storing cleansed and standardized data extracted from operational source systems.
In this project, the Stage layer exposes data through VIEWS, ensuring data consistency and decoupling from source systems.

**Example:**
VW_D_CLIENTES

**DATA WAREHOUSE Database**
Responsible for storing consolidated data, ready for analytical consumption and BI tools.

**Adopted model:** Dimensional (Star Schema)
Dimensional Modeling

**Dimensions:**
D_CLIENTE
D_PRODUTO
D_EMPRESA
D_VENDEDOR

**Fact Table:**
F_VENDAS

In this repository, the Customer Dimension is presented as a complete implementation example.
The same structural and loading pattern was applied to all other dimensions and the fact table.

ETL Load Strategy
Load type
Full Load

**Strategy:** TRUNCATE + INSERT

## **This approach was chosen due to:**
Simplicity
Ease of reprocessing
Reliability in controlled environments

Implementation Example – Customer Dimension

**Procedure:** USP_FULL_D_CLIENTE

## **Applied logic:**
Checks whether the dimension table exists
Creates the table if it does not exist
Fully clears the dimension data
Loads data from the Stage VIEW
SQL Code

CREATE PROCEDURE USP_FULL_D_CLIENTE 
AS
BEGIN

    -- CREATE TABLE IF IT DOES NOT EXIST
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

    -- CLEAR DIMENSION TABLE
    TRUNCATE TABLE D_CLIENTE

    -- LOAD DIMENSION DATA
    INSERT INTO D_CLIENTE
    SELECT *
    FROM PBS_PROCFIT_ST.DBO.VW_D_CLIENTES
END


## **Procedure Execution**

EXEC USP_FULL_D_CLIENTE;


This procedure can be easily orchestrated using scheduling tools such as SQL Server Agent or external data pipelines.

## **Applied Best Practices**
Clear separation between Stage and Data Warehouse
Use of Stage VIEWS for data standardization
Reusable stored procedures
Reprocessable load strategy
Scalable structure for new dimensions and fact tables
Organized and well-documented SQL code
Future Enhancements
Incremental load implementation
Integration with BI tools
Technologies Used
SQL Server
Dimensional Modeling
ETL using Stored Procedures

## **Final Considerations**
This project was developed with a strong focus on clarity, organization, and practical applicability, simulating a real-world corporate Data Warehouse environment commonly used in Business Intelligence scenarios.
