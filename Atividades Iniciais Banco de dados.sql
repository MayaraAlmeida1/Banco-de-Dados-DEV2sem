------ ATIVIDADES -----

-- ATIVIDADE 1--
CREATE DATABASE Escola;

USE Escola;

CREATE TABLE Aluno(
	IdAluno INT PRIMARY KEY,
	Nome NVARCHAR(100),
	Idade INT,
	Cidade NVARCHAR(100)
)

INSERT INTO Aluno VALUES
(1, 'Mayara', 17, 'Ribeirão Pires'),
(2, 'Eduardo', 22, 'Mauá'),
(3, 'Rafaella', 19, 'São Caetano'),
(4, 'Maria', 26, 'São Paulo'),
(5, 'Giovanna', 34, 'Águas de Lindóia')

SELECT * FROM Aluno;

SELECT Nome FROM Aluno;

SELECT * FROM Aluno
WHERE Idade > 20;

SELECT * FROM Aluno
WHERE Cidade LIKE 'Águas de Lindóia';

UPDATE Aluno SET Cidade = 'São Paulo'
WHERE Cidade = 'Mauá' -- Se eu quissese mudar apenas de um atributo, puxaria pelo ID

SELECT * FROM Aluno
WHERE Cidade LIKE 'São Paulo';


-- ATIVIDADE 2 --
CREATE DATABASE Jogo;

USE Jogo;

CREATE TABLE Jogo( -- Esqueci de criar um nome diferente para a tabela aff
	IdJogo INT PRIMARY KEY,
	Titulo NVARCHAR(100),
	Genero NVARCHAR(100),
	Preco DECIMAL(7,2) -- A primeira variável é o número total de dígitos armazenados a esquerda e a direita, e a segunda é a quantidade depois da vírgula
)


INSERT INTO Jogo VALUES
(1, 'Roblox', 'Simulação', 29.90),
(2, 'Minecraft', 'Sandbox de sobrevivência', 112.85),
(3, 'The Last of Us', 'Ação e aventura', 230.20),
(4, 'Valorant', 'Tiro tático', 9.99),
(5, 'Red Dead Redemption 2', 'Mundo aberto', 299.90),
(6, 'Five Nights at Freddy', 'Survival Horror', 32.40)

SELECT * FROM Jogo
WHERE Genero = 'Simulação'

SELECT * FROM Jogo 
WHERE Preco > 200;

SELECT Titulo, Preco FROM Jogo;


-- ATIVIDADE 3 --
CREATE DATABASE Biblioteca;

USE Biblioteca;

CREATE TABLE Livro(
	IdLivro INT PRIMARY KEY,
	Titulo NVARCHAR(100),
	Autor NVARCHAR(100),
	AnoPublicacao INT
)

INSERT INTO Livro VALUES
(1, 'A biblioteca da meia noite', 'Matt Haig', 2020),
(2, 'Jogos Vorazes', 'Suzanne Collins', 2008),
(3, 'Crepúsculo', ' Stephenie Meyer', 2005),
(4, 'Quem é Você, Alasca?', 'John Green', 2005),
(5, 'Caraval', 'Stephanie Garber', 2016)

SELECT * FROM Livro
WHERE AnoPublicacao > 2010;

SELECT * FROM Livro
WHERE Autor = 'John Green';

SELECT Titulo FROM Livro;



-- ATIVIDADE 4 --
CREATE DATABASE Empresa2

USE Empresa2;

CREATE TABLE Funcionario(
	IdFunc INT PRIMARY KEY,
	Nome NVARCHAR(100),
	Cargo NVARCHAR(100),
	Salario DECIMAL(12,2)
)
 INSERT INTO Funcionario VALUES
 (1, 'Eduarda', 'Gerente de RH', 8444.10),
 (2, 'Juliana', 'Técnica química', 6840.39),
 (3, 'Matheus', 'Analista de Redes', 5335.12),
 (4, 'Nicolas', 'Almoxarife',  2600.62),
 (5, 'Emilly', 'Diretora', 12426.80)

 SELECT * FROM Funcionario
 WHERE Salario > 3000

 SELECT * FROM Funcionario
 WHERE Cargo = 'Diretora';

 SELECT Nome, Cargo FROM Funcionario;


 -- ATIVIDADE 5 --
 CREATE DATABASE Restaurante;

 USE Restaurante;

 CREATE TABLE Pedido(
	IdPedido INT PRIMARY KEY,
	Cliente NVARCHAR(100),
	Produto NVARCHAR(100),
	Quantidade INT
 )

 INSERT INTO Pedido VALUES
 (1, 'Mayara', 'Oniguiri', 12),
 (2, 'Eduardo', 'Espetinho de carne', 8),
 (3, 'Rafaella', 'Coxinha', 16),
 (4, 'Maria', 'Pão de queijo', 11),
 (5, 'Julia', 'Misto quente', 4),
 (6, 'João', 'Dadinho de tapioca', 22)

 SELECT * FROM Pedido
 WHERE Cliente = 'Mayara';

 SELECT * FROM Pedido
 WHERE Produto = 'Coxinha';

 SELECT Cliente, Quantidade FROM Pedido;

