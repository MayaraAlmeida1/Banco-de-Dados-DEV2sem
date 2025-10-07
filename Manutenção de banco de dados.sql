CREATE DATABASE Loja;

USE Loja;

CREATE TABLE Cliente(
	ClienteId INT IDENTITY(100, 1),
	Nome       VARCHAR(100) NOT NULL,
	Email      VARCHAR(100) UNIQUE,
	CONSTRAINT Pk_Cliente PRIMARY KEY (ClienteId) -- Nome específico para a chave primária (PK)
);

CREATE TABLE Pedido(
	PedidoId   INT IDENTITY(100, 1),
	DataPedido DATE NOT NULL,
	Valor      DECIMAL(10, 2),
	ClienteId INT,
	CONSTRAINT Pk_Pedido PRIMARY KEY (PedidoId),
	CONSTRAINT Fk_Pedido FOREIGN KEY (ClienteId)
	REFERENCES Cliente(ClienteId) -- ON DELETE CASCADE
	-- FK: FOREIGN KEY (chave estrangeira)
);

INSERT INTO Cliente VALUES -- (Nome, email)
('Mayara Almeida', 'maymay@senai.com'),
('Eduardo Bernal', 'dudu@senai.com'),
('Rafaella Hahon', NULL);

INSERT INTO Pedido VALUES -- (DataPedido, Valor, ClienteId)
('2025-10-01', '100.80', 100),
('2025-09-10', '49.99', 100),
('2025-09-23', '350.00', 101);

SELECT * FROM Cliente;
SELECT * FROM Pedido;

-- Ajustar e-mail do cliente (registro)
UPDATE Cliente SET Email = 'rafahahon@senai.com'
WHERE	ClienteId = 102;

-- Atualizar o valor de um pedido
SELECT * FROM Pedido;
UPDATE Pedido SET Valor = Valor + '10.00' -- Atualizando valor para mais 10 reais
WHERE PedidoId = 101
SELECT * FROM Pedido;

-- Renomear a tabela Cliente para Funcionário
EXEC sp_rename 'Cliente', 'Funcionário';

SELECT * FROM CLiente;
SELECT * FROM Funcionário;

-- Renomear a coluna ClienteId para FuncionárioId
EXEC sp_rename 'Funcionário.ClienteId', 'FuncionárioId', 'COLUMN'

-- Alterar o tamanho do tipo de dado
ALTER TABLE Funcionário
ALTER COLUMN Nome VARCHAR(150) NOT NULL;

-- Ver a estrutura da tabela, par conferir se trocou o tamanho corretamente
EXEC sp_help 'Funcionário'; 

-- Deletar um funcionário
DELETE Funcionário 
WHERE FuncionárioId = 100;

-- Apagando a chave primária da tabela pedido
ALTER TABLE Pedido 
DROP CONSTRAINT Pk_Pedido; -- Não apagou o atributo, apenas a regra que transforma ele em uma chave primária

SELECT * FROM Pedido;

-- Recriando a chave primária
ALTER TABLE Pedido
ADD CONSTRAINT Pk_Pedido PRIMARY KEY(PedidoId)

-- Alterar tbela pedido
-- ON DELETE CASCADE, ajuda a apagar tudo que tem relacionado aquele registro que quer ser apagado 
-- Excluindo chave estrangeira
ALTER TABLE Pedido
DROP CONSTRAINT FK_Pedido

-- Recriar FK com ON DELETE CASCADE
ALTER TABLE Pedido
ADD CONSTRAINT FK_Pedido_Cliente
FOREIGN KEY (ClienteId) REFERENCES Funcionário(FuncionárioId)
ON DELETE CASCADE

SELECT * FROM Funcionário
SELECT * FROM Pedido

-- Deletar um funcionário
DELETE Funcionário
WHERE FuncionárioId = 101

-- Adicionar novas colunas
ALTER TABLE Funcionário
ADD Cargo VARCHAR(50)

SELECT * FROM Funcionário


