USE GeoServiceQuality;

DROP PROCEDURE IF EXISTS spDatosDeUsuarioGet;

DELIMITER //

CREATE PROCEDURE spDatosDeUsuarioGet
(
	pEmail VARCHAR(40)
    , pUsuarioPassword VARCHAR(40)
    , OUT pError INT -- 0 si ok, 1 si hay error por parametros
)

/************************************************************************************************************
** Name: dbo.spDatosDeUsuarioGet
**
** Desc: Devuelve datos de interes del usuario (datos personales y conjunto de permisos) de acuerdo con su información de login
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
        , g.Nombre AS GrupoNombre
        , p.Nombre AS PermisoNombre
    FROM GeoServiceQuality.Usuario u
    INNER JOIN GeoServiceQuality.Grupo g ON g.GrupoID = u.GrupoID
    INNER JOIN GeoServiceQuality.PermisoGrupo pg ON pg.GrupoID = g.GrupoID
    INNER JOIN GeoServiceQuality.Permiso p ON p.PermisoID = pg.PermisoID
    WHERE u.Email = pEmail
		AND u.UsuarioPassword = pUsuarioPassword
	ORDER BY p.PermisoID; 
			
END //
   	