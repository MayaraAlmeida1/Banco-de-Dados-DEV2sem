
USE VendasOnline;	

-- PROCEDURES -- Procedimento armazenado, sequência de códigos armazanada para apeas chamar e usar

--Procedure 1: Inserir clientes(INSERT)
CREATE PROCEDURE InserirCliente
	@Nome             VARCHAR(50),
	@Sobrenome        VARCHAR(50),
	@Email            VARCHAR(100),
	@Telefone         VARCHAR(20),
	@DataCadastro    DATE

AS 
BEGIN  -- Inicia a procedure
	SET NOCOUNT ON; -- Não mostra informação de linhas afetadas
	INSERT INTO Cliente(Nome, Sobrenome, Email, Telefone, DataCadastro)
	VALUES (@Nome, @Sobrenome, @Email, @Telefone, @DataCadastro)
END -- Encerrar procedure

-- Testanto procedure
EXEC InserirCliente 'Ana', 'Souza', 'ana@email.com', '11999999999', '2025-10-13'

SELECT * FROM Cliente;

-- Procedure 2: Inserir Pedido (INSERT)
CREATE PROCEDURE InserirPedido
	@ClienteId INT,
	@DataPedido DATE,
	@ValorTotal DECIMAL(10,2),
	@StatusId INT

AS
BEGIN
	SET NOCOUNT ON
	INSERT INTO Pedido(ClienteId, DataPedido, ValorTotal, StatusId)
	VALUES (@ClienteId, @DataPedido,@ValorTotal, @StatusId)
END

-- Testar Procedure
EXEC InserirPedido 3, '2025-10-13', 250.00, 1;

SELECT * FROM Pedido;


-- Procedure 3: Atualizar preço de produto (UPDATE)
CREATE PROCEDURE AtualizarPrecoProduto
	@ProdutoId INT,
	@PercentualAumento DECIMAL(5, 2)
AS
BEGIN
	SET NOCOUNT ON
	UPDATE Produto
	SET Preco = Preco * (1 + @PercentualAumento / 100.0)
	WHERE ProdutoId = @ProdutoId;
END

-- Testando procedure
SELECT * FROM Produto

EXEC AtualizarPrecoProduto 8, 10

SELECT * FROM Produto

-- Procedure 4: Total de vendas por cliente (saída)
CREATE PROCEDURE ObterTotalVendas
	@ClienteId INT,
	@TotalVendas DECIMAL(10, 2) OUTPUT

AS
BEGIN 
	SET NOCOUNT ON 
	-- @TotalVendas recebe a soma do valor total
	SELECT @TotalVendas = COALESCE(SUM(ValorTotal),0) -- COALESCE - Caso o valor for nulo, substitui por zero
	FROM Pedido
	WHERE ClienteId = @ClienteId
END

-- Testando procedure
DECLARE @Total DECIMAL(10,2) -- Declarando nova variável
EXEC ObterTotalVendas 3, @Total OUTPUT;
SELECT @Total AS TotalDeVendas

-- Procedure 5: Relatório de vendas por cliente
CREATE PROCEDURE VendasPorCliente 
	@DataLimite DATE

AS 
BEGIN
	SET NOCOUNT ON

	SELECT C.ClienteId, C.Nome,
	SUM(D.Quantidade * D.PrecoUnitario) AS TotalGasto
	FROM Cliente c
	JOIN Pedido p            ON P.ClienteId = C.ClienteId
	Join DetalhesPedido D    ON D.PedidoID = P.PedidoID
	WHERE P.DataPedido < @DataLimite -- Vai ver o quanto ja gastou até a data inserida
	GROUP BY C.ClienteID, C.Nome
END

-- Testando Procedure
INSERT INTO DetalhesPedido (PedidoID, ProdutoID, Quantidade, PrecoUnitario)
VALUES
(6, 7, 1, 4500.00)

EXEC VendasPorCliente '2025-10-14'

-- Procedure 6: Histórico de preço com tabela própria

CREATE TABLE HistoricoDePrecos(
	HistoricoId INT IDENTITY PRIMARY KEY,
	ProdutudoId INT FOREIGN KEY REFERENCES Produto(ProdutoId),
	PrecoAntigo DECIMAL(10,2),
	PrecoNovo DECIMAL(10,2),
	DataMotificacao DATE
)

CREATE PROCEDURE AtualizarPrecoProdutoComHistorico
	@ProdutoId INT,
	@NovoPreco DECIMAL(10,2)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @PrecoAntigo DECIMAL(10,2)

	SELECT @PrecoAntigo = Preco
	FROM Produto
	WHERE ProdutoID = @ProdutoId;

	UPDATE Produto SET Preco = @NovoPreco
	WHERE ProdutoID = @ProdutoId

	INSERT INTO HistoricoDePrecos (ProdutudoId, PrecoAntigo, PrecoNovo, DataMotificacao)
	VALUES (@ProdutoId, @PrecoAntigo, @NovoPreco, DATEADD(HOUR, -3, SYSUTCDATETIME()))
END

-- Testando Procedure
EXEC AtualizarPrecoProdutoComHistorico 8, 75.00

SELECT * FROM Produto
SELECT * FROM HistoricoDePrecos;