--DROP FUNCTION measurable_object_get(integer);
CREATE OR REPLACE FUNCTION measurable_object_get
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
** Name: measurable_object_get
**
** Desc: Devuelve la lista de objetos medibles disponibles.
**       Si el ID de Usuario es pasado por parametro, entonces se listan solo los Objetos Medibles que el usuario en cuestion puede medir.
**
** 02/12/2016 - Created
**
*************************************************************************************************************/
DECLARE v_canUserMeasureAble INT;

BEGIN
   
   -- validacion de usuario
   IF (pUserID IS NOT NULL)
      AND NOT EXISTS (SELECT 1 FROM SystemUser su WHERE su.UserID = pUserID)
   THEN
      RAISE EXCEPTION 'Error - El Usuario no existe.';
   END IF;

   IF (pUserID IS NOT NULL)
   THEN
      SELECT 1 INTO v_canUserMeasureAble;
   ELSE
      SELECT NULL INTO v_canUserMeasureAble;
   END IF;

   -- Lista de objetos medibles
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
      , c.LayerID
      , c.Name AS LayerName
      , c.URL AS LayerURL
      , NULL AS GeographicServicesID
      , NULL AS GeographicServicesURL
      , NULL AS GeographicServicesType
      , NULL AS GeographicServicesDescription
   FROM Ide ide
   INNER JOIN Institution ins ON ins.IdeID = ide.IdeID
   INNER JOIN Node n ON n.InstitutionID = ins.InstitutionID
   INNER JOIN Layer c ON c.NodeID = n.NodeID
   LEFT JOIN MeasurableObject mo ON 
      CASE
         WHEN mo.EntityType = 'Ide' THEN mo.EntityID = ide.IdeID
         WHEN mo.EntityType = 'Institución' THEN mo.EntityID = ins.InstitutionID
         WHEN mo.EntityType = 'Nodo' THEN mo.EntityID = n.NodeID
         WHEN mo.EntityType = 'Capa' THEN mo.EntityID = l.LayerID
      END
   LEFT JOIN UserMeasurableObject umo ON umo.MeasurableObjectID = mo.MeasurableObjectID
   LEFT JOIN SystemUser u ON u.UserID = umo.UserID
   WHERE u.UserID = COALESCE(pUserID, u.UserID)
      AND umo.CanMeasureFlag = COALESCE(v_canUserMeasureAble, umo.CanMeasureFlag)
   GROUP BY ide.IdeID
      , ide.Name
      , ide.Description
      , ins.InstitutionID
      , ins.Name
      , ins.Description
      , n.NodeID
      , n.Name
      , n.Description
      , c.LayerID
      , c.Name
      , c.URL

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
      , sg.GeographicServicesType
      , sg.Description AS GeographicServicesDescription
   FROM Ide ide
   INNER JOIN Institution ins ON ins.IdeID = ide.IdeID
   INNER JOIN Node n ON n.InstitutionID = ins.InstitutionID
   INNER JOIN GeographicServices sg ON sg.NodeID = n.NodeID
   LEFT JOIN MeasurableObject mo ON 
      CASE
         WHEN mo.EntityType = 'Ide' THEN mo.EntityID = ide.IdeID
         WHEN mo.EntityType = 'Institución' THEN mo.EntityID = ins.InstitutionID
         WHEN mo.EntityType = 'Nodo' THEN mo.EntityID = n.NodeID
         WHEN mo.EntityType = 'Servicio' THEN mo.EntityID = sg.GeographicServicesID
      END
   LEFT JOIN UserMeasurableObject umo ON umo.MeasurableObjectID = mo.MeasurableObjectID
   LEFT JOIN SystemUser u ON u.UserID = umo.UserID
   WHERE u.UserID = COALESCE(pUserID, u.UserID)
      AND umo.CanMeasureFlag = COALESCE(v_canUserMeasureAble, umo.CanMeasureFlag)
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