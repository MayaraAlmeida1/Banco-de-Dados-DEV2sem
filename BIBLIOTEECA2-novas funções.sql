CREATE DATABASE BIBLIOTECA2;
GO

USE BIBLIOTECA2;
GO

CREATE TABLE Autor (
	id_Autor INT PRIMARY KEY,
	nome VARCHAR(100) NOT NULL
	);
GO

CREATE TABLE Livro (
	id_Livro INT PRIMARY KEY,
	titulo VARCHAR(150) NOT NULL,
	ano INT,
	id_Autor INT NOT NULL,
	CONSTRAINT fk_livro_autor FOREIGN KEY (id_Autor) REFERENCES Autor(id_Autor) ON DELETE CASCADE
	);
GO

CREATE TABLE Leitor (
	id_Leitor INT PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	email VARCHAR (120) UNIQUE
	);
GO

CREATE TABLE Emprestimo (
	id_Emprestimo INT PRIMARY KEY,
	id_Livro INT NOT NULL,
	id_Leitor INT NOT NULL,
	data_emprestimo DATE NOT NULL, 
	data_devolucao DATE,
	CONSTRAINT fk_empr_livro FOREIGN KEY (id_Livro) REFERENCES Livro(id_Livro) ON DELETE CASCADE,
	CONSTRAINT fk_empr_leitor FOREIGN KEY (id_Leitor) REFERENCES Leitor(id_Leitor) ON DELETE CASCADE
	);
GO

INSERT INTO Autor VALUES 
  (1,'Machado de Assis'),
  (2,'Clarice Lispector'),
  (3,'J. K. Rowling'),
  (4,'Shakespeare');
GO

INSERT INTO Livro VALUES 
	(1, 'Dom Casmurro', 1899, 1),
	(2, 'Memórias Póstumas de Brás Cubas', 1881, 1),
	(3, 'A hora da estrela', 1977, 2),
	(4, 'O sonho de uma noite de verão', 1600, 4),		
	(5, 'Harry Potter e o calice de fogo', 2000, 3);
GO

INSERT INTO Leitor VALUES
	(1, 'Thiago Oliveira' , 'thiago@gmail.com'),
	(2, 'Caique' , 'caique@gmail.com'),
	(3, 'Odirlei' , 'odi@gmail.com' ),
	(4, 'Kessia', 'kessia@gmail.com');
GO

INSERT INTO Emprestimo VALUES --id_emprestimo, id_livro, id_leitor, data_empr, data_dev
	(1, 5, 1, '2025-09-02', '2025-09-09'), -- Thiago pegou harry potter
	(2, 4, 4, '2025-08-27', '2025-09-05'), -- kessia pegou o sonho de uma noite
	(3, 1, 2, '2025-05-01', '2025-06-10'); --caique pegou Dom casmurro
GO

-- COUNT - Contar o total de registros
SELECT * FROM Leitor;

SELECT COUNT (*) AS QtdLeitores -- Quatidade de leitores, o "AS" serve para colocar um nome nessa nova tabela--
FROM Leitor;

SELECT * FROM Emprestimo;

-- COUNT + GROUP BY (funções agregadas precisa ter o group by para mais atributos)
SELECT l.nome, COUNT(e.id_emprestimo) AS QtdEmprestimo
FROM Emprestimo e
JOIN Leitor l ON l.id_leitor = e.id_leitor
GROUP BY l.nome -- Agrupa pelo nome a qnt de emprestimos

-- MIN / MAX
SELECT Ano FROM Livro;

SELECT MIN(Ano) AS MenorAnor FROM Livro;
SELECT MAX(Ano) AS MaiorAno FROM Livro;

-- FUNÇÕES DE TEXTO	

 -- LEN
 -- Retorna qtd de caracteres (incluindo espaços)
 SELECT LEN('Késsia') AS TamanhoString;
 SELECT nome, LEN(nome) FROM Autor;

 -- UPPER (maiúsculo) / LOWER (minúsculo)
 SELECT UPPER(nome) FROM Leitor;
 SELECT LOWER(email) FROM Leitor;

 --	LEFT (esquerda) / RIGHT(direita)
 -- Pega as letras a esquerda e a direita
 SELECT * FROM Livro;

 SELECT LEFT(titulo, 5) AS Primeiros5 FROM Livro; -- Tem que colocar a quantidade de caracteres q quer q apareça
 SELECT RIGHT(titulo, 5) AS Ultimos5 FROM Livro;

 -- REPLACE 
 -- Trocar caracteres - coloca o nome do atributo, o valor inicial, e o valor final (q quer trocar)

 SELECT REPLACE(titulo, 'Harry', 'Hermione') FROM Livro;

 -- CHARINDEX
 -- Localizar a posição de alguma palavara

 SELECT titulo, CHARINDEX('de', titulo) AS PosicaoTexto FROM Livro; -- Mostra em qual posição está a palavra "de"

 -- CONCAT
 -- Concatenar textos (juntas textos e atributos)

SELECT CONCAT('Emprestimo', e.id_emprestimo, ' - Leitor: ', le.nome, ' - Livro: ', li.titulo)
FROM Emprestimo e
JOIN Leitor le ON le.id_leitor = e.id_leitor
JOIN Livro li ON li.id_livro = e.id_livro

-- SUBSTRING 
-- Mostra o texto conforme o tamanho passado, atributo, tamanho inicial, tamanho final
SELECT SUBSTRING(titulo, 1, 10) FROM Livro;

