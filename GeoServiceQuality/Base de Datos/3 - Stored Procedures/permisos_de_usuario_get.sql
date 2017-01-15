CREATE OR REPLACE FUNCTION permisos_de_usuario_get
(
   pUsuarioID INT
)
RETURNS TABLE (UsuarioID INT, GrupoNombre VARCHAR(40), PermisoNombre VARCHAR(40)) AS $$

/************************************************************************************************************
** Name: permisos_de_usuario_get
**
** Desc: Devuelve conjunto de permisos del usuario pasado por parametro
**
** 04/12/2016 Created
**
*************************************************************************************************************/
BEGIN

   -- parametros requeridos
   IF (pUsuarioID IS NULL)
   THEN
      RAISE EXCEPTION 'Error - El parametro ID de usuario es requerido.';
   END IF;
    
   IF NOT EXISTS (SELECT 1 FROM Usuario u WHERE u.UsuarioID = pUsuarioID)
   THEN    
      RAISE EXCEPTION 'Error - El usuario de ID: % no existe.', pUsuarioID;
   END IF;    

   -- Lista de datos personales y permisos sobre la herramienta
   RETURN QUERY
   SELECT u.UsuarioID
      , g.Nombre AS GrupoNombre
      , p.Nombre AS PermisoNombre
   FROM Usuario u
   INNER JOIN Grupo g ON g.GrupoID = u.GrupoID
   INNER JOIN PermisoGrupo pg ON pg.GrupoID = g.GrupoID
   INNER JOIN Permiso p ON p.PermisoID = pg.PermisoID
   WHERE u.UsuarioID = pUsuarioID
   ORDER BY p.PermisoID;

END;
$$ LANGUAGE plpgsql;