-- Criar banco de dados
CREATE DATABASE LoginDB;
GO

USE LoginDB;
GO

CREATE TABLE Usuario (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    NomeCompleto VARCHAR(120) NOT NULL,
    Email VARCHAR(120) UNIQUE NOT NULL,
    SenhaHash VARBINARY(32) NOT NULL,   
    CriadoEm DATETIME DEFAULT GETDATE()
);
GO

-- Inserir usuario admin (senha: 123)
INSERT INTO Usuario (NomeCompleto, Email, SenhaHash)
VALUES (
    'Administrador do Sistema',
    'admin@admin.com',
    HASHBYTES('SHA2_256', '123') 
);
GO