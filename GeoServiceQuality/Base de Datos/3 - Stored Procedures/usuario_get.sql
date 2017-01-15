CREATE OR REPLACE FUNCTION usuario_get
(
    pEmail VARCHAR(40)
    , pUsuarioPassword VARCHAR(40)
) 
RETURNS TABLE (UsuarioID INT, Nombre VARCHAR(40), Apellido VARCHAR(40), Telefono BIGINT, InstitucionNombre VARCHAR(40)) AS $$

/************************************************************************************************************
** Name: usuario_get
**
** Desc: Devuelve los datos personales del usuario pasado por parametro segun mail y password
**
** 02/12/2016 Created
**
*************************************************************************************************************/
BEGIN
   
   -- parametros requeridos
   IF (pEmail IS NULL OR pUsuarioPassword IS NULL)
   THEN
      RAISE EXCEPTION 'Error - Los parametro email y password del usuario son requerido.';
   END IF;

   -- Lista de datos personales y permisos sobre la herramienta
   RETURN QUERY
   SELECT u.UsuarioID
      , u.Nombre
      , u.Apellido
      , u.Telefono
      , i.Nombre AS InstitucionNombre
   FROM Usuario u
   LEFT JOIN Institucion i ON i.InstitucionID = u.InstitucionID
   WHERE u.Email = pEmail
      AND u.UsuarioPassword = pUsuarioPassword;
               
END;
$$ LANGUAGE plpgsql;