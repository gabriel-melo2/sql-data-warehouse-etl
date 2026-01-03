CREATE PROCEDURE USP_ST_INPUT_EMPRESAS
AS
-----------------------------
-- Verify IF the Schemas exist
-----------------------------
IF OBJECT_ID('ST_EMPRESAS') IS NOT NULL DROP TABLE ST_EMPRESAS
	CREATE TABLE ST_EMPRESAS 
	(
	COD_EMPRESA   VARCHAR(15),
	NOME		  VARCHAR(100),
	NOME_FANTASIA VARCHAR(100)
	)

-----------------------------
-- Clean the Stage Area
-----------------------------
TRUNCATE TABLE ST_EMPRESAS

-----------------------------
-- INSERT INTO STAGE AREA
-----------------------------
INSERT INTO ST_EMPRESAS
 (
 COD_EMPRESA,
 NOME,
 NOME_FANTASIA
 )

 SELECT EMPRESA_USUARIA,
 NOME,
 NOME_FANTASIA
 FROM PBS_PROCFIT_DADOS.dbo.EMPRESAS_USUARIAS