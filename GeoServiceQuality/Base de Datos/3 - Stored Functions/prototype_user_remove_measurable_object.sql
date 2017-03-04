--DROP FUNCTION prototype_user_remove_measurable_object(integer, integer);
CREATE OR REPLACE FUNCTION prototype_user_remove_measurable_object
(
   pUserID INT
   , pMeasurableObjectID INT
   , pMeasurableObjectType VARCHAR(11) --Servicio
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
   IF EXISTS 
      (
         SELECT 1 
         FROM UserMeasurableObject umo 
         WHERE umo.MeasurableObjectID = pMeasurableObjectID
            AND umo.MeasurableObjectType = pMeasurableObjectType
            AND umo.UserID = pUserID
            AND umo.CanMeasureFlag = FALSE
      )
   THEN
      RAISE EXCEPTION 'Error - El Servicio Geografico que se intenta remover ya no se encuentra habilitado para ser evaluado por el usuario.';
   END IF;

   UPDATE UserMeasurableObject
   SET CanMeasureFlag = FALSE
   WHERE MeasurableObjectID = pMeasurableObjectID
      AND MeasurableObjectType = pMeasurableObjectType
      AND UserID = pUserID
      AND CanMeasureFlag = TRUE;
         
END;
$$ LANGUAGE plpgsql;