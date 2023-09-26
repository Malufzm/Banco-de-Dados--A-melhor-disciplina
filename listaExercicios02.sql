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
CALL sp_LivrosPorCategoria('Romance');
CALL sp_LivrosPorCategoria('Ciência');
CALL sp_LivrosPorCategoria('Ficção Científica');

Exercício 3:
DELIMITER //
CREATE PROCEDURE sp_ContarLivrosPorCategoria(IN categoriaNome VARCHAR(100), OUT totalLivros INT)
BEGIN
    SELECT COUNT(*) INTO totalLivros
    FROM Livro
    INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
    WHERE Categoria.Nome = categoriaNome;
END //
DELIMITER ;
DECLARE @resultado INT;
CALL sp_ContarLivrosPorCategoria('Romance', @resultado);
SELECT @resultado;

Exercício 4:
DELIMITER //

CREATE PROCEDURE sp_VerificarLivrosCategoria(IN categoriaNome VARCHAR(100), OUT possuiLivros BOOLEAN)
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM Livro
    INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
    WHERE Categoria.Nome = categoriaNome;

    IF total > 0 THEN
        SET possuiLivros = TRUE;
    ELSE
        SET possuiLivros = FALSE;
    END IF;
END //

DELIMITER ;
DECLARE @resultado BOOLEAN;
CALL sp_VerificarLivrosCategoria('Romance', @resultado);
SELECT @resultado;

Exercício 5:
DELIMITER //

CREATE PROCEDURE sp_LivrosAteAno(IN anoPublicacao INT)
BEGIN
    SELECT Livro.Titulo, Livro.Ano_Publicacao
    FROM Livro
    WHERE Livro.Ano_Publicacao <= anoPublicacao;
END //

DELIMITER ;

CALL sp_LivrosAteAno(2010);

CALL sp_LivrosAteAno(2015);
