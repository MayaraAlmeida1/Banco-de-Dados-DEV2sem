-- DDL - Linguagem de definição de dados
-- DROP DATABASE Clinica_Medica;

-- CRIAR BASE DE DADOS (Clinica médica)
CREATE DATABASE Clinica_Medica;
GO -- ele executa cada um dos comandos, uma de cada vez, em ordem

USE Clinica_Medica;
GO

--TABELA PACIENTE
CREATE TABLE Paciente(
	CPF VARCHAR(14) PRIMARY KEY,
	Nome VARCHAR(40),
	Telefone VARCHAR(30),
	NumeroPlano INT,
	NomePlano VARCHAR(20),
	TipoPlano VARCHAR(10)
);
GO

--TABELA MÉDICO
CREATE TABLE Medico(
 CRM INT PRIMARY KEY,
 NomeMedico VARCHAR(30),
 Especialidade VARCHAR(20)
);
GO

-- TABELA CONSULTA -- se relaciona com a tabela do médico e do paciente
CREATE TABLE Consulta(
	NumeroConsulta INT PRIMARY KEY IDENTITY(100,1),-- (valor inicial, Incremento) - incrementa 1 numero a cada novo registro
	DataConsulta DATE,
	HorarioConsulta TIME,
	CRM_Medico INT FOREIGN KEY REFERENCES Medico(CRM), -- Inserção de chave estrangeira "Tabela(atributo)"-trm que usar o mesmo tipo de dado
	CPF_Paciente VARCHAR(14) FOREIGN KEY REFERENCES Paciente(CPF)
);
GO

SELECT * FROM Paciente;
SELECT * FROM Medico;
SELECT * FROM Consulta;

INSERT INTO Paciente VALUES
(12345678900, 'Ana Carolina Silva', 11912345678, 1001, 'Amil', 'Ind'),
(98765432100, 'Bruno Mendes Costa', 21998765432, 1002, 'Notedrame', 'Fam'),
(32165498711, 'Carlos Henrique Souza', 31934567890, 1003, 'Cassi', 'Fam'),
(45612378922, 'Daniela Rocha Lima', 41976543210, 1004, 'Amil', 'Emp'),
(78932145633, 'Eduardo Paiva Ramos', 51987654321, 1005, 'Cassi', 'Emp'),
(65498732144, 'Fernanda Alves Nogueira', 61945678901, 1006, 'SulAmérica Saúde', 'Ind');
GO

INSERT INTO Medico VALUES
(101001, 'Dr. Ricardo Martins', 'Cardiologia'),
(101002, 'Dra. Juliana Prado', 'Pediatria'),
(101003, 'Dr. Fernando Lopes', 'Ortopedia'),
(101004, 'Dra. Camila Andrade', 'Ginecologia'),
(101005, 'Dr. Marcelo Vieira', 'Neurologia');
GO

INSERT INTO Consulta (DataConsulta, HorarioConsulta, CRM_Medico,CPF_Paciente) VALUES -- A coluna de NumeroConsulta é preenchida automaticamente
('2025-05-13', '10:00',101002, 98765432100),
('2025-05-24', '14:00', 101005, 78932145633),
('2025-07-17', '8:00', 101004, 12345678900),
('2025-08-22', '16:00', 101003, 32165498711),
('2025-09-08', '14:00', 101001, 65498732144),
('2025-10-04', '15:30', 101003, 45612378922);
GO

SELECT Nome FROM Paciente;
SELECT NomeMedico, Especialidade FROM Medico;

SELECT c.NumeroConsulta, c.DataConsulta, c.HorarioConsulta,
       p.Nome AS NomePaciente, m.NomeMedico, m.Especialidade
FROM Consulta c
INNER JOIN Paciente p ON c.CPF_Paciente = p.CPF
INNER JOIN Medico m ON c.CRM_Medico = m.CRM;

SELECT * FROM Consulta
WHERE CPF_Paciente = 12345678900;

SELECT * FROM Consulta
WHERE CRM_Medico = 101003;

UPDATE Paciente SET NumeroPlano = 1008
WHERE NumeroPlano = 1006;
GO

UPDATE Paciente SET NumeroPlano = 1015
WHERE NumeroPlano = 1004;
GO

UPDATE Paciente SET NumeroPlano = 1141
WHERE NumeroPlano = 1002;
GO

SELECT * FROM Paciente

DELETE FROM  Consulta
WHERE CPF_Paciente = 98765432100;
GO

DELETE FROM  Paciente
WHERE CPF = 98765432100;
GO

DELETE FROM  Consulta
WHERE CPF_Paciente = 65498732144;
GO

DELETE FROM  Paciente
WHERE CPF = 65498732144;
GO

SELECT * FROM Paciente

INSERT INTO Medico VALUES
(101025, 'Dr. Giovanna Spaca', 'Psiquiatria'),
(101254, 'Dra. Emilly Graciano', 'obstetrícia'),
(101149, 'Dr. Miguel Almeida', 'Dermatologia');
GO

INSERT INTO Paciente VALUES
(44444444444, 'Laura Midea Borges', 11453269874, 1454, 'Cassi', 'Ind'),
(88888888888, 'Rafael Bernal da Silva', 25364108975, 1668, 'Notedrame', 'Fam');
GO

UPDATE Medico SET Especialidade = 'Radiologia'
WHERE CRM = 101003;
GO

UPDATE Medico SET Especialidade = 'Anestesiologia'
WHERE CRM = 101002;
GO

UPDATE Medico SET Especialidade = 'Obstetrícia'
WHERE CRM = 101254;
GO

SELECT * FROM Medico;