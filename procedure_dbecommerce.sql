/* Chamada da procedure
  CALL sp_product(NULL, 'Produto 01', 1, 'Eletrônico', 1.10, 'size 01', 'insert', @retorno);
  CALL sp_product(1, 'Produto 01.1', 2, 'Brinquedos', 2.10, 'size 01.1', 'update', @retorno);  
  CALL sp_product(1, NULL, NULL, NULL, NULL, NULL, 'delete', @retorno);
  SELECT @retorno;
*/

DROP PROCEDURE IF EXISTS `sp_product`;
  
DELIMITER $$

CREATE PROCEDURE `sp_product` (    
    IN p_idProduct INT,
	IN p_Pname VARCHAR(255),
	IN p_classification_kids INT,
	IN p_category VARCHAR(255), 
	IN p_avaliacao FLOAT, 
	IN p_size VARCHAR(10),
    IN p_operacao VARCHAR(10),
    OUT p_retorno INT
)
BEGIN
	DECLARE exit handler for sqlexception
	BEGIN
		ROLLBACK;
		SET p_retorno = -1;
	END;
    
    DECLARE exit handler for sqlwarning
	BEGIN
		ROLLBACK;
		SET p_retorno = -2;
	END;
    
    START TRANSACTION;

    IF p_operacao = 'insert' THEN
        INSERT INTO product (Pname, classification_kids, category, avaliação, size) VALUES (p_Pname, p_classification_kids, p_category, p_avaliacao, p_size);
    ELSEIF p_operacao = 'update' THEN
        UPDATE product SET Pname = p_pname, classification_kids = p_classification_kids, category = p_category, avaliação = p_avaliacao, size = p_size WHERE idProduct = p_idProduct;  
    ELSEIF p_operacao = 'delete' THEN
        DELETE FROM product WHERE idProduct = p_idProduct;
    END IF;
    
    COMMIT;
	SET p_retorno = 0;
END$$

DELIMITER ;