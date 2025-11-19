
DROP DATABASE SistemaPersonagensDBFirst;
GO

CREATE DATABASE SistemaPersonagensDBFirst;
GO

USE SistemaPersonagensDBFirst;
GO

CREATE TABLE TabelaPersonagem
(
    Id           INT IDENTITY(1,1) NOT NULL,
    Nome         NVARCHAR(120)     NOT NULL,
    Nível        INT               NOT NULL,
    Tipo         NVARCHAR(30)      NOT NULL,
    CONSTRAINT PK_TabelaPersonagem PRIMARY KEY(Id)
);
GO

INSERT INTO TabelaPersonagem(Nome, Nível, Tipo) VALUES
('MayMay', 9, 'Mago'),
('Rafita', 9, 'Mago'),
('Dudu', 8, 'Guerreiro');
GO

SELECT * FROM TabelaPersonagem;
GO