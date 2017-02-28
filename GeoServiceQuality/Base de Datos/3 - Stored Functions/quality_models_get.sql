--DROP FUNCTION quality_models_get()
CREATE OR REPLACE FUNCTION quality_models_get()
RETURNS TABLE 
   (
      QualityModelID INT
      , QualityModelName VARCHAR(40)
      , DimensionID INT
      , DimensionName VARCHAR(40)
      , FactorID INT
      , FactorName VARCHAR(40)
      , MetricID INT
      , MetricName VARCHAR(100)
      , MetricAgrgegationFlag BOOLEAN
      , MetricGranurality VARCHAR(11)
      , MetricDescription VARCHAR(100)
      , UnitID INT
      , UnitName VARCHAR(40)
      , UnitDescription VARCHAR(100)
 ) AS $$
/************************************************************************************************************
** Name: quality_models_get
**
** Desc: Devuelve los modelos de calidad existentes
**
** 02/28/2016 - Created
**
*************************************************************************************************************/
BEGIN

   -- Lista de modelos de calidad
   RETURN QUERY
   SELECT qm.QualityModelID
      , qm.Name
      , d.DimensionID
      , d.Name
      , f.FactorID
      , f.Name
      , m.MetricID
      , m.Name
      , m.AgrgegationFlag
      , m.Granurality
      , m.Description
      , u.UnitID
      , u.Name
      , u.Description
   FROM QualityModel qm
   INNER JOIN Dimension d ON d.QualityModelID = qm.QualityModelID
   INNER JOIN Factor f ON f.DimensionID = d.DimensionID
   INNER JOIN Metric m ON m.FactorID = f.FactorID
   INNER JOIN Unit u ON u.UnitID = m.UnitID 
   GROUP BY qm.QualityModelID
      , qm.Name
      , d.DimensionID
      , d.Name
      , f.FactorID
      , f.Name
      , m.MetricID
      , m.Name
      , m.AgrgegationFlag
      , m.Granurality
      , m.Description
      , u.UnitID
      , u.Name
      , u.Description
   ORDER BY QualityModelID
      , d.DimensionID
      , f.FactorID
      , m.MetricID
      , u.UnitID;
        
END;
$$ LANGUAGE plpgsql;