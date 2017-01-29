--DROP FUNCTION user_evaluation_get(integer,date,date,date,boolean,boolean)
CREATE OR REPLACE FUNCTION user_evaluation_get
(
   pUserID INT -- requerido no nulo
   , pProfileID INT
   , pStartDate DATE
   , pEndDate DATE
   , pIsEvaluationCompletedFlag BOOLEAN
   , pSuccessFlag BOOLEAN
)
RETURNS TABLE (ProfileID INT, StartDate DATE, EndDate DATE, IsEvaluationCompletedFlag BOOLEAN, SuccessFlag BOOLEAN) AS $$

/************************************************************************************************************
** Name: user_evaluation_get
**
** Desc: Devuelve la lista de evaluaciones realizadas hasta el momento por el usuario pasado por parametro
**
** 04/12/2016 Created
**
*************************************************************************************************************/
BEGIN
    
   -- parametros requeridos
   IF (pUserID IS NULL)
   THEN
      RAISE EXCEPTION 'Error - El parametro ID de usuario es requerido.';
   END IF;

   -- Lista de datos personales y permisos sobre la herramienta
   RETURN QUERY
   SELECT e.ProfileID
      , e.StartDate
      , e.EndDate
      , e.IsEvaluationCompletedFlag
      , e.SuccessFlag
   FROM Evaluation e
   WHERE e.UserID = pUserID
      AND e.ProfileID = COALESCE(pProfileID, e.ProfileID)
      AND e.StartDate = COALESCE(pStartDate, e.StartDate)
      AND e.EndDate = COALESCE(pEndDate, e.EndDate)
      AND e.IsEvaluationCompletedFlag = COALESCE(pIsEvaluationCompletedFlag, e.IsEvaluationCompletedFlag)
      AND e.SuccessFlag = COALESCE(pSuccessFlag, e.SuccessFlag)
   ORDER BY e.EvaluationID DESC;

END;
$$ LANGUAGE plpgsql;