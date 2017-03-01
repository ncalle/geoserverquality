--DROP FUNCTION measurable_objects_by_user_get(integer)
CREATE OR REPLACE FUNCTION measurable_objects_by_user_get
(
   pUserID INT
)
RETURNS TABLE 
   (
      IdeID INT
      , IdeName VARCHAR(40)
      , IdeDescription VARCHAR(100)
      , InstitutionID INT
      , InstitutionName VARCHAR(70)
      , InstitutionDescription VARCHAR(100)
      , NodeID INT
      , NodeName VARCHAR(70)
      , NodeDescription VARCHAR(100)
      , LayerID INT
      , LayerName VARCHAR(70)
      , LayerURL VARCHAR(1024)
      , GeographicServicesID INT
      , GeographicServicesURL VARCHAR(1024)
      , GeographicServicesType CHAR(3)
      , GeographicServicesDescription VARCHAR(100)
 ) AS $$
/************************************************************************************************************
** Name: measurable_objects_by_user_get
**
** Desc: Devuelve la lista de objetos medibles disponibles para que usuario pueda evaluar
**
** 02/12/2016 - Created
**
*************************************************************************************************************/
BEGIN

   -- parametros requeridos
   IF (pUserID IS NULL)
   THEN
      RAISE EXCEPTION 'Error - El ID del Usuario es requerido.';
   END IF;

   -- Lista de objetos medibles sobre los cuales el usuario puede realizar evaluaciones
   RETURN QUERY
   SELECT ide.IdeID
      , ide.Name AS IdeName
      , ide.Description AS IdeDescription
      , ins.InstitutionID
      , ins.Name AS InstitutionName
      , ins.Description AS InstitutionDescription
      , n.NodeID
      , n.Name AS NodeName
      , n.Description AS NodeDescription
      , l.LayerID
      , l.Name AS LayerName
      , l.URL AS LayerURL
      , NULL AS GeographicServicesID
      , NULL AS GeographicServicesURL
      , NULL AS GeographicServicesType
      , NULL AS GeographicServicesDescription
   FROM Ide ide
   INNER JOIN Institution ins ON ins.IdeID = ide.IdeID
   INNER JOIN Node n ON n.InstitutionID = ins.InstitutionID
   INNER JOIN Layer l ON l.NodeID = n.NodeID
   INNER JOIN UserMeasurableObject uo ON 
      CASE
         WHEN uo.MeasurableObjectType = 'Ide' THEN uo.UserMeasurableObjectID = ide.IdeID
         WHEN uo.MeasurableObjectType = 'Institución' THEN uo.UserMeasurableObjectID = ins.InstitutionID
         WHEN uo.MeasurableObjectType = 'Nodo' THEN uo.UserMeasurableObjectID = n.NodeID
         WHEN uo.MeasurableObjectType = 'Capa' THEN uo.UserMeasurableObjectID = l.LayerID
      END
   INNER JOIN SystemUser u ON u.UserID = uo.UserID
   WHERE u.UserID = pUserID
      AND uo.CanMeasureFlag = TRUE
   GROUP BY ide.IdeID
      , ide.Name
      , ide.Description
      , ins.InstitutionID
      , ins.Name
      , ins.Description
      , n.NodeID
      , n.Name
      , n.Description
      , l.LayerID
      , l.Name
      , l.URL

   UNION
   
   SELECT ide.IdeID
      , ide.Name AS IdeName
      , ide.Description AS IdeDescription
      , ins.InstitutionID
      , ins.Name AS InstitutionName
      , ins.Description AS InstitutionDescription
      , n.NodeID
      , n.Name AS NodeName
      , n.Description AS NodeDescription
      , NULL AS LayerID
      , NULL AS LayerName
      , NULL AS LayerURL
      , sg.GeographicServicesID
      , sg.URL AS GeographicServicesURL
      , sg.GeographicServicesType AS GeographicServicesType
      , sg.Description AS GeographicServicesDescription
   FROM Ide ide
   INNER JOIN Institution ins ON ins.IdeID = ide.IdeID
   INNER JOIN Node n ON n.InstitutionID = ins.InstitutionID
   INNER JOIN GeographicServices sg ON sg.NodeID = n.NodeID
   INNER JOIN UserMeasurableObject uo ON 
      CASE
         WHEN uo.MeasurableObjectType = 'Ide' THEN uo.UserMeasurableObjectID = ide.IdeID
         WHEN uo.MeasurableObjectType = 'Institución' THEN uo.UserMeasurableObjectID = ins.InstitutionID
         WHEN uo.MeasurableObjectType = 'Nodo' THEN uo.UserMeasurableObjectID = n.NodeID
         WHEN uo.MeasurableObjectType = 'Servicio' THEN uo.UserMeasurableObjectID = sg.GeographicServicesID
      END
   INNER JOIN SystemUser u ON u.UserID = uo.UserID
   WHERE u.UserID = pUserID
      AND uo.CanMeasureFlag = TRUE
   GROUP BY ide.IdeID
      , ide.Name
      , ide.Description
      , ins.InstitutionID
      , ins.Name
      , ins.Description
      , n.NodeID
      , n.Name
      , n.Description
      , sg.GeographicServicesID
      , sg.URL
      , sg.GeographicServicesType
      , sg.Description
   ORDER BY IdeID
      , InstitutionID
      , NodeID
      , LayerID
      , GeographicServicesID;
        
END;
$$ LANGUAGE plpgsql;