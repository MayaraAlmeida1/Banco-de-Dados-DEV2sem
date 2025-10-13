CREATE DATABASE AurumLab;

USE AurumLab;

CREATE TABLE Regra (
	IdRegra    INT IDENTITY(1,1) PRIMARY KEY,
	Nome       VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE Usuario(
	id					INT IDENTITY (1,1) PRIMARY KEY,
	NomeCompleto        NVARCHAR(220) NOT NULL, 
	Email				NVARCHAR(150) NOT NULL UNIQUE,
	Senha				VARBINARY(32) NOT NULL, -- Armazena não necessariamente apenas textos, armazena tbm a hash da senha
											   -- A hash meio que criptografa a senha - de forma única
	FotoURL				NVARCHAR(500) NULL, -- Armazena caminho da URL da imagem
	CriadoEm            DATETIME2(0) NOT NULL DEFAULT DATEADD(HOUR, -3, SYSUTCDATETIME()),
								-- O zero é para limitar a quantidade de casas decimais de segundos, nesse caso não aparece os segundos
	RegraID             INT NOT NULL,
	CONSTRAINT FK_Usuario_Regra FOREIGN KEY (regraID) REFERENCES Regra(IdRegra)
);

USE AurumLab;

INSERT INTO Regra (nome) VALUES
('Aluno'),
('Professor');

SELECT * FROM Regra;

DECLARE @RegraId INT; -- Declarando a variável
SET @RegraId = 
(SELECT IdRegra FROM Regra WHERE Nome = 'Aluno')

-- Esse bloco dois blocos (que declara a variável e insere o valor devem ser executados inteiros juntos)
INSERT INTO Usuario (NomeCompleto, Email, Senha, FotoURL, RegraId) VALUES
('Usuario 1', 'usuario@senai.com', HASHBYTES('SHA2_256', 'senha123'), 'https://ssnuwnaiw', @RegraId)
	
SELECT * FROM Usuario;