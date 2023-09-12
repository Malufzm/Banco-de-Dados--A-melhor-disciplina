/*1º exercício*/
SELECT titulo FROM livros;

/*2º exercício*/
SELECT nome
FROM autores
WHERE nascimento < '1900-01-01';

/*3º exercício*/
SELECT titulo 
FROM livros
INNER JOIN autores ON livros.autor_id = autores.id
WHERE autores.nome = 'J.K. Rowling';

/*4º exercício*/
SELECT nome
FROM alunos
INNER JOIN matriculas ON alunos.id = matriculas.aluno_id
WHERE matriculas.curso = 'Engenharia de Software';

/*5º exercício*/
SELECT produto, SUM(receita) AS total_receita
FROM vendas
GROUP BY produto;

/*6º exercício*/
SELECT autores.nome AS autor, COUNT(livros.id) AS numero_de_livros
FROM autores
LEFT JOIN livros ON autores.id = livros.autor_id
GROUP BY autores.nome;

/*7º exercício*/
SELECT curso, COUNT(aluno_id) AS alunos_totais
FROM matriculas
GROUP BY curso;

/*8º exercício*/
SELECT produto, AVG(receita) AS media_da_receita
FROM vendas
GROUP BY produto;

/*9º exercício*/
SELECT produto, SUM(receita) AS total_da_receita
FROM vendas
GROUP BY produto
HAVING SUM(receita) > 10000.00;

/*10º exercício*/
SELECT autores.nome AS autor, COUNT(livros.id) AS numero_de_livros
FROM autores
LEFT JOIN livros ON autores.id = livros.autor_id
GROUP BY autores.nome
HAVING COUNT(livros.id) >= 2;

/*11º exercício*/
SELECT livros.titulo AS livro,
autores.nome AS autor
FROM livros
INNER JOIN autores ON livros.autor_id = autores.id;

/*12º exercício*/
SELECT alunos.nome AS aluno,
matriculas.curso
FROM alunos
INNER JOIN matriculas ON alunos.id = matriculas.aluno_id;

/*13º exercício*/
SELECT autores.nome AS autor, livros.titulo
FROM autores
LEFT JOIN livros ON autores.id = livros.autor_id;

/*14º exercício*/
SELECT matriculas.curso, alunos.nome AS aluno
FROM matriculas
RIGHT JOIN alunos ON matriculas.aluno_id = alunos.id;

/*15º exercício*/
SELECT alunos.nome AS aluno, matriculas.curso
FROM alunos
INNER JOIN matriculas ON alunos.id = matriculas.aluno_id;

/*16º exercício*/
SELECT autores.nome AS autor, COUNT(livros.id) AS numero_de_livros
FROM autores
LEFT JOIN livros ON autores.id = livros.autor_id
GROUP BY autores.nome
ORDER BY numero_de_livros DESC
LIMIT 1;

/*17º exercício*/
SELECT produto, SUM(receita) AS total_da_receita
FROM vendas
GROUP BY produto
ORDER BY total_da_receita ASC
LIMIT 1;

/*18º exercício*/
SELECT autores.nome AS autor, 
COUNT(livros.id) AS numero_de_livros,
COUNT(livros.id) * 20 AS total_da_receita
FROM autores
LEFT JOIN livros ON autores.id = livros.autor_id
GROUP BY autores.nome;

/*19º exercício*/
SELECT alunos.nome AS aluno,
COUNT(matriculas.id) AS total_de_matriculas
FROM alunos
LEFT JOIN matriculas ON alunos.id = matriculas.aluno_id
GROUP BY alunos.nome
ORDER BY total_de_matriculas DESC;
