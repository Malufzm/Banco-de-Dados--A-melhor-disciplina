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
