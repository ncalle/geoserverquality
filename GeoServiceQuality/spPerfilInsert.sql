USE GeoServiceQuality;

DROP PROCEDURE IF EXISTS spPerfilInsert;

DELIMITER //

CREATE PROCEDURE spPerfilInsert
(
	pNombre VARCHAR(40)
    , pMetricaBoleanaKeys VARCHAR(100) -- Lista de enteros separada por coma, que representa los IDs de las metricas de unidad boleana
    , OUT pError INT -- 0 si ok, 1 si hay error por parametros
)

/************************************************************************************************************
** Name: spPerfilInsert
**
** Desc: se agrega un Perfil a la lista de perfiles disponibles, al que se le asocian las metricas pasadas por parametros con los Rangos
**
** 10/12/2016 Created
**
*************************************************************************************************************/
BEGIN

	DECLARE UltimoPerfilID TINYINT;

	SET pError = 0;
    
	-- parametros requeridos
	IF (pNombre IS NULL)
	THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error - El parametro nombre de perfil es requerido.';
        SET pError = 1;
	END IF;
    
	-- validacion
	IF (pMetricaBoleanaKeys IS NULL)
	THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error - La lista de Metricas no puede ser vacia.';
        SET pError = 1;
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

	-- Ingreso de Perfil
	INSERT INTO GeoServiceQuality.Perfil
    (Nombre, EsperfilPonderadoFlag)
    VALUES
    (pNombre, 0);
    
    SET UltimoPerfilID = last_insert_id();
    
    -- Insert de Rangos asociados a las Metricas y Perfil
    -- Metricas boleanas
    INSERT INTO GeoServiceQuality.Rango
	(MetricaID, PerfilID, BoleanoFlag, ValorAceptacionBoleano, PorcentajeFlag, ValorAceptacionPorcentaje, EnteroFlag, ValorAceptacionEntero, EnumeradoFlag, ValorAceptacionEnumerado)
    SELECT m.MetricaID, UltimoPerfilID, 1, 1, 0, NULL, 0, NULL, 0, NULL
    FROM GeoServiceQuality.Metrica m
    WHERE find_in_set(m.MetricaID, pMetricaBoleanaKeys) > 0;
			
END //