--DROP FUNCTION prototype_measurable_objects_insert(integer,integer,character varying,character)
CREATE OR REPLACE FUNCTION prototype_measurable_objects_insert
(
   pUserID INT
   , pNodeID INT
   , pUrl VARCHAR(1024)
   , pGeographicServicesType VARCHAR(3)
)
RETURNS VOID AS $$
/************************************************************************************************************
** Name: prototype_measurable_objects_insert
**
** Desc: Agrega un servicios geograficos disponibles al sistema y lo asocia al usuario que lo da de alta
**
** 08/12/2016 Created
**
*************************************************************************************************************/
DECLARE SGID INT;

BEGIN

   -- parametros requeridos
   IF (pUserID IS NULL OR pNodeID IS NULL OR pUrl IS NULL OR pGeographicServicesType IS NULL)
   THEN
      RAISE EXCEPTION 'Error - Los parametro ID de Usuario, ID de Nodo, URL y Tipo de servicio son requerido.';
   END IF;
    
   -- validacion Usuario
   IF NOT EXISTS (SELECT 1 FROM SystemUser u WHERE u.UserID = pUserID)
   THEN
      RAISE EXCEPTION 'Error - El Usuario que intenta agregar el Servicio no es correcto.';
   END IF;

   -- validacion NodoID
   IF NOT EXISTS (SELECT 1 FROM Node n WHERE n.NodeID = pNodeID)
   THEN
      RAISE EXCEPTION 'Error - El Nodo que se intenta agregar para el Servicio no existe.';
   END IF;

   INSERT INTO GeographicServices
   (NodeID, Url, GeographicServicesType)
   VALUES
   (pNodeID, pUrl, pGeographicServicesType)
      RETURNING GeographicServicesID INTO SGID;

   INSERT INTO UserMeasurableObject
   (UserID, MeasurableObjectID, MeasurableObjectType, CanMeasureFlag)
   VALUES
   (pUserID, SGID, 'Servicio', TRUE);
         
END;
$$ LANGUAGE plpgsql;