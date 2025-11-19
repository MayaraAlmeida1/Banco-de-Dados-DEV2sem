
DROP DATABASE SistemaFuncionariosDB;

CREATE DATABASE SistemaFuncionariosDB;
GO

USE SistemaFuncionariosDB;
GO

CREATE TABLE TabelaFuncionario
(
    Id           INT IDENTITY(1,1) NOT NULL,
    Nome         NVARCHAR(120)     NOT NULL,
    SalarioBase  DECIMAL(10,2)     NOT NULL,
    Cargo        NVARCHAR(30)      NOT NULL,
    CONSTRAINT PK_TabelaFuncionario PRIMARY KEY(Id)
);
GO

INSERT INTO TabelaFuncionario (Nome, SalarioBase, Cargo) VALUES
('Ana Gerente', 8000.00, 'Gerente'),
('Bruno Vendedor', 3500.00, 'Vendedor'),
('Clara Vendedora', 4200.00, 'Vendedor'),
('Diego Gerente', 9500.00, 'Gerente');
GO