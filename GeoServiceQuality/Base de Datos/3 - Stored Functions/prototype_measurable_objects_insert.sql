--DROP FUNCTION prototype_measurable_objects_insert(integer,character varying,character varying, character varying, character varying);
CREATE OR REPLACE FUNCTION prototype_measurable_objects_insert
(
   pNodeID INT
   , pUrl VARCHAR(1024)
   , pGeographicServicesType VARCHAR(3)
   , pMeasurableObjectDescription VARCHAR(100)
   , pMeasurableObjectType VARCHAR(11) -- 'Ide', 'Institucion', 'Nodo', 'Capa', 'Servicio'
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
   IF (
      (pNodeID IS NULL AND pMeasurableObjectType = 'Servicio')
      OR (pUrl IS NULL AND pMeasurableObjectType = 'Servicio')
      OR (pGeographicServicesType IS NULL AND pMeasurableObjectType = 'Servicio')
      OR pMeasurableObjectType IS NULL
   )
   THEN
      RAISE EXCEPTION 'Error - Alguno de los siguientes parametros: ID de Nodo, URL, Tipo de servicio o Tipo de Objeto Medible no fueron dados.';
   END IF;

   -- validacion NodoID
   IF pMeasurableObjectType = 'Servicio' AND NOT EXISTS (SELECT 1 FROM Node n WHERE n.NodeID = pNodeID)
   THEN
      RAISE EXCEPTION 'Error - El Nodo que se intenta asociar al Servicio no existe.';
   END IF;

   IF pMeasurableObjectType = 'Servicio'
   THEN
      INSERT INTO GeographicServices
      (NodeID, Url, GeographicServicesType, Description)
      VALUES
      (pNodeID, pUrl, pGeographicServicesType, pMeasurableObjectDescription)
         RETURNING GeographicServicesID INTO SGID;

      --Se asocia el objeto medible a todos los usuario, dejandolo por defecto como NO disponible para medir
      INSERT INTO UserMeasurableObject
      (UserID, MeasurableObjectID, MeasurableObjectType, CanMeasureFlag)
      SELECT su.UserID, SGID, 'Servicio', FALSE
      FROM SystemUser su;

   END IF;
         
END;
$$ LANGUAGE plpgsql;