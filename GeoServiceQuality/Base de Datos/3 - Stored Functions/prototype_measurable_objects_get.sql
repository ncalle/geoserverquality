--DROP FUNCTION prototype_measurable_objects_get(integer)
CREATE OR REPLACE FUNCTION prototype_measurable_objects_get
(
   pUserID INT
)
RETURNS TABLE 
   (
      MeasurableObjectID INT
      , MeasurableObjectTypeID INT
      , MeasurableObjectType VARCHAR(11)
      , MeasurableObjectName VARCHAR(70)
      , MeasurableObjectDescription VARCHAR(100)
      , MeasurableObjectURL VARCHAR(1024)
      , MeasurableObjectServicesType CHAR(3)
 ) AS $$
/************************************************************************************************************
** Name: prototype_measurable_objects_get
**
** Desc: Devuelve la lista de objetos medibles disponibles. Si se pasa el usuario, entonces se filtra por el mismo
** Se debe ampliar a otros objetos medibles. Para el prototipo solo se devuelven servicios.
**
** 02/12/2016 - Created
**
*************************************************************************************************************/
BEGIN

   -- Lista de objetos medibles sobre los cuales el usuario puede realizar evaluaciones
   RETURN QUERY
   SELECT umo.MeasurableObjectID
      , CASE
         --WHEN umo.MeasurableObjectType = 'Ide' THEN 1
         --WHEN umo.MeasurableObjectType = 'Institución' THEN 2
         --WHEN umo.MeasurableObjectType = 'Nodo' THEN 3
         --WHEN umo.MeasurableObjectType = 'Capa' THEN 4
         WHEN umo.MeasurableObjectType = 'Servicio' THEN 5
         END AS MeasurableObjectTypeID
      , umo.MeasurableObjectType
      , CASE
         --WHEN umo.MeasurableObjectType = 'Ide' THEN ide.Name
         --WHEN umo.MeasurableObjectType = 'Institución' THEN ins.Name
         --WHEN umo.MeasurableObjectType = 'Nodo' THEN n.Name
         --WHEN umo.MeasurableObjectType = 'Capa' THEN l.Name
         WHEN umo.MeasurableObjectType = 'Servicio' THEN NULL ::VARCHAR(70)
         END AS MeasurableObjectName
      , CASE
         --WHEN umo.MeasurableObjectType = 'Ide' THEN ide.Description
         --WHEN umo.MeasurableObjectType = 'Institución' THEN ins.Description
         --WHEN umo.MeasurableObjectType = 'Nodo' THEN n.Description
         --WHEN umo.MeasurableObjectType = 'Capa' THEN NULL
         WHEN umo.MeasurableObjectType = 'Servicio' THEN NULL ::VARCHAR(100)
         END AS MeasurableObjectDescription
      , CASE
         --WHEN umo.MeasurableObjectType = 'Ide' THEN NULL
         --WHEN umo.MeasurableObjectType = 'Institución' THEN NULL
         --WHEN umo.MeasurableObjectType = 'Nodo' THEN NULL
         --WHEN umo.MeasurableObjectType = 'Capa' THEN l.Url
         WHEN umo.MeasurableObjectType = 'Servicio' THEN sg.Url
         END AS MeasurableObjectURL
      , CASE
         --WHEN umo.MeasurableObjectType = 'Ide' THEN NULL
         --WHEN umo.MeasurableObjectType = 'Institución' THEN NULL
         --WHEN umo.MeasurableObjectType = 'Nodo' THEN NULL
         --WHEN umo.MeasurableObjectType = 'Capa' THEN NULL
         WHEN umo.MeasurableObjectType = 'Servicio' THEN sg.GeographicServicesType
         END AS MeasurableObjectServicesType
   FROM GeographicServices sg
   INNER JOIN UserMeasurableObject umo ON umo.MeasurableObjectID = sg.GeographicServicesID AND umo.MeasurableObjectType = 'Servicio'
   LEFT JOIN SystemUser u ON u.UserID = umo.UserID
   WHERE u.UserID = COALESCE(pUserID,u.UserID)
      AND (CASE WHEN pUserID IS NOT NULL THEN umo.CanMeasureFlag = TRUE ELSE TRUE END)
   GROUP BY umo.MeasurableObjectID
      , umo.MeasurableObjectType
      --, ide.Name
      --, ins.Name
      --, n.Name
      --, l.Name
      --, ide.Description
      --, ins.Description
      --, n.Description
      --, l.Url
      , sg.Url
      , sg.GeographicServicesType;
        
END;
$$ LANGUAGE plpgsql;