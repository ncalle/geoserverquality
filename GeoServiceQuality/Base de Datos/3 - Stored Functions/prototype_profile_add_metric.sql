﻿--DROP FUNCTION prototype_profile_add_metric (integer, integer);
CREATE OR REPLACE FUNCTION prototype_profile_add_metric
(
   pProfileID INT
   , pMetricID INT
)
RETURNS VOID AS $$
/************************************************************************************************************
** Name: prototype_profile_add_metric
**
** Desc: se asocia una metrica dada con un perfil determinado
**
** 05/03/2017 Created
**
*************************************************************************************************************/
BEGIN
    
   -- parametros requeridos
   IF (pProfileID IS NULL OR pMetricID IS NULL)
   THEN
      RAISE EXCEPTION 'Error - Los parametros ID de Perfil e ID de Metrica son requeridos.';
   END IF;
    
   -- validación de existencia de Perfil
   IF NOT EXISTS (SELECT 1 FROM Profile p WHERE p.ProfileID = pProfileID)
   THEN
      RAISE EXCEPTION 'Error - El Perfil de ID: % no existe.', pProfileID;
   END IF;

   -- validación de existencia de Metrica
   IF NOT EXISTS (SELECT 1 FROM Metric m WHERE m.MetricID = pMetricID)
   THEN
      RAISE EXCEPTION 'Error - La Metrica de ID: % no existe.', pMetricID;
   END IF;

   -- validación de asociación de Metrica y Perfil
   IF EXISTS (SELECT 1 FROM MetricRange mr WHERE mr.MetricID = pMetricID AND mr.ProfileID = pProfileID)
   THEN
      RAISE EXCEPTION 'Error - La Metrica ya se encuentra asociada al Perfil.';
   END IF;
         
    -- Insert de Rangos asociados a las Metricas y Perfil
    -- Metricas boleanas
   IF EXISTS (SELECT 1 FROM Metric m WHERE m.MetricID = pMetricID AND m.UnitID = 1) --Booleano
   THEN
      INSERT INTO MetricRange
      (MetricID, ProfileID, BooleanFlag, BooleanAcceptanceValue, PercentageFlag, PercentageAcceptanceValue, IntegerFlag, IntegerAcceptanceValue, EnumerateFlag, EnumerateAcceptanceValue)
      SELECT pMetricID, pProfileID, TRUE, TRUE, FALSE, NULL, FALSE, NULL, FALSE, NULL;
   END IF;

   --TODO: Agregar insert para el resto de los tipos de metricas, de unidad distinta a la Boleana.

END;
$$ LANGUAGE plpgsql;