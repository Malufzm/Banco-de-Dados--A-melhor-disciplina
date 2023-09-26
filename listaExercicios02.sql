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

Exercício 6:
DELIMITER //

CREATE PROCEDURE sp_TitulosPorCategoria(IN categoriaNome VARCHAR(100))
BEGIN
    SELECT Livro.Titulo
    FROM Livro
    INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
    WHERE Categoria.Nome = categoriaNome;
END //

DELIMITER ;

CALL sp_TitulosPorCategoria('Romance');

CALL sp_TitulosPorCategoria('Ciência');

Exercício 7:
DELIMITER //

CREATE PROCEDURE sp_AdicionarLivro(IN tituloLivro VARCHAR(255), IN editoraID INT, IN anoPublicacao INT, IN numeroPaginas INT, IN categoriaID INT, OUT mensagem VARCHAR(255))
BEGIN
    DECLARE livroExiste INT;
    
    SELECT COUNT(*) INTO livroExiste
    FROM Livro
    WHERE Titulo = tituloLivro;
    
    IF livroExiste > 0 THEN
        SET mensagem = 'Erro: O livro com o título já existe.';
    ELSE
        INSERT INTO Livro (Titulo, Editora_ID, Ano_Publicacao, Numero_Paginas, Categoria_ID)
        VALUES (tituloLivro, editoraID, anoPublicacao, numeroPaginas, categoriaID);
        
        SET mensagem = 'Livro adicionado com sucesso.';
    END IF;
END //

DELIMITER ;

DECLARE @mensagem VARCHAR(255);

CALL sp_AdicionarLivro('Novo Livro', 1, 2022, 300, 2, @mensagem);

SELECT @mensagem;

Exercício 8:
DELIMITER //

CREATE PROCEDURE sp_AutorMaisAntigo(OUT nomeAutorMaisAntigo VARCHAR(255))
BEGIN
    SELECT CONCAT(Nome, ' ', Sobrenome) INTO nomeAutorMaisAntigo
    FROM Autor
    WHERE Data_Nascimento = (SELECT MIN(Data_Nascimento) FROM Autor);
END //

DELIMITER ;
DECLARE @nomeAutorMaisAntigo VARCHAR(255);

CALL sp_AutorMaisAntigo(@nomeAutorMaisAntigo);

SELECT @nomeAutorMaisAntigo;

Exercício 9:
DELIMITER //

CREATE PROCEDURE sp_TitulosPorCategoria(IN categoriaNome VARCHAR(100))
BEGIN

    SELECT Livro.Titulo
    FROM Livro
    INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
    WHERE Categoria.Nome = categoriaNome;

END //

DELIMITER ;

--DELIMITER //: Isso define um novo delimitador para a criação da stored procedure, permitindo que você use // em vez de ; como delimitador no corpo da stored procedure.
--CREATE PROCEDURE sp_TitulosPorCategoria(IN categoriaNome VARCHAR(100)): Aqui, estamos criando a stored procedure chamada sp_TitulosPorCategoria. Ela aceita um único parâmetro de entrada chamado categoriaNome, que é do tipo VARCHAR e representa o nome da categoria pela qual queremos listar os títulos dos livros.
--BEGIN: O início do bloco da stored procedure.
--SELECT Livro.Titulo: Esta parte da query seleciona os títulos dos livros da tabela Livro.
--FROM Livro: Estamos selecionando os dados da tabela Livro.
--INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID: Aqui, estamos usando INNER JOIN para combinar as tabelas Livro e Categoria com base no ID da categoria. Isso nos permite vincular os livros à categoria a que pertencem.
--WHERE Categoria.Nome = categoriaNome;: O WHERE filtra os resultados para incluir apenas os livros cuja categoria corresponde ao nome da categoria passado como parâmetro.
--END //: Isso marca o final do bloco da stored procedure.
--DELIMITER ;: Restaura o delimitador padrão para ;.
