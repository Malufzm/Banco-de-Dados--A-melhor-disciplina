Exercício 1:
DELIMITER //
CREATE PROCEDURE sp_ListarAutores()
BEGIN
    SELECT * FROM Autor;
END //
DELIMITER ;
CALL sp_ListarAutores();

Exercício 2:
DELIMITER //
CREATE PROCEDURE sp_LivrosPorCategoria(IN categoriaNome VARCHAR(100))
BEGIN
    SELECT Livro.Titulo, Autor.Nome, Autor.Sobrenome
    FROM Livro
    INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
    INNER JOIN Autor_Livro ON Livro.Livro_ID = Autor_Livro.Livro_ID
    INNER JOIN Autor ON Autor_Livro.Autor_ID = Autor.Autor_ID
    WHERE Categoria.Nome = categoriaNome;
END //
DELIMITER ;
-- Exemplo 1: Listar livros da categoria "Romance"
CALL sp_LivrosPorCategoria('Romance');

-- Exemplo 2: Listar livros da categoria "Ciência"
CALL sp_LivrosPorCategoria('Ciência');

-- Exemplo 3: Listar livros da categoria "Ficção Científica"
CALL sp_LivrosPorCategoria('Ficção Científica');
