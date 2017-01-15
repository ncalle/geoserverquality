CREATE OR REPLACE FUNCTION perfil_insert
(
   pNombre VARCHAR(40)
   , pGranuralidad VARCHAR(11)
   , pMetricaBoleanaKeys VARCHAR(100) -- Lista de enteros separada por coma, que representa los IDs de las metricas de unidad boleana
)
RETURNS VOID AS $$
/************************************************************************************************************
** Name: perfil_insert
**
** Desc: se agrega un Perfil a la lista de perfiles disponibles, al que se le asocian las metricas pasadas por parametros con los Rangos
**
** 10/12/2016 Created
**
*************************************************************************************************************/
DECLARE UltimoPerfilID INT;

BEGIN
    
   -- parametros requeridos
   IF (pNombre IS NULL OR pGranuralidad IS NULL)
   THEN
      RAISE EXCEPTION 'Error - Los parametros nombre de perfil y granuralidad son requeridos.';
   END IF;
    
   -- validacion
   IF (pMetricaBoleanaKeys IS NULL)
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

    SET StringSeparadoPorComas = pMetricaBoleanaKeys;
    
    -- Carga de Keys en tabla temporal
   WHILE (length(StringSeparadoPorComas) > 0)
   DO
      SET IntIndex = locate(',', StringSeparadoPorComas);
        
        IF (IntIndex = 0)
        THEN
         SET IntIndex = length(StringSeparadoPorComas) + 1;
        END IF;
        
      INSERT INTO TTMetricaBoleana
      SELECT RTRIM(LTRIM(SUBSTRING(StringSeparadoPorComas, 1, IntIndex - 1)));
        
      SET StringSeparadoPorComas = RTRIM(LTRIM(SUBSTRING(StringSeparadoPorComas, IntIndex + 1, length(StringSeparadoPorComas))));
        
   END WHILE;
*/

   CREATE TEMP TABLE MetricasBoleanas
   (
      MetricaID INT
   );

   INSERT INTO MetricasBoleanas
   (MetricaID)
   SELECT CAST(regexp_split_to_table('1,2,3,4,5,6,7,8,9,10,11,12,43,56,14,231', E',') AS INT);
      
   -- Ingreso de Perfil
   INSERT INTO Perfil
   (Nombre, Granuralidad, EsperfilPonderadoFlag)
   VALUES
   (pNombre, pGranuralidad, FALSE)
      RETURNING PerfilID INTO UltimoPerfilID;
    
    -- Insert de Rangos asociados a las Metricas y Perfil
    -- Metricas boleanas
   INSERT INTO Rango
   (MetricaID, PerfilID, BoleanoFlag, ValorAceptacionBoleano, PorcentajeFlag, ValorAceptacionPorcentaje, EnteroFlag, ValorAceptacionEntero, EnumeradoFlag, ValorAceptacionEnumerado)
   SELECT m.MetricaID, UltimoPerfilID, TRUE, TRUE, FALSE, NULL, FALSE, NULL, FALSE, NULL
   FROM Metrica m
   WHERE m.MetricaID IN (SELECT mb.MetricaID FROM MetricasBoleanas mb)
      AND m.UnidadID = 1; --Boleano
END;
$$ LANGUAGE plpgsql;