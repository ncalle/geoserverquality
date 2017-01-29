CREATE OR REPLACE FUNCTION user_insert
(
   pEmail VARCHAR(40)
   , pPassword VARCHAR(40)
   , pUserGroupID INT
   , pFirstName VARCHAR(40)
   , pLastName VARCHAR(40)
   , pPhoneNumber BIGINT
   , pInstitutionID INT
)
RETURNS VOID AS $$

/************************************************************************************************************
** Name: user_insert
**
** Desc: Agrega un usuario a la tabla Usuarios
**
** 02/12/2016 Created
**
*************************************************************************************************************/
BEGIN
    
   -- parametros requeridos
   IF (pEmail IS NULL OR pPassword IS NULL OR pUserGroupID IS NULL)
   THEN
      RAISE EXCEPTION 'Error - Los parametro email, password y grupo del usuario son requerido.';
   END IF;
    
   IF EXISTS (SELECT 1 FROM SystemUser u WHERE u.Email = pEmail)
   THEN      
      RAISE EXCEPTION 'Error - El email ya fue registrado. Usario ya existente.';
   END IF;

   INSERT INTO SystemUser
   (Email, Password, UserGroupID, FirstName, LastName, PhoneNumber, InstitutionID)
   VALUES
   (pEmail, pPassword, pUserGroupID, pFirstName, pLastName, pPhoneNumber, pInstitutionID);
    
END;
$$ LANGUAGE plpgsql;