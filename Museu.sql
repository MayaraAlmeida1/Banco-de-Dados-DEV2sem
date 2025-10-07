CREATE DATABASE Museu;
GO

USE Museu;
GO

CREATE TABLE Artista(
	id_art INT PRIMARY KEY,
	Nome NVARCHAR(100) NOT NULL
);
GO

CREATE TABLE Obra(
	id_obra INT PRIMARY KEY,
	Título NVARCHAR(100) NOT NULL,
	id_art INT FOREIGN KEY REFERENCES Artista(id_art),
	ano INT
);
GO

CREATE TABLE Sala(
	id_sala INT PRIMARY KEY,
	codigo INT UNIQUE NOT NULL
);
GO

CREATE TABLE Exposicao(
	id_exp INT PRIMARY KEY,
	id_sala INT FOREIGN KEY REFERENCES Sala(id_sala),
	id_obra INT FOREIGN KEY REFERENCES Obra(id_obra),
	data_inicio DATE NOT NULL
);
GO

INSERT INTO Artista VALUES
(1, 'Vincent van Gogh'),
(2, 'Leonardo da Vinci'),
(3, 'Tarsila do Amaral'),
(4, 'Paul Cézanne');
GO

INSERT INTO Obra VALUES
(1234, 'Homem Vitruviano', 2, 1490),
(1345, 'A Noite Estrelada', 1, 1889),
(1456, 'Os Girassóis', 1, 1888),
(1567, 'Mona Lisa', 2, 1503),
(1678, 'As Banhistas', 4, 1898),
(1789, 'O Cesto de Maçãs', 4, 1895),
(1890, 'A Cuca', 3, 1924),
(1901, 'Lírios', 1, 1889),
(2134, 'Abaporu', 3, 1928),
(2234, 'A Lua', 3, 1928);
GO

INSERT INTO Sala VALUES
(1, 9874),
(2, 8745),
(3, 7456),
(4, 6541),
(5, 5412);
GO

INSERT INTO Exposicao VALUES
(1, 2, 2234, '2025-11-14'),
(2, 4, 1234, '2025-11-28'),
(3, 1, 2134, '2025-12-08'),
(4, 5, 1345, '2025-12-16'),
(5, 3, 1901, '2025-12-29'),
(6, 3, 1456, '2026-01-13'),
(7, 2, 1890, '2026-01-24'),
(8, 1, 1567, '2026-02-04'),
(9, 4, 1789, '2026-02-18'),
(10, 1, 1678, '2026-03-25');
GO

SELECT * FROM Artista;
GO
SELECT * FROM Obra;
GO
SELECT * FROM Sala;
GO

SELECT o.Título, o.ano, a.Nome
FROM Obra o
INNER JOIN Artista a ON o.id_Art = a.id_art;
GO

SELECT o.Título AS Título, e.data_inicio, a.Nome
FROM Obra o
LEFT JOIN Exposicao e ON e.id_obra = o.id_obra
LEFT JOIN Artista a ON a.id_art = o.id_art;
GO

-- Atualizar um registro
UPDATE Sala SET codigo = 4123
WHERE codigo = 5412;

SELECT * FROM Sala;

-- Renomear tabela
EXEC sp_rename 'sala', 'salão';
SELECT * FROM salão;

-- Renomear coluna
EXEC sp_rename 'Artista.id_art', 'id_artista'
SELECT * FROM Artista;

EXEC sp_rename 'Obra.id_art', 'id_artista'
SELECT * FROM Obra;

EXEC sp_rename 'Salão.id_sala', 'id_salao'
SELECT * FROM salão;

-- Alterando o tamanho do tipo do dado
ALTER TABLE Artista
ALTER COLUMN Nome NVARCHAR(100) NOT NULL; 

EXEC sp_help 'Artista'; -- o NVARCHAR dobra o tamanho da variável pq ele armazena dois pra cada um

-- Deletar um registro (exposição)
DELETE Exposicao
WHERE id_exp = 10;
SELECT * FROM Exposicao;

-- Apagando chave estrangeira em obra
ALTER TABLE Obra 
DROP CONSTRAINT FK_Obra;

-- Apagando chave primária
ALTER TABLE Artista 
DROP CONSTRAINT PK_Artista;

SELECT * FROM Artista;
SELECT * FROM Obra;

-- Recriando chave primária
ALTER TABLE Artista
ADD CONSTRAINT Pk_artista PRIMARY KEY(id_artista);

-- Recriando chave estrangeira
ALTER TABLE Obra
ADD CONSTRAINT FK_id_artista
FOREIGN KEY (id_artista) REFERENCES Artista(id_artista)
ON DELETE CASCADE

SELECT * FROM Artista;
SELECT * FROM Obra;

-- Deletar uma obra
DELETE Obra
WHERE id_obra = 1678;

SELECT * FROM Obra;

-- Adicionar novas colunas
ALTER TABLE Artista
ADD ano_nascimento INT;

SELECT * FROM Artista;

EXEC sp_rename 'Artista.ano_nascimento', 'país';
SELECT * FROM Artista;

ALTER TABLE Artista
ALTER COLUMN país NVARCHAR(100);

-- Inserindo os valores
UPDATE Artista SET país = 'Países Baixos'
WHERE id_artista = 1;

UPDATE Artista SET país = 'Itália'
WHERE id_artista = 2;

UPDATE Artista SET país = 'Brasil'
WHERE id_artista = 3;

UPDATE Artista SET país = 'França'
WHERE id_artista = 4;

SELECT * FROM Artista;
SELECT * FROM Obra;