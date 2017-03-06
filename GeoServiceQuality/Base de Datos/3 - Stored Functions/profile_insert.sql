--DROP FUNCTION profile_insert (character varying, character varying, text);
CREATE OR REPLACE FUNCTION profile_insert
(
   pName VARCHAR(40)
   , pGranurality VARCHAR(11)
   , pMetricKeys TEXT -- Lista de enteros separada por coma, que representa los IDs de las metricas
   --por defecto para el prototipo se toman rangos boleanos, por lo que no es necesario pasar el valor de los rangos por parametro ya que son todos 1
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

/*    
   -- validacion
   IF (
         ((pMetricaPorcentajeKeys IS NOT NULL AND pRangoPorcentajeValues IS NULL) OR (pMetricaPorcentajeKeys IS NULL AND pRangoPorcentajeValues IS NOT NULL))
            OR ((pMetricaEnteraKeys IS NOT NULL AND pRangoEnteroValues IS NULL) OR (pMetricaEnteraKeys IS NULL AND pRangoEnteroValues IS NOT NULL))
            OR ((pMetricaEnumeradaKeys IS NOT NULL AND pRangoEnumeradoValues IS NULL) OR (pMetricaEnumeradaKeys IS NULL AND pRangoEnumeradoValues IS NOT NULL))
      )
   THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error - Lista de IDs o Rangos relacionadas vacia. Deben de estar ambas vacias o ambas con datos.';
        SET pError = 1;
   END IF;     

   -- validacion
   IF (
         (
            (pMetricaPorcentajeKeys IS NOT NULL AND pRangoPorcentajeValues IS NOT NULL) 
                AND (LENGTH(pMetricaPorcentajeKeys) - LENGTH(REPLACE(pMetricaPorcentajeKeys, ',', '')) <> LENGTH(pRangoPorcentajeValues) - LENGTH(REPLACE(pRangoPorcentajeValues, ',', '')))
         )
            OR (
            (pMetricaEnteraKeys IS NOT NULL AND pRangoEnteroValues IS NOT NULL) 
                AND (LENGTH(pMetricaEnteraKeys) - LENGTH(REPLACE(pMetricaEnteraKeys, ',', '')) <> LENGTH(pRangoEnteroValues) - LENGTH(REPLACE(pRangoEnteroValues, ',', '')))
         )
            OR (
            (pMetricaEnumeradaKeys IS NOT NULL AND pRangoEnumeradoValues IS NOT NULL) 
                AND (LENGTH(pMetricaEnumeradaKeys) - LENGTH(REPLACE(pMetricaEnumeradaKeys, ',', '')) <> LENGTH(pRangoEnumeradoValues) - LENGTH(REPLACE(pRangoEnumeradoValues, ',', '')))
         )
      )
   THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error - Lista de IDs y Rangos relacionados no tiene la misma cantidad de elementos.';
        SET pError = 1;
   END IF;
*/

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
   (MetricID, ProfileID, BooleanFlag, BooleanAcceptanceValue, PercentageFlag, PercentageAcceptanceValue, IntegerFlag, IntegerAcceptanceValue, EnumerateFlag, EnumerateAcceptanceValue)
   SELECT m.MetricID, LastProfileID, TRUE, TRUE, FALSE, NULL, FALSE, NULL, FALSE, NULL
   FROM Metric m
   WHERE m.MetricID IN (SELECT mb.MetricID FROM MetricKeys mb)
      AND m.UnitID = 1; --Boleano
   --TODO: Agregar insert para el resto de los tipos de metricas, de unidad distinta a la Boleana.

END;
$$ LANGUAGE plpgsql;