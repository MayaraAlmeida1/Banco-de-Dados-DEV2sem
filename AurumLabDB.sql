-- DROP DATABASE AurumLabDB;
-- GO

CREATE DATABASE AurumLabDB;
GO

USE AurumLabDB;
GO

/* Tabela de Regra */
CREATE TABLE RegraPerfil (
	IdRegra INT IDENTITY(1,1) PRIMARY KEY,
	Nome NVARCHAR(40) NOT NULL UNIQUE
);
GO

/* Tabela de Usuarios */

CREATE TABLE Usuario
(
	IdUsuario		INT IDENTITY(1,1) PRIMARY KEY,
	NomeCompleto	NVARCHAR(200) NOT NULL,
    NomeUsuario     NVARCHAR(80) NULL,
	Email			NVARCHAR(150) NOT NULL UNIQUE,
	Senha			VARBINARY(32) NOT NULL, -- armazena a hash da senha (SHA2_256 = 32 bytes)
    Foto            VARBINARY(MAX),         -- armazena dados binários de tamanho variável, com um limite de até 2 GB
    CriadoEm        DATETIME2(0)   NOT NULL DEFAULT DATEADD(HOUR, -3, SYSUTCDATETIME()),
    -- CriadoEm DATETIME2(0) NOT NULL DEFAULT DATEADD(HOUR, -3, SYSUTCDATETIME())
    -- no datetime2(0) temos zero casas decimais de segundo (ex.: 2025-09-16 13:45:00).
    -- se fosse (3), mostraria milissegundos (2025-09-16 13:45:00.123).
    RegraId       INT NOT NULL, 
    CONSTRAINT FK_Usuario_Regra FOREIGN KEY (RegraId) 
    REFERENCES RegraPerfil(IdRegra) ON DELETE CASCADE
);

-- SYSUTCDATETIME() - funcao que retorna a data/hora atual em UTC (tempo universal).
-- Se quisermos pegar no horario do servidor, podemos usar SYSDATETIME().
GO


INSERT INTO RegraPerfil (Nome) VALUES
('Aluno'),
('Professor');

GO

/* Exemplo de Usuario */
/*
   HASHBYTES('SHA2_256', 'senha') gera o hash da senha no formato binario.
   SHA2_256 produz 256 bits (32 bytes).
*/


CREATE TABLE TipoDispositivo (
    IdTipoDispositivo INT IDENTITY(1,1) PRIMARY KEY,
    Nome                NVARCHAR(80) NOT NULL       
);

GO

CREATE TABLE LocalDispositivo (
    IdLocal            INT IDENTITY(1,1) PRIMARY KEY,
    Nome                NVARCHAR(120) NOT NULL        
);

GO

CREATE TABLE TipoManutencao (
    IdTipoManutencao  INT IDENTITY(1,1) PRIMARY KEY,
    Nome                NVARCHAR(50) NOT NULL         
);

GO

CREATE TABLE Dispositivo (
    IdDispositivo               INT IDENTITY(1,1) PRIMARY KEY,
    Nome                        NVARCHAR(120) NOT NULL,
    IdTipoDispositivo           INT NOT NULL,
    IdLocal                     INT NOT NULL,
    NumeroDispositivo           INT NOT NULL,
    SituacaoOperacional         NVARCHAR(30) NOT NULL DEFAULT('Operando'),
    DataUltimaManutencao        DATE,
    Observacoes                 NVARCHAR(500),
    CriadoEm                    DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_Dispositivo_Tipo  FOREIGN KEY (IdTipoDispositivo) REFERENCES TipoDispositivo(IdTipoDispositivo) ON DELETE CASCADE,
    CONSTRAINT FK_Dispositivo_LocalDispositivo FOREIGN KEY (IdLocal) REFERENCES LocalDispositivo(IdLocal) ON DELETE CASCADE,
    CONSTRAINT CK_Dispositivo_Situacao CHECK (SituacaoOperacional IN ('Operando','Em Manutenção','Inoperante'))
);

GO

-- Check serve para validar se o que esta sendo inserido esta no meio desses valores ('Operando','Em Manutencao','Inoperante')

