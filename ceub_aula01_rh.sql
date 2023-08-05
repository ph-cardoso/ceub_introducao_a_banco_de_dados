-- Author: Pedro Henrique Lima Cardoso
-- CEUB - Introdução à Banco de Dados

-- Drop database 'db_ceub_aula01_rh' if exists
DROP DATABASE IF EXISTS db_ceub_aula01_rh;

-- Create database 'db_ceub_aula01_rh' if not exists
CREATE DATABASE IF NOT EXISTS db_ceub_aula01_rh;

-- Use database 'db_ceub_aula01_rh'
USE db_ceub_aula01_rh;

-- Create table 'tb_funcionario'
CREATE TABLE tb_funcionario (
	matricula INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    dtNascimento DATE NOT NULL,
    salario DECIMAL(9, 2),
    codCargo INT NOT NULL,
    codDepartamento INT NOT NULL
);

-- Create table 'tb_cargo'
CREATE TABLE tb_cargo (
	codCargo INT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL
);

-- Create table 'tb_departamento'
CREATE TABLE tb_departamento (
	codDepartamento INT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL
);

-- FK CARGO - FUNCIONARIO
ALTER TABLE tb_funcionario
ADD CONSTRAINT fk_cargo
FOREIGN KEY (codCargo) REFERENCES tb_cargo(codCargo);

-- FK DEPARTAMENTO - FUNCIONARIO
ALTER TABLE tb_funcionario
ADD CONSTRAINT fk_departamento
FOREIGN KEY (codDepartamento) REFERENCES tb_departamento(codDepartamento);

-- Insert data in 'tb_cargo'
INSERT INTO tb_cargo (codCargo, descricao)
VALUES
(1, 'Enfermeiro(a)'),
(2, 'Administrador(a)'),
(3, 'Analista'),
(4, 'Engenheiro(a)'),
(5, 'Advogado(a)'),
(6, 'Gerente'),
(7, 'Executivo(a)');

-- Insert data in 'tb_departamento'
INSERT INTO tb_departamento (codDepartamento, descricao)
VALUES
(1, 'Enfermaria'),
(2, 'Administracao'),
(3, 'Informatica'),
(4, 'Engenharia'),
(5, 'Juridico'),
(6, 'Logistica'),
(7, 'Presidencia');

-- Insert data in 'tb_funcionario'
INSERT INTO tb_funcionario (matricula, nome, dtNascimento, salario, codCargo, codDepartamento)
VALUES
(1,'Ana Clara', '1977-07-05', 3000, 5, 1),
(2,'Patricia Azevedo', '1944-07-04', 4000, 1, 1),
(3,'Jose Maria', '1971-05-10', 6000, 3, 1),
(4,'Sonia Abrantes', '1979-05-29', 7000, 4, 1),
(5,'Valdir Reinaldo', '1960-09-22', 16000, 2, 2),
(6,'Jose Alberto', '1955-01-13', 15000, 2, 2);

-- Exercícios
-- 01) Listar registro(s) com 'codDepartamento = 2' na tabela 'tb_funcionario'
SELECT * FROM tb_funcionario WHERE codDepartamento = 2;

-- 02) Listar registro(s) com 'codCargo = 1' na tabela 'tb_funcionario'
SELECT * FROM tb_funcionario WHERE codCargo = 1;

-- 03) Remover registro com 'codCargo = 7' na tabela 'tb_cargo'
DELETE FROM tb_cargo WHERE codCargo = 7;

-- 04) Remover registro com 'codDepartamento = 7' na tabela 'tb_departamento'
DELETE FROM tb_departamento WHERE codDepartamento = 7;

-- 05) Alterar o salário do funcionário com matricula 1 para 6000
UPDATE tb_funcionario
SET salario = 6000.00
WHERE matricula = 1;

-- 06) Aumentar o salário de todos os funcionários em 5%
SET sql_safe_updates = 0; -- Disabling safe_update

