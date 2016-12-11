USE GeoServiceQuality;

DROP PROCEDURE IF EXISTS spUsuarioObjetoEvaluableGet;

DELIMITER //

CREATE PROCEDURE spUsuarioObjetoEvaluableGet
(
	pUsuarioID INT
    , OUT pError INT -- 0 si ok, 1 si hay error por parametros
)

/************************************************************************************************************
** Name: dbo.spUsuarioObjetoEvaluableGet
**
** Desc: Devuelve el conunto de Objetos medibles que pueden ser evaluados por el usuario
**
** 08/12/2016 Created
**
*************************************************************************************************************/
BEGIN

	SET pError = 0;
    
	-- parametros requeridos
	IF (pUsuarioID IS NULL)
	THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error - El parametro ID de Usuario es requerido.';
        SET pError = 1;
	END IF;
    
	-- validar UsuarioID
	IF NOT EXISTS (SELECT u.UsuarioID FROM GeoServiceQuality.Usuario u WHERE u.UsuarioID = pUsuarioID)
	THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error - El usuario no existe o fue dado de baja.';
        SET pError = 1;
	END IF;

	SELECT uo.UsuarioObjetoID
		, uo.ObjetoID
        , uo.Tipo
        , uo.PuedeEvaluarFlag
    FROM GeoServiceQuality.Usuario u
    INNER JOIN GeoServiceQuality.UsuarioObjeto uo ON uo.UsuarioID = u.UsuarioID
    WHERE u.UsuarioID = pUsuarioID
		AND uo.PuedeEvaluarFlag = 1
    ORDER BY uo.Tipo
		, uo.ObjetoID;
			
END //