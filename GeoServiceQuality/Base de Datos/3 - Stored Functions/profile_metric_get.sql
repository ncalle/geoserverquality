--DROP FUNCTION profile_metric_get(integer);
CREATE OR REPLACE FUNCTION profile_metric_get
(
   pProfileID Integer
)
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
      , MetricRangeID INT
      , BooleanFlag BOOLEAN
      , BooleanAcceptanceValue BOOLEAN
      , PercentageFlag BOOLEAN
      , PercentageAcceptanceValue INT
      , IntegerFlag BOOLEAN
      , IntegerAcceptanceValue INT
      , EnumerateFlag BOOLEAN
      , EnumerateAcceptanceValue CHAR(1)
 ) AS $$
/************************************************************************************************************
** Name: profile_metric_get
**
** Desc: Devuelve las metricas asociadas al perfil pasado por parmetro, así como todo el modelo de calidad en cuestión
**
** 02/28/2016 - Created
**
*************************************************************************************************************/
BEGIN

   -- parametros requeridos
   IF (pProfileID IS NULL)
   THEN
      RAISE EXCEPTION 'Error - El parametro ID de Perfil es requerido.';
   END IF;

   -- validación de Perfil
   IF NOT EXISTS
      (
         SELECT 1
         FROM Profile p
         WHERE p.ProfileID = pProfileID
      )
   THEN
      RAISE EXCEPTION 'Error - El ID de Perfil pasado por parametro no es correcto.';
   END IF;

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
      , mr.MetricRangeID
      , mr.BooleanFlag
      , mr.BooleanAcceptanceValue
      , mr.PercentageFlag
      , mr.PercentageAcceptanceValue
      , mr.IntegerFlag
      , mr.IntegerAcceptanceValue
      , mr.EnumerateFlag
      , mr.EnumerateAcceptanceValue
   FROM QualityModel qm
   INNER JOIN Dimension d ON d.QualityModelID = qm.QualityModelID
   INNER JOIN Factor f ON f.DimensionID = d.DimensionID
   INNER JOIN Metric m ON m.FactorID = f.FactorID
   INNER JOIN Unit u ON u.UnitID = m.UnitID 
   INNER JOIN MetricRange mr ON mr.MetricID = m.MetricID
   INNER JOIN Profile p ON p.ProfileID = mr.ProfileID
   WHERE p.ProfileID = pProfileID
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
      , mr.MetricRangeID
      , mr.BooleanFlag
      , mr.BooleanAcceptanceValue
      , mr.PercentageFlag
      , mr.PercentageAcceptanceValue
      , mr.IntegerFlag
      , mr.IntegerAcceptanceValue
      , mr.EnumerateFlag
      , mr.EnumerateAcceptanceValue
   ORDER BY QualityModelID
      , d.DimensionID
      , f.FactorID
      , m.MetricID
      , u.UnitID
      , mr.MetricRangeID;
        
END;
$$ LANGUAGE plpgsql;