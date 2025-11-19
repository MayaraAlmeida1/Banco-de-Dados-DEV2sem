
CREATE DATABASE SistemaAnimaisDBFirst;
GO

USE SistemaAnimaisDBFirst;
GO

CREATE TABLE TabelaAnimal(
	Id			INT IDENTITY(1,1)	NOT NULL,
	Nome		NVARCHAR(120)		NOT NULL,
	Animal		NVARCHAR(120)		NOT NULL,
	Som			NVARCHAR(80)		NOT NULL,
	Alimentação NVARCHAR(120)		NOT NULL,					
	CONSTRAINT PK_TabelaAnimal PRIMARY KEY(Id)
);
GO

INSERT INTO TabelaAnimal(Nome, Animal, Som, Alimentação) VALUES
('Simba', 'Leão', 'Rugido', 'Carnívoro'),
('Dumbo', 'Elefante', 'Barrito', 'Herbívoro');
GO

SELECT * FROM TabelaAnimal;
GO