UPDATE tb_funcionario
SET salario = salario * 1.05;

SET sql_safe_updates = 1; -- Enabling safe_update

-- 07) Listar os funcionários que possem salário > 5000
SELECT * FROM tb_funcionario WHERE salario > 5000.00;

-- 08) Listar funcionários(as) que são administradores(as)
SELECT * FROM tb_funcionario WHERE codCargo =  2;

-- 09) Listar funcionários(as) que trabalham na enfermaria
SELECT * FROM tb_funcionario WHERE codDepartamento =  1;

-- Predicados
-- Select all columns where nome starts with 'Jose'
SELECT * FROM tb_funcionario WHERE nome LIKE 'Jose%';

-- Select all columns where nome ends with 'Abrantes'
SELECT * FROM tb_funcionario WHERE nome LIKE '%Abrantes';

-- Select all columns where nome has last_name starting with 'A'
SELECT * FROM tb_funcionario WHERE nome LIKE '% A%';

-- 'AND' and 'OR' logical operators
-- Select all columns where employee has salary equal or above 5000.00 and codCargo = 4
SELECT * FROM tb_funcionario WHERE salario >= 5000.00 AND codCargo = 4;

-- Select all columns where employee has salary equal or below 5000.00 or codCargo = 4
SELECT * FROM tb_funcionario WHERE salario <= 5000.00 OR codCargo = 2;

-- Select all columns where employee codCargo = 1 or codCargo = 2
SELECT * FROM tb_funcionario WHERE codCargo = 1 OR codCargo = 2;

-- Select all columns where employee codCargo in [1, 4, 5]
SELECT * FROM tb_funcionario WHERE codCargo in (1, 4, 5);

-- Select all columns where employee codCargo in [1, 4, 5]
SELECT * FROM tb_funcionario WHERE codCargo in (1, 4, 5);

-- Select all columns where employee has salary between 5000.00 and 8000.00
SELECT * FROM tb_funcionario WHERE salario BETWEEN 5000.00 AND 8000.00;

-- ORDER BY
-- Select all columns of tb_funcionario ordered by codCargo in ascending order
SELECT * FROM tb_funcionario ORDER BY codCargo;

-- Select all columns of tb_funcionario ordered by codCargo and nome in ascending order
SELECT * FROM tb_funcionario ORDER BY codCargo, nome;

-- Select all columns of tb_funcionario ordered by codCargo in descending order
SELECT * FROM tb_funcionario ORDER BY codCargo DESC;

-- Select all distinct codDepartamento from tb_funcionario
SELECT DISTINCT codDepartamento FROM tb_funcionario;

-- Exercício

-- 01) Listar todos os funcionários que trabalham no departamento de “Administração”
SELECT * FROM tb_funcionario WHERE codDepartamento = 2;

-- 02) Listar todos os funcionários que possuem o nome que inicia com a letra “J”
SELECT * FROM tb_funcionario WHERE nome LIKE 'J%';

-- 03) Listar os cargos com código igual a 3 ou 4
SELECT * FROM tb_funcionario WHERE codCargo IN (3, 4);

-- 04) Listar os nomes funcionários em ordem alfabética
SELECT * FROM tb_funcionario ORDER BY nome;

-- 05) Listar os nomes funcionários em ordem alfabética decrescente
SELECT * FROM tb_funcionario ORDER BY nome DESC;

-- 06) Listar os três primeiros registros da tabela tb_departamento
SELECT * FROM tb_departamento LIMIT 3;

-- 07) Listar os funcionários que possuem salário entre R$ 5 mil e R$ 10 mil
SELECT * FROM tb_funcionario WHERE salario BETWEEN 5000.00 AND 10000.00;

-- 08) Listar os funcionários que possuem salário maior que R$ 10 mil ou menor que R$ 5 mil
SELECT * FROM tb_funcionario WHERE salario > 10000.00 OR salario < 5000.00;

