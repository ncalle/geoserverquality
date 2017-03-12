﻿--DROP FUNCTION report_success_evaluation_per_node();
CREATE OR REPLACE FUNCTION report_success_evaluation_per_node ()
RETURNS TABLE (NodeID INT, NodeName VARCHAR(70), NodeCount BIGINT, NodePercentage NUMERIC, NodeSuccessPercentage BIGINT) AS $$
/************************************************************************************************************
** Name: report_success_evaluation_per_node
**
** Desc: Devuelve la cantidad y el porcentaje de exitos por institucion
**
** 2017/03/11 - Created
**
*************************************************************************************************************/
DECLARE v_TotalEvaluationSummary BIGINT;

BEGIN
  
   SELECT COUNT(*) FROM EvaluationSummary es INTO v_TotalEvaluationSummary;

   RETURN QUERY
   SELECT n.NodeID
      , n.Name AS NodeName
      , COUNT(es.EvaluationSummaryID) AS NodeCount
      , CASE WHEN v_TotalEvaluationSummary = 0 THEN 0 ELSE ((COUNT(es.EvaluationSummaryID) * 100.00) / v_TotalEvaluationSummary) END AS NodePercentage
      , CASE WHEN COUNT(es.EvaluationSummaryID) = 0 THEN 0 ELSE ((SELECT SUM(ies.SuccessPercentage) FROM EvaluationSummary ies WHERE ies.MeasurableObjectID = mo.MeasurableObjectID) / COUNT(es.EvaluationSummaryID)) END AS NodeSuccessPercentage
   FROM EvaluationSummary es
   INNER JOIN MeasurableObject mo ON mo.MeasurableObjectID = es.MeasurableObjectID
   INNER JOIN GeographicServices gs ON gs.GeographicServicesID = mo.EntityID AND mo.EntityType = 'Servicio'
   INNER JOIN Node n ON n.NodeID = gs.NodeID
   GROUP BY n.NodeID
      , n.Name
      , mo.MeasurableObjectID
   ORDER BY COUNT (es.EvaluationSummaryID) DESC;
               
END;
$$ LANGUAGE plpgsql;