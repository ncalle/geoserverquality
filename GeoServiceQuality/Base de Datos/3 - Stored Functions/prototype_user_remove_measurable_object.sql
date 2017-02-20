--DROP FUNCTION prototype_user_remove_measurable_object(integer, integer)
CREATE OR REPLACE FUNCTION prototype_user_remove_measurable_object
(
   pUserID INT
   , pMeasurableObjectID INT
)
RETURNS VOID AS $$
/************************************************************************************************************
** Name: prototype_user_remove_measurable_object
**
** Desc: Remueve el objeto medible (Servicio Geografico) de la lista de objetos medibles disponibles para el usuario de ID pUserID
**
** 19/02/2016 Created
**
*************************************************************************************************************/

BEGIN

   -- parametros requeridos
   IF (pUserID IS NULL OR pMeasurableObjectID IS NULL)
   THEN
      RAISE EXCEPTION 'Error - Los parametros ID de usuario, Measurable ObjectID son requerido.';
   END IF;
    
   -- validacion Usuario
   IF NOT EXISTS (SELECT 1 FROM SystemUser u WHERE u.UserID = pUserID)
   THEN
      RAISE EXCEPTION 'Error - El Usuario que intenta eliminar el Servicio no es correcto.';
   END IF;

   -- validacion NodoID
   IF NOT EXISTS (SELECT 1 FROM GeographicServices sg WHERE sg.GeographicServicesID = pMeasurableObjectID)
   THEN
      RAISE EXCEPTION 'Error - El Servicio Geografico que se intenta eliminar no existe.';
   END IF;
   
      -- validacion NodoID
   IF NOT EXISTS 
      (
         SELECT 1 
         FROM UserMeasurableObject umo 
         WHERE umo.MeasurableObjectID = pMeasurableObjectID
            AND umo.MeasurableObjectType = 'Servicio'
            AND umo.UserID = pUserID
      )
   THEN
      RAISE EXCEPTION 'Error - El Servicio Geografico que se intenta eliminar no corresponde al usuario.';
   END IF;

   DELETE FROM UserMeasurableObject
   WHERE MeasurableObjectID = pMeasurableObjectID
      AND MeasurableObjectType = 'Servicio'
      AND UserID = pUserID;
         
END;
$$ LANGUAGE plpgsql;