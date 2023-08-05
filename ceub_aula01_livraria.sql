-- Author: Pedro Henrique Lima Cardoso
-- CEUB - Introdução à Banco de Dados

-- Drop database 'db_ceub_aula01_livraria' if exists
DROP DATABASE IF EXISTS db_ceub_aula01_livraria;

-- Create database 'db_ceub_aula01_livraria' if not exists
CREATE DATABASE IF NOT EXISTS db_ceub_aula01_livraria;

-- Use database 'db_ceub_aula01_livraria'
USE db_ceub_aula01_livraria;

-- Create table 'tb_livro'
CREATE TABLE tb_livro (
	isbn DECIMAL(13) PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    preco DECIMAL(6, 2),
    codEditora INT NOT NULL,
    codGenero INT NOT NULL
);

-- Create table 'tb_editora'
CREATE TABLE tb_editora (
	codEditora INT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL
);

-- Create table 'tb_genero'
CREATE TABLE tb_genero (
	codGenero INT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL
);

-- FK EDITORA - LIVRO
ALTER TABLE tb_livro
ADD CONSTRAINT fk_editora
FOREIGN KEY (codEditora) REFERENCES tb_editora(codEditora);

-- FK GENERO - LIVRO
ALTER TABLE tb_livro
ADD CONSTRAINT fk_genero
FOREIGN KEY (codGenero) REFERENCES tb_genero(codGenero);

-- Add column 'dtPublicacao'
ALTER TABLE tb_livro
ADD dtPublicacao DATE;

-- Modify column 'dtPublicacao'
ALTER TABLE tb_livro
MODIFY COLUMN dtPublicacao DATE;

-- Rename column 'titulo' to 'tituloLivro'
ALTER TABLE tb_livro
CHANGE titulo tituloLivro VARCHAR(100) NOT NULL;

-- Rename column 'tituloLivro' to 'titulo'
ALTER TABLE tb_livro
CHANGE tituloLivro titulo VARCHAR(100) NOT NULL;

-- Drop column 'dtPublicacao'
ALTER TABLE tb_livro
DROP COLUMN dtPublicacao;

-- Insert data in 'tb_genero'
INSERT INTO tb_genero (codGenero, descricao)
VALUES
(1, 'Computação'),
(2, 'Medicina'),
(3, 'Engenharia'),
(4, 'Jurídico'),
(5, 'Arquitetura'),
(6, 'Biologia'),
(7, 'Mecatrônica');

-- Insert data in 'tb_editora'
INSERT INTO tb_editora (codEditora, descricao)
VALUES
(1, 'Novatec'),
(2, 'Amazon'),
(3, 'Coopmed'),
(4, 'Livraria Florence'),
(5, 'Blucher'),
(6, 'Mundial'),
(7, 'Saraiva'),
(8, 'Editora Forum'),
(9, 'Dickens');

-- Insert data in 'tb_livro'
INSERT INTO tb_livro (isbn, titulo, preco, codEditora, codGenero)
VALUES
(1, 'Banco de dados', 300.00, 1, 1),
(2, 'Engenharia de software', 350.00, 1, 1),
(3, 'Ortopedia', 310.00, 3, 2),
(4, 'Cardiologia', 320.00, 4, 2),
(5, 'Estrutura Predial', 200.00, 5, 3),
(6, 'Estrutura Hidraulica', 300.00, 6, 3),
(7, 'Direito Penal', 150.00, 7, 4),
(8, 'Direito Civil', 200.00, 8, 4),
(9, 'Cores', 200.00, 7, 5),
(10, 'Paisagismo', 250.00, 8, 5),
(11, 'Virus', 300.00, 9, 6),
(12, 'Bacteria', 300.00, 9, 6);

-- Select every column in table 'tb_genero'
SELECT * FROM tb_genero;

-- Select every column in table 'tb_editora'
SELECT * FROM tb_editora;

-- Select every column in table 'tb_livro'
SELECT * FROM tb_livro;

-- Update register (codEditora = 9) on 'tb_editora'
UPDATE tb_editora
SET descricao = 'Thomson'
WHERE codEditora = 9;

-- Update register (isbn = 1) on 'tb_livro'
UPDATE tb_livro
SET codEditora = 1, codGenero = 2
WHERE isbn = 1;

-- Delete register (isbn = 9) on 'tb_livro'
DELETE FROM tb_livro WHERE isbn=9;

-- Exercício
-- 01) Listar registro com 'codEditora = 1' na tabela 'tb_editora'
SELECT * FROM tb_editora WHERE codEditora = 1;

-- 02) Listar registro(s) com 'codGenero = 1' na tabela 'tb_livro'
SELECT * FROM tb_livro WHERE codGenero = 1;

-- 03) Remover o registro com 'codEditora = 2' na tabela 'tb_editora'
DELETE FROM tb_editora WHERE codEditora = 2;

-- 04) Remover registro com 'codGenero = 1' na tabela 'tb_genero'
-- DELETE FROM tb_genero WHERE codGenero = 1;
-- Error Code: 1451. Cannot delete or update a parent row:
-- a foreign key constraint fails (`db_ceub_aula01_livraria`.`tb_livro`,
-- CONSTRAINT `fk_genero` FOREIGN KEY (`codGenero`) REFERENCES `tb_genero` (`codGenero`))

-- 05) Alterar o preço do livro com 'isbn = 1' para 400.00
UPDATE tb_livro
SET preco = 400.00
WHERE isbn = 1;

-- 06) Aumentar o preço de todos os livros em 10%
SET sql_safe_updates = 0; -- Disabling safe_update

UPDATE tb_livro
SET preco = preco * 1.1;

SET sql_safe_updates = 1; -- Enabling safe_update

