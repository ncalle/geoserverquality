USE GeoServiceQuality;

DROP PROCEDURE IF EXISTS spUsuarioInsert;

DELIMITER //

CREATE PROCEDURE spUsuarioInsert
(
	pEmail VARCHAR(40)
    , pUsuarioPassword VARCHAR(40)
    , pGrupoID INT
    , pNombre VARCHAR(40)
    , pApellido VARCHAR(40)
    , pTelefono BIGINT
    , OUT pError INT -- 0 si ok, 1 si hay error por parametros
)

/************************************************************************************************************
** Name: dbo.spUsuarioInsert
**
** Desc: Agrega un usuario a la tabla Usuarios
**
** 02/12/2016 Created
**
*************************************************************************************************************/
BEGIN

	DECLARE Mensaje VARCHAR(50);

	SET pError = 0;
    
	-- parametros requeridos
	IF (pEmail IS NULL OR pUsuarioPassword IS NULL OR pGrupoID IS NULL)
	THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error - Los parametro email, password y grupo del usuario son requerido.';
        SET pError = 1;
	END IF;
    
	IF EXISTS (SELECT 1 FROM GeoServiceQuality.Usuario WHERE Email = pEmail)
	THEN
		SET Mensaje = CONCAT('Error - El email ya fue registrado. Usario ya existente.');
		
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = Mensaje;
        SET pError = 1;
	END IF;

	INSERT INTO GeoServiceQuality.Usuario
    (Email, UsuarioPassword, GrupoID, Nombre, Apellido, Telefono)
    VALUES
    (pEmail, pUsuarioPassword, pGrupoID, pNombre, pApellido, pTelefono);
    
END //