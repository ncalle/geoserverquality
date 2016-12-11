USE GeoServiceQuality;

DROP PROCEDURE IF EXISTS spEvaluacionInsert;

DELIMITER //

CREATE PROCEDURE spEvaluacionInsert
(
	pUsuarioID INT
    , pPerfilID TINYINT
    , pResultadoExitosoFlag BIT
    , OUT pError INT -- 0 si ok, 1 si hay error por parametros
)

/************************************************************************************************************
** Name: spEvaluacionInsert
**
** Desc: Ingreso de evaluacion
**
** 11/12/2016 Created
**
*************************************************************************************************************/
BEGIN

	SET pError = 0;
    
	-- parametros requeridos
	IF (pUsuarioID IS NULL OR pPerfilID IS NULL)
	THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error - Los parametros ID de Usuario, ID de Perfil son requerido.';
        SET pError = 1;
	END IF;
    
	-- validacion
	IF NOT EXISTS (SELECT 1 FROM GeoServiceQuality.Usuario u WHERE u.UsuarioID = pUsuarioID)
	THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error - El ID de Usuario no es correcto.';
        SET pError = 1;
	END IF;
    
	-- validacion
	IF NOT EXISTS (SELECT 1 FROM GeoServiceQuality.Perfil p WHERE p.PerfilID = pPerfilID)
	THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error - El ID de Perfil no es correcto.';
        SET pError = 1;
	END IF;    


	-- Ingreso de Evaluacion
	INSERT INTO GeoServiceQuality.Evaluacion
    (UsuarioID, PerfilID, FechaDeComienzo, FechaDeFin, EvaluacionCompletaFlag, ResultadoExitosoFlag)
    VALUES
    (pUsuarioID, pPerfilID, NOW(), NOW(), 1, pResultadoExitosoFlag);

END //