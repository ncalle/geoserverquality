﻿--DROP FUNCTION services_and_layers_get(integer, character varying, character varying);
CREATE OR REPLACE FUNCTION services_and_layers_get
(
   pUserID INT
   , pEntityName VARCHAR(70)
   , pEntityType VARCHAR(11)
)
RETURNS TABLE 
   (
      MeasurableObjectID INT
      , EntityID INT
      , EntityType VARCHAR(11)
      , MeasurableObjectName VARCHAR(70)
      , MeasurableObjectDescription VARCHAR(100)
      , MeasurableObjectURL VARCHAR(1024)
      , MeasurableObjectServicesType CHAR(3)
 ) AS $$
/************************************************************************************************************
** Name: services_and_layers_get
**
** Desc: Devuelve la lista de servicios que pertenecen al Nodo pasado por parametro, y al Usuario si el mismo es especificado.
**
** 19/03/2017 - Created
**
*************************************************************************************************************/
BEGIN

   -- Lista de objetos medibles sobre los cuales el usuario puede realizar evaluaciones
   RETURN QUERY
   SELECT mo.MeasurableObjectID
      , sg.GeographicServicesID AS EntityID
      , 'Servicio' ::VARCHAR(11) AS EntityType
      , NULL ::VARCHAR(70) AS MeasurableObjectName
      , sg.Description AS MeasurableObjectDescription
      , sg.Url AS MeasurableObjectURL
      , sg.GeographicServicesType AS MeasurableObjectServicesType
   FROM Node n
   INNER JOIN GeographicServices sg ON sg.NodeID = n.NodeID
   INNER JOIN MeasurableObject mo ON mo.EntityID = sg.GeographicServicesID AND mo.EntityType = 'Servicio'
   LEFT JOIN UserMeasurableObject umo ON umo.MeasurableObjectID = mo.MeasurableObjectID
   --LEFT JOIN Layer l ON l.NodeID = n.NodeID
   LEFT JOIN SystemUser u ON u.UserID = umo.UserID
   WHERE (CASE WHEN pUserID IS NOT NULL THEN u.UserID = pUserID ELSE TRUE END)
      AND (CASE WHEN pUserID IS NOT NULL THEN umo.CanMeasureFlag = TRUE ELSE TRUE END)
      AND (CASE WHEN pEntityName IS NOT NULL AND pEntityType = 'Nodo' THEN n.Name = pEntityName ELSE TRUE END)
   GROUP BY mo.MeasurableObjectID
      , sg.GeographicServicesID
      , mo.EntityType
      --, ide.Name
      --, ins.Name
      --, n.Name
      --, l.Name
      --, ide.Description
      --, ins.Description
      --, n.Description
      --, l.Url
      , sg.Description
      , sg.Url
      , sg.GeographicServicesType
   ORDER BY mo.MeasurableObjectID;
        
END;
$$ LANGUAGE plpgsql;