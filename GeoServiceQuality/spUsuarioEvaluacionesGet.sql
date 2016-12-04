USE GeoServiceQuality;

DROP PROCEDURE IF EXISTS spUsuarioEvaluacionesGet;

DELIMITER //

CREATE PROCEDURE spUsuarioEvaluacionesGet
(
	pUsuarioID INT -- requerido no nulo
	, pPerfilID TINYINT
    , pFechaDeComienzo DATETIME
    , pFechaDeFin DATETIME
    , pEvaluacionCompletaFlag BIT
    , pResultadoExitosoFlag BIT
    , OUT pError INT -- 0 si ok, 1 si hay error por parametros
)

/************************************************************************************************************
** Name: dbo.spUsuarioesGet
**
** Desc: Devuelve la lista de evaluaciones realizadas hasta el momento por el usuario pasado por parametro
**
** 04/12/2016 Created
**
*************************************************************************************************************/
BEGIN

	SET pError = 0;
    
	-- parametros requeridos
	IF (pUsuarioID IS NULL)
	THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error - El parametro ID de usuario es requerido.';
        SET pError = 1;
	END IF;

	-- Lista de datos personales y permisos sobre la herramienta
	SELECT e.PerfilID
		, e.FechaDeComienzo
		, e.FechaDeFin
		, e.EvaluacionCompletaFlag
		, e.ResultadoExitosoFlag
    FROM GeoServiceQuality.Evaluacion e
    WHERE e.UsuarioID = pUsuarioID
		AND e.PerfilID = IFNULL(pPerfilID, e.PerfilID)
        AND e.FechaDeComienzo = IFNULL(pFechaDeComienzo, e.FechaDeComienzo)
        AND e.FechaDeFin = IFNULL(pFechaDeFin, e.FechaDeFin)
        AND e.EvaluacionCompletaFlag = IFNULL(pEvaluacionCompletaFlag, e.EvaluacionCompletaFlag)
        AND e.ResultadoExitosoFlag = IFNULL(pResultadoExitosoFlag, e.ResultadoExitosoFlag)
	ORDER BY e.EvaluacionID DESC;

			
END //