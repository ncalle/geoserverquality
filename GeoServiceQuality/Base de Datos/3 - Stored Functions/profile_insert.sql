--DROP FUNCTION profile_insert (character varying, character varying, text);
CREATE OR REPLACE FUNCTION profile_insert
(
   pName VARCHAR(40)
   , pGranurality VARCHAR(11)
   , pMetricKeys TEXT -- Lista de enteros separada por coma, que representa los IDs de las metricas
)
RETURNS VOID AS $$
/************************************************************************************************************
** Name: profile_insert
**
** Desc: se agrega un Perfil a la lista de perfiles disponibles, al que se le asocian las metricas pasadas por parametros con los Rangos
**
** 10/12/2016 Created
**
*************************************************************************************************************/
DECLARE LastProfileID INT;

BEGIN
    
   -- parametros requeridos
   IF (pName IS NULL OR pGranurality IS NULL)
   THEN
      RAISE EXCEPTION 'Error - Los parametros nombre de perfil y granuralidad son requeridos.';
   END IF;
    
   -- validacion
   IF (pMetricKeys IS NULL)
   THEN
      RAISE EXCEPTION 'Error - La lista de Metricas no puede ser vacia.';
   END IF;

   
   CREATE TEMP TABLE MetricKeys
   (
      MetricID INT
   );

   INSERT INTO MetricKeys
   (MetricID)
   SELECT CAST(regexp_split_to_table(pMetricKeys, E',') AS INT);
      
   -- Ingreso de Perfil
   INSERT INTO Profile
   (Name, Granurality, IsWeightedFlag)
   VALUES
   (pName, pGranurality, FALSE)
      RETURNING ProfileID INTO LastProfileID;
    
    -- Insert de Rangos asociados a las Metricas y Perfil
    
   -- Metricas boleanas
   INSERT INTO MetricRange
   (
      MetricID
      , ProfileID
      , BooleanFlag
      , BooleanAcceptanceValue
      , PercentageFlag
      , PercentageAcceptanceValue
      , IntegerFlag
      , IntegerAcceptanceValue
      , EnumerateFlag
      , EnumerateAcceptanceValue
   )
   SELECT 
      m.MetricID
      , LastProfileID
      , TRUE --Boleano
      , TRUE --Por defecto en TRUE
      , FALSE
      , NULL
      , FALSE
      , NULL
      , FALSE
      , NULL
   FROM Metric m
   WHERE m.MetricID IN (SELECT mb.MetricID FROM MetricKeys mb)
      AND m.UnitID = 1; --Boleano

   -- Metricas Porcentaje
   INSERT INTO MetricRange
   (
      MetricID
      , ProfileID
      , BooleanFlag
      , BooleanAcceptanceValue
      , PercentageFlag
      , PercentageAcceptanceValue
      , IntegerFlag
      , IntegerAcceptanceValue
      , EnumerateFlag
      , EnumerateAcceptanceValue
   )
   SELECT 
      m.MetricID
      , LastProfileID
      , FALSE
      , NULL
      , TRUE --Porcentaje
      , 50 --Por defecto en 50%
      , FALSE
      , NULL
      , FALSE
      , NULL
   FROM Metric m
   WHERE m.MetricID IN (SELECT mb.MetricID FROM MetricKeys mb)
      AND m.UnitID = 2; --Porcentaje

   -- Metricas Milisegundos
   INSERT INTO MetricRange
   (
      MetricID
      , ProfileID
      , BooleanFlag
      , BooleanAcceptanceValue
      , PercentageFlag
      , PercentageAcceptanceValue
      , IntegerFlag
      , IntegerAcceptanceValue
      , EnumerateFlag
      , EnumerateAcceptanceValue
   )
   SELECT 
      m.MetricID
      , LastProfileID
      , FALSE
      , NULL
      , FALSE
      , NULL
      , TRUE --Milisegundos
      , 10000 --Por defecto en 10 segundos
      , FALSE
      , NULL
   FROM Metric m
   WHERE m.MetricID IN (SELECT mb.MetricID FROM MetricKeys mb)
      AND m.UnitID = 3; --Milisegundos

   -- Metricas Basico-Intermedio-Completo
   INSERT INTO MetricRange
   (
      MetricID
      , ProfileID
      , BooleanFlag
      , BooleanAcceptanceValue
      , PercentageFlag
      , PercentageAcceptanceValue
      , IntegerFlag
      , IntegerAcceptanceValue
      , EnumerateFlag
      , EnumerateAcceptanceValue
   )
   SELECT 
      m.MetricID
      , LastProfileID
      , FALSE
      , NULL
      , FALSE
      , NULL
      , FALSE
      , NULL
      , TRUE --Basico-Intermedio-Completo
      , 'I' -- 'B' = Basico, 'I' = Intermedio, 'C' = Completo
   FROM Metric m
   WHERE m.MetricID IN (SELECT mb.MetricID FROM MetricKeys mb)
      AND m.UnitID = 4; --Basico-Intermedio-Completo

   -- Metricas Entero
   INSERT INTO MetricRange
   (
      MetricID
      , ProfileID
      , BooleanFlag
      , BooleanAcceptanceValue
      , PercentageFlag
      , PercentageAcceptanceValue
      , IntegerFlag
      , IntegerAcceptanceValue
      , EnumerateFlag
      , EnumerateAcceptanceValue
   )
   SELECT 
      m.MetricID
      , LastProfileID
      , FALSE
      , NULL
      , FALSE
      , NULL
      , TRUE --Entero
      , 1 --Por defecto en 1
      , FALSE
      , NULL
   FROM Metric m
   WHERE m.MetricID IN (SELECT mb.MetricID FROM MetricKeys mb)
      AND m.UnitID = 5; --Entero

END;
$$ LANGUAGE plpgsql;