
CREATE DATABASE SistemaVeiculosDBFirst;
GO

USE SistemaVeiculosDBFirst;
GO

CREATE TABLE TabelaVeiculo (
	Id           INT IDENTITY(1,1) NOT NULL,
    Modelo         NVARCHAR(120)     NOT NULL,
    Marca          NVARCHAR(80)    NOT NULL,
    Ano  I(10,2)     NOT NULL,
    TipoVeiculo        NVARCHAR(30)      NOT NULL,
    CONSTRAINT PK_TabelaFuncionario PRIMARY KEY(Id)
);
GO

INSERT INTO TabelaVeiculo(Modelo, Marca, Ano, TipoVeiculo)VALUES
('Scooter Nmax Connected 160 Mandalorian', 'Yamaha', 2023, 'Moto'),
('Q6 Sportback e-tron', 'Audi', 2025, 'Carro'),
('M4 Competition', 'BMW', 2022, 'Carro');
GO

SELECT * FROM TabelaVeiculo;