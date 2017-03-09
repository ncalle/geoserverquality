CREATE OR REPLACE FUNCTION evaluation_insert
(
   pUserID INT
   , pProfileID INT
   , pMetricID INT
   , pMeasurableObjectID INT
   , pSuccessFlag BOOLEAN
)
RETURNS VOID AS $$
/************************************************************************************************************
** Name: evaluation_insert
**
** Desc: Ingreso de evaluacion
**
** 11/12/2016 - Created
**
*************************************************************************************************************/
BEGIN
    
   -- parametros requeridos
   IF (pUserID IS NULL OR pProfileID IS NULL OR pMetricID IS NULL OR pMeasurableObjectID IS NULL)
   THEN
      RAISE EXCEPTION 'Error - Los parametros ID de Usuario, ID de Perfil, ID de Metrica e ID de Objeto Medible son requerido.';
   END IF;
    
   -- validacion de usuario
   IF NOT EXISTS (SELECT 1 FROM SystemUser u WHERE u.UserID = pUserID)
   THEN
      RAISE EXCEPTION 'Error - El ID de Usuario no es correcto.';
   END IF;
    
   -- validacion de perfil
   IF NOT EXISTS (SELECT 1 FROM Profile p WHERE p.ProfileID = pProfileID)
   THEN
      RAISE EXCEPTION 'Error - El ID de Perfil no es correcto.';
   END IF;
      
    -- validacion de Metrica
   IF NOT EXISTS (SELECT 1 FROM Metric m WHERE m.MetricID = pMetricID)
   THEN
      RAISE EXCEPTION 'Error - El ID de Metrica no es correcto.';
   END IF;    
   
   -- validacion de Objeto Medible
   IF NOT EXISTS (SELECT 1 FROM MeasurableObject mo WHERE mo.MeasurableObjectID = pMeasurableObjectID)
   THEN
      RAISE EXCEPTION 'Error - El ID de Objeto Medible no es correcto.';
   END IF; 

   -- Ingreso de Evaluacion
   INSERT INTO Evaluation
   (UserID, ProfileID, MetricID, MeasurableObjectID, StartDate, EndDate, IsEvaluationCompletedFlag, SuccessFlag)
   VALUES
   (pUserID, pProfileID, pMetricID, pMeasurableObjectID, CURRENT_DATE, CURRENT_DATE, TRUE, pSuccessFlag);

END;
$$ LANGUAGE plpgsql;