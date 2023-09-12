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
