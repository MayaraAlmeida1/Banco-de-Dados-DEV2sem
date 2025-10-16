CREATE DATABASE CinemanticaAtividade;

USE CinemanticaAtividade;

-- Procedure: Usuário novo no sistema
CREATE TABLE UsuarioCinemantica(
	CodigoUsuario        INT IDENTITY(1,1) PRIMARY KEY,
	Nome                 VARCHAR(100) NOT NULL,
	Email                VARCHAR(100) UNIQUE,
	DataNascimento       DATE NOT NULL, -- É not null para permitir a filtragem de conteúdos relacionado a idade
	Telefone             VARCHAR(20),
	DataCadastro         DATE NOT NULL
)

CREATE PROCEDURE UsuarioNovo
	@Nome               VARCHAR(50),
	@Email				VARCHAR(50),
	@DataNascimento		DATE,
	@Telefone			VARCHAR(20),
	@DataCadastro		DATE

AS
BEGIN
	SET NOCOUNT ON
	INSERT INTO UsuarioCinemantica (Nome, Email, DataNascimento, Telefone, DataCadastro)
	VALUES (@Nome, @Email, @DataNascimento, @Telefone, @DataCadastro)
END

SELECT * FROM UsuarioCinemantica;

EXEC UsuarioNovo 'Mayara', 'mayara@email.com', '2008-02-09', '11999999999', '2025-10-16'

SELECT * FROM UsuarioCinemantica;

-- Trigger: Avaliações inseridas
CREATE TABLE Avaliacao(
	CodigoAvaliacao				INT IDENTITY(1,1) PRIMARY KEY,
	Resenha						VARCHAR(800),
	Nota						INT,
	CodigoUsuarioAvaliacao      INT FOREIGN KEY REFERENCES UsuarioCinemantica(CodigoUsuario)
)

CREATE TRIGGER 