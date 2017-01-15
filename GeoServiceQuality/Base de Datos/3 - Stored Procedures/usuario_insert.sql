CREATE OR REPLACE FUNCTION usuario_insert
(
   pEmail VARCHAR(40)
   , pUsuarioPassword VARCHAR(40)
   , pGrupoID INT
   , pNombre VARCHAR(40)
   , pApellido VARCHAR(40)
   , pTelefono BIGINT
   , pInstitucionID INT
)
RETURNS VOID AS $$

/************************************************************************************************************
** Name: usuario_insert
**
** Desc: Agrega un usuario a la tabla Usuarios
**
** 02/12/2016 Created
**
*************************************************************************************************************/
BEGIN
    
   -- parametros requeridos
   IF (pEmail IS NULL OR pUsuarioPassword IS NULL OR pGrupoID IS NULL)
   THEN
      RAISE EXCEPTION 'Error - Los parametro email, password y grupo del usuario son requerido.';
   END IF;
    
   IF EXISTS (SELECT 1 FROM Usuario u WHERE u.Email = pEmail)
   THEN      
      RAISE EXCEPTION 'Error - El email ya fue registrado. Usario ya existente.';
   END IF;

   INSERT INTO Usuario
   (Email, UsuarioPassword, GrupoID, Nombre, Apellido, Telefono, InstitucionID)
   VALUES
   (pEmail, pUsuarioPassword, pGrupoID, pNombre, pApellido, pTelefono, pInstitucionID);
    
END;
$$ LANGUAGE plpgsql;