CREATE TABLE Manutencao (
    IdManutencao        INT IDENTITY(1,1) PRIMARY KEY,
    IdDispositivo       INT NOT NULL,
    IdTipoManutencao    INT NOT NULL,
    StatusManutencao    NVARCHAR(15) NOT NULL DEFAULT('Agendada'),
    DataAgendada        DATE,
    DataRealizada       DATE,
    Responsavel         NVARCHAR(120),                
    Observacoes         NVARCHAR(500),
    Criado_por          INT,  
    Criado_em           DATETIME2(0) NOT NULL DEFAULT DATEADD(HOUR, -3, SYSUTCDATETIME()),
    CONSTRAINT FK_Manutencao_Dispositivo        FOREIGN KEY (IdDispositivo)     REFERENCES Dispositivo(IdDispositivo)       ON DELETE CASCADE,
    CONSTRAINT FK_Manutencao_TipoManutencao     FOREIGN KEY (IdTipoManutencao)  REFERENCES TipoManutencao(IdTipoManutencao) ON DELETE CASCADE,
    CONSTRAINT FK_Manutencao_Usuario            FOREIGN KEY (Criado_por)        REFERENCES Usuario(IdUsuario)               ON DELETE CASCADE,
    CONSTRAINT CK_Manutencao_Status CHECK (StatusManutencao IN ('Agendada','Em Andamento','Concluida','Cancelada'))
);

GO


-- INSERTS


-- USUARIO
DECLARE @RegraId INT; -- declarando variavel RegraId
SET @RegraId = 
(SELECT IdRegra FROM RegraPerfil WHERE Nome = 'Aluno')

INSERT INTO Usuario (NomeCompleto, Email, Senha, Foto, RegraId)
VALUES
('Fulano da Silva', 'fulano@aurum.com', HASHBYTES('SHA2_256', 'senha123'),
 CONVERT(VARBINARY(MAX),'https://i.pravatar.cc/150?img=12'), @RegraId),

('Maria Oliveira', 'maria@aurum.com', HASHBYTES('SHA2_256', 'senha123'),
 CONVERT(VARBINARY(MAX),'https://i.pravatar.cc/150?img=14'), @RegraId),

('Professor Antonio', 'antonio@aurum.com', HASHBYTES('SHA2_256', 'prof123'),
 CONVERT(VARBINARY(MAX),'https://i.pravatar.cc/150?img=1'), 2);

GO

-- TIPO DISPOSITIVO
INSERT INTO TipoDispositivo (Nome) VALUES
('Computador'),
('Projetor'),
('Impressora');


-- LOCAL DISPOSITIVO
INSERT INTO LocalDispositivo (Nome) VALUES
('Laboratorio 1'),
('Laboratorio 2'),
('Biblioteca');


-- TIPO MANUTENCAO
INSERT INTO TipoManutencao (Nome) VALUES
('Preventiva'),
('Corretiva'),
('Inspeção');


-- DISPOSITIVO
INSERT INTO Dispositivo (Nome, IdTipoDispositivo, IdLocal, NumeroDispositivo, SituacaoOperacional, DataUltimaManutencao, Observacoes)
VALUES
('Computador Dell Optiplex', 1, 1, 101, 'Operando', '2025-01-15', 'Equipamento em otimo estado'),
('Projetor Epson X200', 2, 3, 202, 'Em Manutenção', '2024-12-10', 'Imagem fraca, aguardando peca'),
('Impressora HP LaserJet 2040', 3, 2, 303, 'Inoperante', '2024-11-20', 'Falha no fusor');


-- MANUTENCAO
INSERT INTO Manutencao (IdDispositivo, IdTipoManutencao, StatusManutencao, DataAgendada, DataRealizada, Responsavel, Observacoes, Criado_por)
VALUES
(1, 1, 'Concluida', '2025-01-10', '2025-01-15', 'Tecnico Joao', 'Limpeza interna e atualizacao de drivers', 1),

(2, 2, 'Em Andamento', '2025-01-20', NULL, 'Tecnico Carlos', 'Aguardando chegada de lampada substituta', 2),

(3, 3, 'Agendada', '2025-02-05', NULL, 'Tecnico Marina', 'Verificacao de falhas eletricas', 1);


SELECT * FROM RegraPerfil;
SELECT * FROM Usuario;
SELECT * FROM TipoDispositivo;
SELECT * FROM Dispositivo;
SELECT * FROM LocalDispositivo;
SELECT * FROM TipoManutencao;
SELECT * FROM Manutencao;