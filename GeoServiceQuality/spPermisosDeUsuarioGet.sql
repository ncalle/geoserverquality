USE GeoServiceQuality;

DROP PROCEDURE IF EXISTS spPermisosDeUsuarioGet;

DELIMITER //

CREATE PROCEDURE spPermisosDeUsuarioGet
(
	pUsuarioID INT
    , OUT pError INT -- 0 si ok, 1 si hay error por parametros
)

/************************************************************************************************************
** Name: dbo.spPermisosDeUsuarioGet
**
** Desc: Devuelve conjunto de permisos del usuario pasado por parametro
**
** 04/12/2016 Created
**
*************************************************************************************************************/
BEGIN

	DECLARE Mensaje VARCHAR(50);
    
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

	-- Lista de datos personales y permisos sobre la herramienta
	SELECT u.UsuarioID
        , g.Nombre AS GrupoNombre
        , p.Nombre AS PermisoNombre
    FROM GeoServiceQuality.Usuario u
    INNER JOIN GeoServiceQuality.Grupo g ON g.GrupoID = u.GrupoID
    INNER JOIN GeoServiceQuality.PermisoGrupo pg ON pg.GrupoID = g.GrupoID
    INNER JOIN GeoServiceQuality.Permiso p ON p.PermisoID = pg.PermisoID
    WHERE u.UsuarioID = pUsuarioID
	ORDER BY p.PermisoID; 
			
END //