-- 09) Listar os códigos de cargo existentes na tabela funcionário ordenados de maneira decrescente.
-- Não exiba códigos repetidos.
SELECT DISTINCT codCargo FROM tb_funcionario ORDER BY codCargo DESC;

-- Exercícios
-- 01) Listar a matrícula do funcionário, o nome do funcionário e o departamento no qual trabalha
SELECT
    f.matricula,
    f.nome,
    d.descricao AS departamento
FROM tb_funcionario f
INNER JOIN tb_departamento AS d ON f.codDepartamento = d.codDepartamento;

-- 02) Listar a matrícula do funcionário, o nome do funcionário e a descrição do cargo do funcionário
SELECT
    f.matricula,
    f.nome,
    c.descricao AS cargo
FROM tb_funcionario f
INNER JOIN tb_cargo AS c ON f.codCargo = c.codCargo;

-- 03) Listar a matrícula do funcionário, o nome do funcionário, a descrição do departamento no qual trabalha
-- e a descrição do cargo do funcionário
SELECT f.matricula,
       f.nome,
       d.descricao AS departamento,
       c.descricao AS cargo
FROM tb_funcionario f
INNER JOIN tb_departamento d ON f.codDepartamento = d.codDepartamento
INNER JOIN tb_cargo c ON f.codCargo = c.codCargo;

-- Exercícios
-- 01) Criar uma view que lista matricula, nome do funcionário e nome do departamento
CREATE VIEW vw_ex_01 AS
SELECT
    f.matricula,
    f.nome,
    d.descricao AS departamento
FROM tb_funcionario f
INNER JOIN tb_departamento AS d ON f.codDepartamento = d.codDepartamento;

SELECT * FROM vw_ex_01;

-- 02) Criar uma view que lista matricula, nome do funcionário, salário e nome
-- do cargo. A lista deve contemplar apenas funcionários com salário maior
-- ou igual a R$ 5.000,00.
CREATE VIEW vw_ex_02 AS
SELECT
    f.matricula,
    f.nome,
    f.salario,
    c.descricao AS cargo
FROM tb_funcionario f
INNER JOIN tb_cargo AS c ON f.codCargo = c.codCargo
WHERE f.salario >= 5000.00;

SELECT * FROM vw_ex_02;

-- 03) Criar uma view que lista matricula, nome do funcionário, salário e nome do
-- departamento. A lista deve contemplar apenas funcionários com salário
-- menor ou igual a R$ 5.000,00.
CREATE VIEW vw_ex_03 AS
SELECT
    f.matricula,
    f.nome,
    f.salario,
    d.descricao AS departamento
FROM tb_funcionario f
INNER JOIN tb_departamento AS d ON f.codDepartamento = d.codDepartamento
WHERE f.salario <= 5000.00;

SELECT * FROM vw_ex_03;

-- 04) Criar uma view que lista matricula, nome do funcionário, salário,
-- departamento e cargo.
CREATE VIEW vw_ex_04 AS
SELECT
    f.matricula,
    f.nome,
    f.salario,
    d.descricao AS departamento,
    c.descricao AS cargo
FROM tb_funcionario f
INNER JOIN tb_departamento AS d ON f.codDepartamento = d.codDepartamento
INNER JOIN tb_cargo AS c ON f.codCargo = c.codCargo;

SELECT * FROM vw_ex_04;

-- Manipulação de datas
-- Recuperar apenas o ano de uma data
SELECT nome, year(dtNascimento) AS anoNascimento
FROM tb_funcionario;

-- Recuperar apenas o mês de uma data
SELECT nome, month(dtNascimento) AS mesNascimento
FROM tb_funcionario;

-- Recuperar apenas o dia de uma data
SELECT nome, day(dtNascimento) AS diaNascimento
FROM tb_funcionario;

-- Recuperar nome, data de nascimento e a data atual
SELECT nome, dtNascimento, curdate() AS dataAtual
FROM tb_funcionario;

-- Recuperar nome, data de nascimento e a data/hora atual
SELECT nome, dtNascimento, now() AS dataHoraAtual
FROM tb_funcionario;

