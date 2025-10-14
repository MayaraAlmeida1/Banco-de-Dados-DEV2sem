-- TRIGGERS

-- Trigger 1: Auditoria clientes inseridos
CREATE TABLE AuditoriaCliente(
	Auditoria INT IDENTITY PRIMARY KEY,
	ClienteId INT FOREIGN KEY REFERENCES Cliente(ClienteId),
	DataInsercao DATE
)

CREATE TRIGGER trg_AuditoriaCliente
ON Cliente -- Tabela que vai disparar a trigger 
AFTER INSERT -- Momento em que a trigger vai ser executada

AS
BEGIN
	SET NOCOUNT ON
	-- A Trigger ao ser disparada, vai pegar os insert feitos e jogar na tabela auditoria
	INSERT INTO AuditoriaCliente(ClienteId, DataInsercao)
	SELECT ClienteId, DATEADD(HOUR, -3, SYSUTCDATETIME()) -- Pega essas duas informações da tabela inserted e joga na tabela Auditoria Cliente
	FROM inserted -- Armazena inserts e updates de forma temporária, tabela padrão
END

-- Testando a trigger 
INSERT INTO Cliente (Nome, Sobrenome, Email, Telefone, DataCadastro)
VALUES
('Carlos', 'Pereira', 'carlos@email.com', '11999999999', '2025-10-14')

SELECT * FROM AuditoriaCliente;
SELECT * FROM Cliente;

-- TRigger 2: Atualizar estoque ao inserir pedido

CREATE TRIGGER trg_AtualizarEstoque 
ON DetalhesPedido
AFTER INSERT

AS
BEGIN
	SET NOCOUNT ON 
	UPDATE Produto
		SET QuantidadeEstoque = QuantidadeEstoque - i.Quantidade
		FROM Produto p
		JOIN inserted i ON p.ProdutoId = i.ProdutoId
END

SELECT * FROM Produto;
SELECT * FROM DetalhesPedido;

--Testando Trigger 
INSERT INTO DetalhesPedido (PedidoId, ProdutoId, Quantidade, PrecoUnitario)
VALUES
(6, 8, 3, 75.00)


--Trigger 3:  Prevenir a exlusão de produtos com pedidos
CREATE TRIGGER trg_PrevenirExclusaoProdutos
ON Produto
INSTEAD OF DELETE -- INSTEADE OG = "ao invés de"

AS 
BEGIN
	SET NOCOUNT ON
	IF Exists (
		SELECT 1
			FROM DetalhesPedido dp
			JOIN deleted d ON dp.ProdutoID = d.ProdutoID
	)
	BEGIN -- Caso tenha produto associado ao pedido 
		RAISERROR ('Não é possível excluir produtos com pedidos associados', 16, 1)
		--código de erro de usuário
 	END
	DELETE 
	WHERE ProdutoId IN (SELECT ProdutoId FROM deleted)
END

-- Testando trigger
DELETE FROM Produto WHERE ProdutoId = 8; -- Tem que dar erro se caso houver produto associado ao pedido

--Tigger 4: Criar log de funcionario
CREATE TABLE Funcionario(
	FuncionarioId INT IDENTITY PRIMARY KEY,
	Nome VARCHAR(100),
	CPF VARCHAR(14) UNIQUE
)

CREATE TABLE logFuncionario(
	LogId INT IDENTITY PRIMARY KEY,
	FuncionarioId INT FOREIGN KEY REFERENCES Funcionario(FuncionarioId),
	Nome VARCHAR(100),
	DataCadastro DATETIME2(0) DEFAULT DATEADD(HOUR, -3, SYSUTCDATETIME())
)

CREATE TRIGGER trg_LofFuncionario
ON Funcionario
AFTER INSERT

AS
BEGIN
	SET NOCOUNT ON
	INSERT INTO LogFuncionario (FuncionarioId, Nome)
	SELECT FuncionarioId, Nome FROM inserted 
END

-- Testando trigger
INSERT INTO Funcionario (Nome, CPF)
VALUES
('Kessia', '12345678998')

SELECT * FROM Funcionario;
SELECT * FROM LogFuncionario;