--DROP FUNCTION prototype_measurable_objects_delete(integer, integer, integer)
CREATE OR REPLACE FUNCTION prototype_measurable_objects_delete
(
   pUserID INT
   , pMeasurableObjectID INT
   , pMeasurableObjectTypeID INT
)
RETURNS VOID AS $$
/************************************************************************************************************
** Name: prototype_measurable_objects_delete
**
** Desc: Borra un objeto medible
**
** 08/12/2016 Created
**
*************************************************************************************************************/

BEGIN

   -- parametros requeridos
   IF (pUserID IS NULL OR pMeasurableObjectID IS NULL OR pMeasurableObjectTypeID IS NULL)
   THEN
      RAISE EXCEPTION 'Error - Los parametros ID de usuario, Measurable ObjectID, Measurable ObjectTypeID son requerido.';
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
		   WHERE MeasurableObjectID = pMeasurableObjectID
               AND MeasurableObjectTypeID = pMeasurableObjectTypeID
			   AND umo.UserID = pUserID
	    )
   THEN
      RAISE EXCEPTION 'Error - El Servicio Geografico que se intenta eliminar no puede ser eliminado por el usuario.';
   END IF;

   DELETE FROM UserMeasurableObject
   WHERE MeasurableObjectID = pMeasurableObjectID
       AND MeasurableObjectTypeID = pMeasurableObjectTypeID;
   
   DELETE FROM GeographicServices
   WHERE GeographicServicesID = pMeasurableObjectID;
         
END;
$$ LANGUAGE plpgsql;