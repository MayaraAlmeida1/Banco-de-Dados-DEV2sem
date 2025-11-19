USE Biblioteca2;

INSERT INTO Emprestimo VALUES
(4, 2, 4, '2025-02-09', '2025-03-14')

-- Quantos livros existem cadastrados na biblioteca?
SELECT COUNT (*) AS QtdLivros FROM Livro;

-- Qual é o ano médio de publicação dos livros?
SELECT AVG(ano) AS AnoMedio FROM Livro;

-- Qual leitor fez o maior número de empréstimos?
SELECT l.nome, COUNT(e.id_Emprestimo) AS QtdEmprestimos
FROM Emprestimo e
JOIN Leitor l ON e.id_Leitor = l.id_Leitor
GROUP BY l.nome
ORDER BY QtdEmprestimos DESC;

-- Mostre os 3 primeiros caracteres de todos os nomes de autores.
SELECT LEFT(nome, 3) AS Primeiros3 FROM Autor;

-- Exiba os títulos de livros com todas as letras em minúsculo.
SELECT LOWER(titulo) FROM Livro;

--Mostre apenas os leitores cujo e-mail termina com ".com".
SELECT nome, email FROM Leitor
WHERE email LIKE '%.com';

--Substitua a palavra “estrela” por “sol” no título do livro da Clarice Lispector.
SELECT REPLACE(titulo, 'estrela', 'sol') FROM Livro;

-- Mostre os empréstimos realizados no mês de agosto de 2025 (mostrar número do mês).
SELECT * FROM Emprestimo
WHERE MONTH(data_emprestimo) = 8 AND YEAR(data_emprestimo) = 2025;

-- Calcule quantos dias se passaram desde o primeiro empréstimo registrado até hoje.
SELECT DATEDIFF(DAY, MIN(data_emprestimo), GETDATE()) AS diasDesdePrimeiroEmprestimo FROM Emprestimo;

-- Mostre a data do empréstimo e o nome do dia da semana em que ele aconteceu.
SELECT data_emprestimo, DATENAME(WEEKDAY, data_emprestimo) AS dataSemanaEmprestimo FROM Emprestimo;

-- Liste os livros publicados entre 1950 e 2005, mas que não sejam de J. K. Rowling. 
SELECT l.titulo, l.ano, a.nome AS Autor
FROM Livro l
JOIN Autor a ON l.id_Autor = a.id_Autor
WHERE l.ano BETWEEN 1950 AND 2005
  AND a.nome <> 'J. K. Rowling'; -- '<>' significa "diferente de"

-- Mostre todos os leitores que têm nome começando com a letra “C”.
SELECT * FROM Leitor
WHERE nome Like 'C%'

-- Mostre os empréstimos que aconteceram em 2025, mas ainda não foram devolvidos. 
SELECT * FROM Emprestimo
WHERE YEAR(data_emprestimo) = 2025
  AND data_devolucao IS NULL; --Não tem livro que ainda não foi devolvido

-- Liste os autores que não têm nenhum livro cadastrado no banco (dica: `LEFT JOIN`).
SELECT a.nome FROM Autor a
LEFT JOIN Livro l ON a.id_Autor = l.id_Autor
WHERE l.id_Livro IS NULL; --Não possui

