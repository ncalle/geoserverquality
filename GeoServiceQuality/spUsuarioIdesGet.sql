USE GeoServiceQuality;

DROP PROCEDURE IF EXISTS spUsuarioIdesGet;

DELIMITER //

CREATE PROCEDURE spUsuarioIdesGet
(
	pUsuarioID INT
    , OUT pError INT -- 0 si ok, 1 si hay error por parametros
)

/************************************************************************************************************
** Name: dbo.spUsuarioIdesGet
**
** Desc: Devuelve la lista de IDEs disponibles para que usuario pueda evaluar
**
** 02/12/2016	RS	- Created
**
*************************************************************************************************************/
BEGIN

	SET pError = 0;
    
	-- parametros requeridos
	IF (pUsuarioID IS NULL)
	THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error - El ID del Usuario es requerido.';
        SET pError = 1;
	END IF;

	-- Lista de IDEs sobre los cuales el usuario puede realizar evaluaciones
	SELECT ide.IdeID
		, ide.Nombre
        , ide.Descripcion
    FROM GeoServiceQuality.Usuario u
    INNER JOIN GeoServiceQuality.UsuarioObjeto uo ON uo.UsuarioID = u.UsuarioID
    INNER JOIN GeoServiceQuality.Ide ide ON ide.IdeID = uo.ObjetoID
    WHERE u.UsuarioID = pUsuarioID
		AND uo.Tipo = 'Ide'
        AND uo.PuedeEvaluarFlag = 1
	ORDER BY ide.IdeID;
        
END //
   	