-- 07) Listar os registros da tabela 'tb_livro' que possem preço > 350
SELECT * FROM tb_livro WHERE preco > 350;

-- 08) Listar os livros da editora com código 8
SELECT * FROM tb_livro WHERE codEditora = 8;

-- Joins

-- Inner join
SELECT
    l.titulo,
    e.descricao AS editora
FROM tb_livro l
INNER JOIN tb_editora e ON l.codEditora = e.codEditora;

-- Exercícios
-- 01) Desenvolva um script SQL que exiba os títulos dos livros e os respectivos gêneros
SELECT
    l.titulo,
    g.descricao AS genero
FROM tb_livro AS l
INNER JOIN tb_genero g ON l.codGenero = g.codGenero;

-- 02) Desenvolva um script SQL que exiba os títulos dos livros, os respectivos gêneros e as respectivas editoras.
SELECT
    l.titulo,
    g.descricao AS genero,
    e.descricao AS editora
FROM tb_livro l
INNER JOIN tb_genero g ON l.codGenero = g.codGenero
INNER JOIN tb_editora e ON l.codEditora = e.codEditora;

-- 03) Listar titulo e editora quando o preço for maior que R$250,00
SELECT
    l.titulo,
    e.descricao AS editora
FROM tb_livro l
INNER JOIN tb_editora e ON l.codEditora = e.codEditora
WHERE l.preco > 250;

-- 04) Listar titulo e gênero quando o preço for entre R$200,00 e R$300,00
SELECT
    l.titulo,
    g.descricao AS genero
FROM tb_livro l
INNER JOIN tb_genero g ON l.codGenero = g.codGenero
WHERE l.preco >= 200 AND l.preco <= 300;

-- 05) Listar título, editora e gênero quando o código da editora for 1, 2 ou 3
SELECT
    l.titulo,
    e.descricao AS editora,
    g.descricao AS genero
FROM tb_livro l
INNER JOIN tb_editora e ON l.codEditora = e.codEditora
INNER JOIN tb_genero g ON l.codGenero = g.codGenero
WHERE l.codEditora IN (1, 2, 3);

-- Views

-- Criar view para exibir o titulo e o preço dos livros
CREATE VIEW vw_01 AS
SELECT
    titulo,
    preco
FROM tb_livro;

-- Select na view vw_01
SELECT * FROM vw_01;

-- Criar view para exibir o ISBN e o titulo do livro
CREATE VIEW vw_02 AS
SELECT
    isbn,
    titulo
FROM tb_livro;

-- Select na view vw_02
SELECT * FROM vw_02;

-- Criar view para exibir os titulos dos livros com as respectivas editoras
CREATE VIEW vw_03 AS
SELECT
    l.titulo,
    e.descricao AS editora
FROM tb_livro l
INNER JOIN tb_editora e ON l.codEditora = e.codEditora;

-- Select na view vw_03
SELECT * FROM vw_03;


-- Exercícios
-- 01) Criar uma view que liste ISBN, titulo e preco
CREATE VIEW vw_ex_01 AS
SELECT
    isbn,
    titulo,
    preco
FROM tb_livro;

SELECT * FROM vw_ex_01;

-- 02) Criar uma view que liste ISBN, titulo, preco e preco com 10% de desconto
CREATE VIEW vw_ex_02 AS
SELECT
    isbn,
    titulo,
    preco,
    preco * 0.9 AS preco_desconto
FROM tb_livro;

SELECT * FROM vw_ex_02;

-- 03) Criar uma view que liste ISBN, titulo e editora
CREATE VIEW vw_ex_03 AS
SELECT
    l.isbn,
    l.titulo,
    e.descricao AS editora
FROM tb_livro l
INNER JOIN tb_editora e ON l.codEditora = e.codEditora;

SELECT * FROM vw_ex_03;

-- 04) Criar uma view que liste ISBN, titulo e gênero
CREATE VIEW vw_ex_04 AS
SELECT
    l.isbn,
    l.titulo,
    g.descricao AS genero
FROM tb_livro l
INNER JOIN tb_genero g ON l.codGenero = g.codGenero;

SELECT * FROM vw_ex_04;

-- 05) Criar uma view que liste ISBN, titulo, preco, editora e gênero ordenada por preço
CREATE VIEW vw_ex_05 AS
SELECT
    l.isbn,
    l.titulo,
    l.preco,
    e.descricao AS editora,
    g.descricao AS genero
FROM tb_livro l
INNER JOIN tb_editora e ON l.codEditora = e.codEditora
INNER JOIN tb_genero g ON l.codGenero = g.codGenero
ORDER BY l.preco;

SELECT * FROM vw_ex_05;

-- Group by
-- Somatório dos precos por codEditora
SELECT
    codEditora,
    SUM(preco) AS preco_total
FROM tb_livro
GROUP BY codEditora
ORDER BY preco_total DESC;

-- Somatório dos precos por Editora
SELECT
    e.descricao AS editora,
    SUM(l.preco) AS preco_total
FROM tb_livro l
INNER JOIN tb_editora e ON l.codEditora = e.codEditora
GROUP BY e.descricao
ORDER BY preco_total DESC;

-- Quantidade de livros por editora
SELECT
    e.descricao AS editora,
    COUNT(l.isbn) AS qtd_livros
FROM tb_livro l
INNER JOIN tb_editora e ON l.codEditora = e.codEditora
GROUP BY e.descricao
ORDER BY qtd_livros DESC;

-- Quantidade de livros por gênero
SELECT
    g.descricao AS genero,
    COUNT(l.isbn) AS qtd_livros
FROM tb_livro l
INNER JOIN tb_genero g ON l.codGenero = g.codGenero
GROUP BY g.descricao
ORDER BY qtd_livros DESC;
