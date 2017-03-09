--DROP FUNCTION prototype_measurable_object_update();
CREATE OR REPLACE FUNCTION prototype_measurable_object_update
(
   pMeasurableObjectID INT
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
DECLARE v_EntityID INT;
DECLARE v_EntityType VARCHAR(11);

BEGIN
   
   -- parametros requeridos
   IF (pMeasurableObjectID IS NULL)
   THEN
      RAISE EXCEPTION 'Error - El ID de Objeto Medible es requerido.';
   END IF;
   
   SELECT mo.EntityID, mo.EntityType FROM MeasurableObject mo WHERE mo.MeasurableObjectID = pMeasurableObjectID INTO v_EntityID, v_EntityType;
   
   -- validacion de nodo
   IF (v_EntityType = 'Servicio') AND NOT EXISTS (SELECT 1 FROM GeographicServices sg INNER JOIN Node n ON n.NodeID = sg.NodeID WHERE sg.GeographicServicesID = v_EntityID)
   THEN
      RAISE EXCEPTION 'Error - El Servicio Geografico no existe o el Nodo pasado por parametro es incorrecto.';
   END IF;
       
   -- Actualizar datos de objetods medibles
   IF (v_EntityType = 'Servicio')
   THEN
      UPDATE GeographicServices
      SET Url = pUrl
         , GeographicServicesType = pGeographicServicesType
         , Description = pDescription
      WHERE GeographicServicesID = v_EntityID;
   END IF;
    
END;
$$ LANGUAGE plpgsql;