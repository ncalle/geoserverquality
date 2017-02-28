--DROP FUNCTION prototype_measurable_objects_delete(integer, character varying);
CREATE OR REPLACE FUNCTION prototype_measurable_objects_delete
(
   pMeasurableObjectID INT
   , pMeasurableObjectType VARCHAR(11)
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
   IF (pMeasurableObjectID IS NULL OR pMeasurableObjectType IS NULL)
   THEN
      RAISE EXCEPTION 'Error - Los parametros Measurable ObjectID, Measurable ObjectType son requerido.';
   END IF;
    
   -- validacion Servicio Geografico
   IF pMeasurableObjectType = 'Servicio' AND NOT EXISTS (SELECT 1 FROM GeographicServices sg WHERE sg.GeographicServicesID = pMeasurableObjectID)
   THEN
      RAISE EXCEPTION 'Error - El Servicio Geografico que se intenta eliminar no existe.';
   END IF;
   
   -- validacion de Objeto Medible
   IF NOT EXISTS 
      (
         SELECT 1 
         FROM UserMeasurableObject umo 
         WHERE MeasurableObjectID = pMeasurableObjectID
            AND MeasurableObjectType = pMeasurableObjectType
      )
   THEN
      RAISE EXCEPTION 'Error - El Objeto Medible que se intenta eliminar no existe.';
   END IF;

   DELETE FROM UserMeasurableObject
   WHERE MeasurableObjectID = pMeasurableObjectID
       AND MeasurableObjectType = pMeasurableObjectType;
   
   IF pMeasurableObjectType = 'Servicio'
   THEN
      DELETE FROM GeographicServices
      WHERE GeographicServicesID = pMeasurableObjectID;
   END IF;
         
END;
$$ LANGUAGE plpgsql;