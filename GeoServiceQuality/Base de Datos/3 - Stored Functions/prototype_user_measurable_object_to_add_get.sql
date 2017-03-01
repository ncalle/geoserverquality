--DROP FUNCTION prototype_user_measurable_object_to_add_get(integer)
CREATE OR REPLACE FUNCTION prototype_user_measurable_object_to_add_get
(
   pUserID INT
)
RETURNS TABLE (
   MeasurableObjectID INT
   , MeasurableObjectType VARCHAR(11)
   , MeasurableObjectName VARCHAR(70)
   , MeasurableObjectDescription VARCHAR(100)
   , MeasurableObjectURL VARCHAR(1024)
   , MeasurableObjectServicesType CHAR(3)
) AS $$
/************************************************************************************************************
** Name: prototype_user_measurable_object_to_add_get
**
** Desc: Lista los objetos medibles que el usuario puede agregar a su lista de objetos que actualmente puede medir
**
** 21/02/2016 Created
**
*************************************************************************************************************/

BEGIN

   -- parametros requeridos
   IF (pUserID IS NULL)
   THEN
      RAISE EXCEPTION 'Error - El parametro ID de usuario es requerido.';
   END IF;
    
   -- validacion Usuario
   IF NOT EXISTS (SELECT 1 FROM SystemUser u WHERE u.UserID = pUserID)
   THEN
      RAISE EXCEPTION 'Error - El Usuario seleccionado no es correcto.';
   END IF;
   
   -- Lista de objetos medibles sobre los cuales el usuario puede realizar evaluaciones
   RETURN QUERY
   SELECT umo.MeasurableObjectID
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
         WHEN umo.MeasurableObjectType = 'Servicio' THEN sg.Description
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
   WHERE umo.MeasurableObjectType = 'Servicio'
      AND umo.UserID = pUserID
      AND umo.CanMeasureFlag = FALSE -- indica si el usuario puede evaluar el objeto en cuestion
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
      , sg.Description
      , sg.Url
      , sg.GeographicServicesType;
         
END;
$$ LANGUAGE plpgsql;