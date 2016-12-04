USE GeoServiceQuality;

DROP PROCEDURE IF EXISTS spUsuarioGet;

DELIMITER //

CREATE PROCEDURE spUsuarioGet
(
	pEmail VARCHAR(40)
    , pUsuarioPassword VARCHAR(40)
    , OUT pError INT -- 0 si ok, 1 si hay error por parametros
)

/************************************************************************************************************
** Name: dbo.spUsuarioGet
**
** Desc: Devuelve los datos personales del usuario pasado por parametro segun mail y password
**
** 02/12/2016 Created
**
*************************************************************************************************************/
BEGIN

	SET pError = 0;
    
	-- parametros requeridos
	IF (pEmail IS NULL OR pUsuarioPassword IS NULL)
	THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error - Los parametro email y password del usuario son requerido.';
        SET pError = 1;
	END IF;

	-- Lista de datos personales y permisos sobre la herramienta
	SELECT u.Nombre AS UsuarioNombre
		, u.Apellido AS UsuarioApellido
        , u.Telefono AS UsuarioTelefono
    FROM GeoServiceQuality.Usuario u
    WHERE u.Email = pEmail
		AND u.UsuarioPassword = pUsuarioPassword;
			
END //