USE Biblioteca2;

INSERT INTO Emprestimo VALUES
(4, 2, 4, '2025-02-09', '2025-03-14')

-- Quantos livros existem cadastrados na biblioteca?
SELECT COUNT (*) AS QtdLivros FROM Livro;

-- Qual é o ano médio de publicação dos livros?
SELECT AVG(ano) AS AnoMedio FROM Livro;

-- Qual leitor fez o maior número de empréstimos?************************************************************************

-- Mostre os 3 primeiros caracteres de todos os nomes de autores.
SELECT LEFT(nome, 3) AS Primeiros3 FROM Autor;

-- Exiba os títulos de livros com todas as letras em minúsculo.
SELECT LOWER(titulo) FROM Livro;

--Mostre apenas os leitores cujo e-mail termina com ".com".***********************************************************************

--Substitua a palavra “estrela” por “sol” no título do livro da Clarice Lispector.
SELECT REPLACE(titulo, 'estrela', 'sol') FROM Livro;

-- Mostre os empréstimos realizados no mês de agosto de 2025 (mostrar número do mês).
SELECT * FROM Emprestimo
WHERE MONTH(data_emprestimo) = 8 AND YEAR(data_emprestimo) = 2025;

-- Calcule quantos dias se passaram desde o primeiro empréstimo registrado até hoje.***************************************************

-- Mostre a data do empréstimo e o nome do dia da semana em que ele aconteceu.*********************************************************

-- Liste os livros publicados entre 1950 e 2005, mas que não sejam de J. K. Rowling. ****************************

-- Mostre todos os leitores que têm nome começando com a letra “C”.
SELECT * FROM Leitor
WHERE nome Like 'C%'

-- Mostre os empréstimos que aconteceram em 2025, mas ainda não foram devolvidos. **************************************************

-- Liste os autores que **não** têm nenhum livro cadastrado no banco (dica: `LEFT JOIN`).
