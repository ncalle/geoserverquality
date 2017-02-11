--DROP FUNCTION evaluation_get()
CREATE OR REPLACE FUNCTION evaluation_get()
RETURNS TABLE 
   (
      EvaluationID INT
      , UserID INT	  
      , ProfileID INT
      , StartDate DATE
      , EndDate DATE
      , IsEvaluationCompletedFlag BOOLEAN
      , SuccessFlag BOOLEAN
   ) AS $$
/************************************************************************************************************
** Name: evaluation_get
**
** Desc: Devuelve el conunto de Evaluaciones disponibles
**
** 11/02/2017 Created
**
*************************************************************************************************************/
BEGIN

   RETURN QUERY
   SELECT e.EvaluationID
      , e.UserID	  
      , e.ProfileID
      , e.StartDate
      , e.EndDate
      , e.IsEvaluationCompletedFlag
      , e.SuccessFlag
   FROM Evaluation e
   ORDER BY e.EvaluationID;
         
END;
$$ LANGUAGE plpgsql;