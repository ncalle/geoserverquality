CREATE OR REPLACE FUNCTION evaluation_insert
(
   pUserID INT
   , pProfileID INT
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
   IF (pUserID IS NULL OR pProfileID IS NULL)
   THEN
      RAISE EXCEPTION 'Error - Los parametros ID de Usuario, ID de Perfil son requerido.';
   END IF;
    
   -- validacion
   IF NOT EXISTS (SELECT 1 FROM SystemUser u WHERE u.UserID = pUserID)
   THEN
      RAISE EXCEPTION 'Error - El ID de Usuario no es correcto.';
   END IF;
    
   -- validacion
   IF NOT EXISTS (SELECT 1 FROM Profile p WHERE p.ProfileID = pProfileID)
   THEN
      RAISE EXCEPTION 'Error - El ID de Perfil no es correcto.';
   END IF;    

   -- Ingreso de Evaluacion
   INSERT INTO Evaluation
   (UserID, ProfileID, StartDate, EndDate, IsEvaluationCompletedFlag, SuccessFlag)
   VALUES
   (pUserID, pProfileID, CURRENT_DATE, CURRENT_DATE, TRUE, pSuccessFlag);

END;
$$ LANGUAGE plpgsql;