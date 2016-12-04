USE GeoServiceQuality;

DROP PROCEDURE IF EXISTS spUsuarioDelete;

DELIMITER //

CREATE PROCEDURE spUsuarioDelete
(
	pUsuarioID INT
    , OUT pError INT -- 0 si ok, 1 si hay error por parametros
)

/************************************************************************************************************
** Name: dbo.spUsuarioDelete
**
** Desc: Quita el Usuario de UsuarioID de la tabla Usuario
**
** 04/12/2016 Created
**
*************************************************************************************************************/
-- TODO: Asegurarse desde el codigo o BD que al solicitar un borrado, no se llamen a posibles instancias pendientes de evaluacion para el usuario eliminado
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

	-- Borrado de registros dependientes del usuario
	
    DELETE FROM GeoServiceQuality.UsuarioObjeto
    WHERE UsuarioID = pUsuarioID;
    
    DELETE ep
    FROM GeoServiceQuality.EvaluacionParcial ep
    INNER JOIN GeoServiceQuality.Evaluacion e ON e.EvaluacionID = ep.EvaluacionID
    WHERE e.UsuarioID = pUsuarioID;
    
	DELETE FROM GeoServiceQuality.Evaluacion
    WHERE UsuarioID = pUsuarioID;
    
    -- Borrado del usuario de la tabla Usuario
    
    DELETE FROM GeoServiceQuality.Usuario
    WHERE UsuarioID = pUsuarioID;
    
END //