USE GeoServiceQuality;

DROP PROCEDURE IF EXISTS spUsuarioUpdate;

DELIMITER //

CREATE PROCEDURE spUsuarioUpdate
(
	pUsuarioID INT
    , pEmail VARCHAR(40)
    , pUsuarioPassword VARCHAR(40)
    , pGrupoID TINYINT
    , pNombre VARCHAR(40)
    , pApellido VARCHAR(40)
    , pTelefono BIGINT
    , pCambios VARCHAR(100) -- Contiene lista de campos que fueron modificados
    , OUT pError INT -- 0 si ok, 1 si hay error por parametros
)

/************************************************************************************************************
** Name: dbo.spUsuarioUpdate
**
** Desc: Actualiza los datos personales del usuario
**
** 04/12/2016 Created
**
*************************************************************************************************************/
BEGIN
    
    DECLARE Mensaje VARCHAR(50);
    
	SET SQL_SAFE_UPDATES = 0;
    SET pError = 0;
    
	-- parametros requeridos
	IF (pUsuarioID IS NULL)
	THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error - El parametro ID de usuario es requerido.';
        SET pError = 1;
	END IF;
    
	IF NOT EXISTS (SELECT 1 FROM GeoServiceQuality.Usuario WHERE UsuarioID = pUsuarioID)
	THEN
		SET Mensaje = CONCAT('Error - El usuario de ID: ', pUsuarioID,' no existe.');
		
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = Mensaje;
        SET pError = 1;
	END IF;    

    -- TODO: Ver si realizar un update dinamico o estatico, segun si en codigo es facil decir que datos fueron los que cambiaron y enviarlos en una cadena separada por !
    
END //