-- Recuperar nome, data de nascimento e idade
SELECT
    nome,
    dtNascimento,
    year(curdate()) - year(dtNascimento) AS idade
FROM tb_funcionario;

-- Recuperar nome, data de nascimento e idade (timestamp diff)
SELECT
    nome,
    dtNascimento,
    TIMESTAMPDIFF(YEAR, dtNascimento, curdate()) AS idade
FROM tb_funcionario;

-- Funções numéricas
-- SUM()
-- Recuperar a soma dos salários dos funcionários
SELECT SUM(salario) AS somaSalarios FROM tb_funcionario;

-- AVG()
-- Recuperar a média dos salários dos funcionários
SELECT AVG(salario) AS mediaSalarios FROM tb_funcionario;

-- MAX()
-- Recuperar o maior salário dos funcionários
SELECT MAX(salario) AS maiorSalario FROM tb_funcionario;

-- MIN()
-- Recuperar o menor salário dos funcionários
SELECT MIN(salario) AS menorSalario FROM tb_funcionario;

-- COUNT()
-- Recuperar a quantidade de funcionários
SELECT COUNT(*) AS qtdFuncionarios FROM tb_funcionario;

-- Recuperar a quantidade de funcionários que possuem salário maior que R$ 5 mil
SELECT COUNT(*) AS qtdFuncionarios FROM tb_funcionario WHERE salario > 5000.00;

-- Exercícios
-- 01) Listar o menor ano de nascimento da tabela tb_funcionario
SELECT MIN(year(dtNascimento)) AS menorAnoNascimento FROM tb_funcionario;

-- 02) Listar o maior mês de nascimento da tabela tb_funcionário
SELECT MAX(month(dtNascimento)) AS maiorMesNascimento FROM tb_funcionario;

-- 03) Listar o total de registros da tabela tb_cargo
SELECT COUNT(*) AS totalRegistros FROM tb_cargo;

-- 04) Listar a média da idade dos funcionários que trabalham no departamento de Enfermaria
SELECT AVG(TIMESTAMPDIFF(YEAR, f.dtNascimento, curdate())) AS mediaIdade
FROM tb_funcionario f
INNER JOIN tb_departamento d ON f.codDepartamento = d.codDepartamento
WHERE d.descricao = 'Enfermaria';

-- 05) Listar o total dos salários dos funcionários que possuem o cargo Administrador(a)
SELECT SUM(f.salario) AS totalSalarios
FROM tb_funcionario f
INNER JOIN tb_cargo c ON f.codCargo = c.codCargo
WHERE c.descricao = 'Administrador(a)';

-- Exercícios
-- 01) Listar a quantidade de funcionários por departamento
SELECT
    d.descricao AS departamento,
    COUNT(*) AS qtdFuncionarios
FROM tb_funcionario f
INNER JOIN tb_departamento d ON f.codDepartamento = d.codDepartamento
GROUP BY d.descricao;

-- 02) Listar a quantidade de funcionários por cargo, ordenando a quantidade por ordem descrescente
SELECT
    c.descricao AS cargo,
    COUNT(*) AS qtdFuncionarios
FROM tb_funcionario f
INNER JOIN tb_cargo c ON f.codCargo = c.codCargo
GROUP BY c.descricao
ORDER BY qtdFuncionarios DESC;

-- 03) Listar o valor total dos salários de cada departamento
SELECT
    d.descricao AS departamento,
    SUM(f.salario) AS totalSalarios
FROM tb_funcionario f
INNER JOIN tb_departamento d ON f.codDepartamento = d.codDepartamento
GROUP BY d.descricao;

-- 04) Listar a média salarial por cargo
SELECT
    c.descricao AS cargo,
    AVG(f.salario) AS mediaSalarios
FROM tb_funcionario f
INNER JOIN tb_cargo c ON f.codCargo = c.codCargo
GROUP BY c.descricao;
