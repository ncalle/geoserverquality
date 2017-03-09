--DROP FUNCTION prototype_measurable_objects_insert(integer,character varying,character varying, character varying, character varying);
CREATE OR REPLACE FUNCTION prototype_measurable_objects_insert
(
   pNodeID INT
   , pUrl VARCHAR(1024)
   , pGeographicServicesType VARCHAR(3)
   , pMeasurableObjectDescription VARCHAR(100)
   , pEntityType VARCHAR(11) -- 'Ide', 'Institucion', 'Nodo', 'Capa', 'Servicio'
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
DECLARE MOID INT;

BEGIN

   IF (pEntityType IS NULL)
   THEN
      RAISE EXCEPTION 'Error - El ID de Entidad es requerido.';
   END IF;
   
   -- parametros requeridos
   IF (pEntityType = 'Servicio'
	  AND (
	     pNodeID IS NULL
		 OR pUrl IS NULL
		 OR pGeographicServicesType IS NULL
	  )
   )
   THEN
      RAISE EXCEPTION 'Error - Alguno de los siguientes parametros: ID de Nodo, URL o Tipo de servicio no fueron dados.';
   END IF;

   -- validacion NodoID
   IF pEntityType = 'Servicio' AND NOT EXISTS (SELECT 1 FROM Node n WHERE n.NodeID = pNodeID)
   THEN
      RAISE EXCEPTION 'Error - El Nodo que se intenta asociar al Servicio no existe.';
   END IF;

   IF pEntityType = 'Servicio'
   THEN
      INSERT INTO GeographicServices
      (NodeID, Url, GeographicServicesType, Description)
      VALUES
      (pNodeID, pUrl, pGeographicServicesType, pMeasurableObjectDescription)
         RETURNING GeographicServicesID INTO SGID;

      INSERT INTO MeasurableObject
      (EntityID, EntityType)
      VALUES
      (SGID, pEntityType)
         RETURNING MeasurableObjectID INTO MOID;
   END IF;
   
   --Se asocia el objeto medible a todos los usuario, dejandolo por defecto como NO disponible para medir
   INSERT INTO UserMeasurableObject
   (UserID, MeasurableObjectID, CanMeasureFlag)
   SELECT su.UserID, MOID, FALSE
   FROM SystemUser su;
         
END;
$$ LANGUAGE plpgsql;