-- RTRIM(direita) / LTRIM(esquerda) / TRIM(dos dois lados
SELECT Nome, RTRIM(Nome), LTRIM(nome), TRIM(nome) FROM Leitor;

-- FUNÇÕES DE DATA E HORA

-- GETDATE 
-- Dia e horário atual, da instância onde está sendo executada
SELECT GETDATE();

SELECT SYSDATETIMEOFFSET() -- Pega horário da região
AT TIME ZONE 'E. South America Standard Time';

USE BIBLIOTECA2;

-- DATEADD:
-- Adiciona um tempo a mais dentro de uma data
-- YEAR: ANO, MONTH: MÊS, DAY: DIA, WEEK: SEMANA
SELECT id_Emprestimo, data_emprestimo,
DATEADD(DAY, 7, data_emprestimo) AS PrevisaoDevolucao
FROM Emprestimo;

-- Diminuir o tempo
SELECT id_Emprestimo, data_emprestimo,
DATEADD(MONTH, -1, data_emprestimo) AS PrevisaoDevolucao
FROM Emprestimo;

-- DATEDIFF: diferença entre datas
SELECT id_emprestimo, data_emprestimo, data_devolucao,
DATEDIFF(DAY, data_emprestimo, ISNULL(data_devolucao, GETDATE()))
AS DiasComLivro
FROM Emprestimo;
-- se data_devolucao estiver vazio, ele acrescenta o GETDATE para inserir a data atual e comparar com a data empréstimo.

-- FORMAT: FORMATAR DATAS
SELECT * FROM Emprestimo;

SELECT 
FORMAT(data_emprestimo, 'dd-MM-yyyy') AS Emprestimo,
FORMAT(data_devolucao, 'dd/MM/yy') AS Devolucao
FROM Emprestimo;

-- Extrair ano, mês e dia de uma data:
SELECT data_emprestimo,
YEAR(data_emprestimo) AS Ano,
MONTH(data_emprestimo) AS Mes,
DAY(data_emprestimo) AS Dia
FROM Emprestimo;


SET LANGUAGE Portuguese;

-- DATEPART / DATENAME
SELECT	DATEPART(MONTH, data_emprestimo) AS MES,
		DATEPART(WEEKDAY, data_emprestimo) AS DiaSemana,
		DATENAME(WEEKDAY, data_emprestimo) AS NomeDiaSemana,
		DATENAME(MONTH, data_emprestimo) AS NomeMes
FROM Emprestimo;

-- OPERADORES DE COMPARAÇÃO

-- (igualdade) =
SELECT titulo, ano
FROM Livro
WHERE ano = 2000;

-- (diferente) NOT LIKE
SELECT nome, email
FROM Leitor
WHERE email NOT LIKE 'kes%'
    
SELECT titulo, ano
FROM Livro
WHERE ano <> 2000;

SELECT titulo, ano
FROM Livro
WHERE ano != 2000;

-- (maior que) >
SELECT titulo, ano
FROM Livro
WHERE ano > 1900

-- (menor que) <
SELECT titulo, ano
FROM Livro
WHERE ano < 1900


SELECT * FROM Emprestimo;

-- (maior ou igual) >=
SELECT id_emprestimo, data_emprestimo
FROM Emprestimo
WHERE data_emprestimo >= '2025-09-01'

-- (menor ou igual) <= 
SELECT id_emprestimo, data_emprestimo
FROM Emprestimo
WHERE data_emprestimo <= '2025-08-31'

-- OPERADORES LÓGICOS

-- AND (E)
SELECT emprestimo.id_Emprestimo, leitor.nome, 
emprestimo.data_emprestimo, emprestimo.data_devolucao
FROM Emprestimo
JOIN Leitor ON leitor.id_Leitor = Emprestimo.id_Leitor
WHERE MONTH(emprestimo.data_emprestimo) = 9
AND YEAR(emprestimo.data_emprestimo) = 2025
-- DUAS CONDIÇÕES PRECISAM SER VERDADEIRAS

SELECT * FROM Emprestimo
SELECT * FROM Autor

-- OR (ou)
SELECT l.titulo, l.ano, a.nome
FROM Livro l
JOIN Autor a ON a.id_Autor = l.id_Autor
WHERE a.nome = 'Machado de Assis'
OR a.nome = 'Clarice Lispector'
-- Uma condição sendo verdadeira, já retorna o valor

-- NOT (negação)
SELECT l.titulo, l.ano, a.nome
FROM Livro l
JOIN Autor a ON a.id_Autor = l.id_Autor
WHERE NOT a.nome = 'Shakespeare'

-- OPERADORES ESPECIAIS

-- BETWEEN (entre)
SELECT titulo, ano
FROM Livro
WHERE ano BETWEEN 1900 AND 2000;

-- IN (verifica uma lista de valores)
SELECT * FROM Autor
WHERE nome IN ('Machado de Assis', 'Shakespeare');

-- LIKE
SELECT titulo
FROM Livro
WHERE titulo LIKE '%O%';
-- Porcentagem antes da letra - existe texto antes daquela letra
-- Porcentagem depois da letra - existe texto depois da letra
-- Porcentagem entre a letra - existe texto antes e depois da letra

-- IS NULL
-- Retorna registros vazios
SELECT id_Emprestimo, id_livro, data_emprestimo
FROM Emprestimo
WHERE data_devolucao IS NULL;

-- IS NOT NULL
SELECT id_emprestimo, id_livro, data_emprestimo
FROM Emprestimo
WHERE data_devolucao IS NOT NULL;