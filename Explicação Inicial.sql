--Apagar base de dados já existente
-- DROP DATABASE Empresa;

--Criar base de dados da Empresa
CREATE DATABASE Empresa;

-- Acessar a base de dados criada
USE Empresa;

-- Criar tabela Funcionario (entidade)
CREATE TABLE Funcionario(
	Codigo INT PRIMARY KEY, -- Atributo "Codigo" recebe numero inteiro "INT" e é uma chave primária
	Nome NVARCHAR(100) -- Atributo "Nome" recebe o tipo VARCHAR (texto) com até 100 caracteres 
);

-- Inserindo valores em uma tabela
INSERT INTO Funcionario (Codigo, nome) 
VALUES 
(1, 'Mayara'),
(2, 'Eduardo')

-- Outra forma de inserir valores:
INSERT INTO Funcionario VALUES
(3,'Rafa')

-- Listar dados inseridos
SELECT * FROM Funcionario; -- o "*" é para selecionar tudo da tabela - "Selecionar tudo de Funcionario" 

-- Listar apenas um atributo ou mais da tabela (traz na ordem q foi colocada)
SELECT Nome, Codigo FROM Funcionario;

-- Filtro para listar funcionarios com o código maior que 2
SELECT * FROM Funcionario
WHERE Codigo > 2; -- WHERE = quando

-- Filtro para listar funcionarios que comecem com determinada letra
SELECT * FROM Funcionario
WHERE Nome LIKE 'M%'; -- A "%" está falando que tem mais texto depois da letra, porém é para ignorar

-- Filtro para listar funcionarios que terminem com determinada letra
SELECT * FROM Funcionario
WHERE Nome LIKE '%O';

-- Filtro para listar funcionarios que tenham no meio com determinada letra
SELECT * FROM Funcionario
WHERE Nome LIKE '%A%'; 

-- Ordenar valores 
SELECT * FROM Funcionario
ORDER BY Codigo DESC 

-- Ordenar por letra (Ordem alfabética)
SELECT * FROM Funcionario
ORDER BY Nome ASC

-- DESC - Decrescente
-- ASC - Crescente 

-- Atualização de registros
UPDATE Funcionario SET Nome = 'Mayara Almeida'
WHERE Nome = 'Mayara' -- Mostra qual atributo quer mudar, para não mudar todos (SEM WHERE MUDA TODOS OS DADOS)

SELECT * FROM Funcionario -- Verificar

-- Exclusão de dados, NÃO ESQUECER DE USAR O WHERE, caso contrário vai deletar o banco de dados inteiro
DELETE FROM Funcionario
WHERE Codigo = 1


