--DROP FUNCTION profile_update();
CREATE OR REPLACE FUNCTION profile_update
(
   pProfileID INT
   , pName VARCHAR(40)
   , pGranurality VARCHAR(11) -- 'Ide', 'Institución', 'Nodo', 'Capa', 'Servicio',
   , pIsWeightedFlag BOOLEAN
)
RETURNS VOID AS $$
/************************************************************************************************************
** Name: profile_update()
**
** Desc: Actualiza datos de Perfil
**
** 04/03/2017 - Created
**
*************************************************************************************************************/
BEGIN
   
   -- parametros requeridos
   IF (pProfileID IS NULL)
   THEN
      RAISE EXCEPTION 'Error - El parametroe ID de Perfil es requerido.';
   END IF;

   -- validación de existencia de Perfil
   IF NOT EXISTS (SELECT 1 FROM Profile p WHERE p.ProfileID = pProfileID)
   THEN
      RAISE EXCEPTION 'Error - El Perfil de ID: % no existe.', pProfileID;
   END IF;
    
   -- Actualizar datos de Perfil
   UPDATE Profile
   SET Name = pName
      , Granurality = pGranurality
	  , IsWeightedFlag = pIsWeightedFlag
   WHERE ProfileID = pProfileID;
    
END;
$$ LANGUAGE plpgsql;
