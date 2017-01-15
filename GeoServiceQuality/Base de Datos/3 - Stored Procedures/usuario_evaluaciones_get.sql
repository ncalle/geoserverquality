--DROP FUNCTION usuario_evaluaciones_get(integer,date,date,date,boolean,boolean)
CREATE OR REPLACE FUNCTION usuario_evaluaciones_get
(
   pUsuarioID INT -- requerido no nulo
   , pPerfilID INT
   , pFechaDeComienzo DATE
   , pFechaDeFin DATE
   , pEvaluacionCompletaFlag BOOLEAN
   , pResultadoExitosoFlag BOOLEAN
)
RETURNS TABLE (PerfilID INT, FechaDeComienzo DATE, FechaDeFin DATE, EvaluacionCompletaFlag BOOLEAN, ResultadoExitosoFlag BOOLEAN) AS $$

/************************************************************************************************************
** Name: usuario_evaluaciones_get
**
** Desc: Devuelve la lista de evaluaciones realizadas hasta el momento por el usuario pasado por parametro
**
** 04/12/2016 Created
**
*************************************************************************************************************/
BEGIN
    
   -- parametros requeridos
   IF (pUsuarioID IS NULL)
   THEN
      RAISE EXCEPTION 'Error - El parametro ID de usuario es requerido.';
   END IF;

   -- Lista de datos personales y permisos sobre la herramienta
   RETURN QUERY
   SELECT e.PerfilID
      , e.FechaDeComienzo
      , e.FechaDeFin
      , e.EvaluacionCompletaFlag
      , e.ResultadoExitosoFlag
   FROM Evaluacion e
   WHERE e.UsuarioID = pUsuarioID
      AND e.PerfilID = COALESCE(pPerfilID, e.PerfilID)
      AND e.FechaDeComienzo = COALESCE(pFechaDeComienzo, e.FechaDeComienzo)
      AND e.FechaDeFin = COALESCE(pFechaDeFin, e.FechaDeFin)
      AND e.EvaluacionCompletaFlag = COALESCE(pEvaluacionCompletaFlag, e.EvaluacionCompletaFlag)
      AND e.ResultadoExitosoFlag = COALESCE(pResultadoExitosoFlag, e.ResultadoExitosoFlag)
   ORDER BY e.EvaluacionID DESC;

END;
$$ LANGUAGE plpgsql;