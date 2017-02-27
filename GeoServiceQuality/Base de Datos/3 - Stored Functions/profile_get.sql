--DROP FUNCTION profile_get();
CREATE OR REPLACE FUNCTION profile_get()
RETURNS TABLE 
   (
      ProfileID INT
      , ProfileName VARCHAR(40)
      , ProfileGranurality VARCHAR(11)
      , ProfileIsWeightedFlag BOOLEAN
      /*, MetricID INT
      , MetricFactorID INT	  
      , MetricName VARCHAR(100)
      , MetricAgrgegationFlag BOOLEAN
      , MetricUnitID INT
      , MetricGranurality VARCHAR(11)
      , MetricDescription VARCHAR(100)
      , MetricRangeID INT
      , BooleanFlag BOOLEAN
      , BooleanAcceptanceValue BOOLEAN
      , PercentageFlag BOOLEAN
      , PercentageAcceptanceValue INT
      , IntegerFlag BOOLEAN
      , IntegerAcceptanceValue INT
      , EnumerateFlag BOOLEAN
      , EnumerateAcceptanceValue CHAR(1)*/
   ) AS $$
/************************************************************************************************************
** Name: profile_get
**
** Desc: Devuelve el conunto de Perfiles disponibles con sus Rangos y Metricas asociadas
**
** 08/12/2016 Created
**
*************************************************************************************************************/
BEGIN

   RETURN QUERY
   SELECT p.ProfileID
      , p.Name
      , p.Granurality
      , p.IsWeightedFlag
      /*, m.MetricID
      , m.FactorID	  
      , m.Name
      , m.AgrgegationFlag
      , m.UnitID
      , m.Granurality
      , m.Description
      , r.MetricRangeID
      , r.BooleanFlag
      , r.BooleanAcceptanceValue
      , r.PercentageFlag
      , r.PercentageAcceptanceValue
      , r.IntegerFlag
      , r.IntegerAcceptanceValue
      , r.EnumerateFlag
      , r.EnumerateAcceptanceValue*/
   FROM Profile p
  /* INNER JOIN MetricRange r ON r.ProfileID = p.ProfileID
   INNER JOIN Metric m ON m.MetricID = r.MetricID*/
   ORDER BY p.ProfileID
      /*, m.MetricID
      , r.MetricRangeID*/;
         
END;
$$ LANGUAGE plpgsql;