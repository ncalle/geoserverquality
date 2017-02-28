--DROP FUNCTION prototype_measurable_object_update();
CREATE OR REPLACE FUNCTION prototype_measurable_object_update
(
   pMeasurableObjectID INT
   , pMeasurableObjectType VARCHAR(11)
   , pUrl VARCHAR(1024)
   , pGeographicServicesType CHAR(3) -- WMS, WFS, CSW
   , pDescription VARCHAR(100)
)
RETURNS VOID AS $$
/************************************************************************************************************
** Name: prototype_measurable_object_update()
**
** Desc: Actualiza datos de Objetos Medibles
**
** 28/02/2017 - Created
**
*************************************************************************************************************/
BEGIN
   
   -- parametros requeridos
   IF (pMeasurableObjectID IS NULL OR pMeasurableObjectType IS NULL)
   THEN
      RAISE EXCEPTION 'Error - Los parametros ID de objeto medible y tipo de objeto medible son requeridos.';
   END IF;
    
   -- Actualizar datos de objetods medibles
   IF (pMeasurableObjectType = 'Servicio')
   THEN
      UPDATE GeographicServices
      SET Url = pUrl
         , GeographicServicesType = pGeographicServicesType
         , Description = pDescription
      WHERE GeographicServicesID = pMeasurableObjectID;
   END IF;
    
END;
$$ LANGUAGE plpgsql;