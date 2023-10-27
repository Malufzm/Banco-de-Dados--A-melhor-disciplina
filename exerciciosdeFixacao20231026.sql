1-
CREATE TRIGGER cliente_inserido_trigger
AFTER INSERT ON Clientes
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (mensagem, data_hora)
    VALUES ('Novo cliente inserido em ' || NEW.nome, NOW());
END;

2-
DELIMITER //
CREATE TRIGGER TentativaExclusaoClienteNaAuditoria
BEFORE DELETE ON Clientes
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (mensagem)
    VALUES (CONCAT('Tentativa de exclusão do cliente: ', OLD.nome));
END;
//
DELIMITER ;

3-
DELIMITER //
CREATE TRIGGER AtualizaNomeClienteNaAuditoria
AFTER UPDATE ON Clientes
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (mensagem)
    VALUES (CONCAT('Nome do cliente atualizado de ', OLD.nome, ' para ', NEW.nome));
END;
//
DELIMITER ;

4-
DELIMITER //
CREATE TRIGGER ImpedeAtualizacaoNomeNuloOuVazio
BEFORE UPDATE ON Clientes
FOR EACH ROW
BEGIN
    IF NEW.nome IS NULL OR NEW.nome = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Não é permitido atualizar o nome para NULL ou string vazia';
    END IF;
END;
//
DELIMITER ;
