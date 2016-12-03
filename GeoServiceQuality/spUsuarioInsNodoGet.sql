USE GeoServiceQuality;

DROP PROCEDURE IF EXISTS spUsuarioInsNodoGet;

DELIMITER //

CREATE PROCEDURE spUsuarioInsNodoGet
(
	pUsuarioID INT
    , pInstitucionID INT
    , OUT pError INT -- 0 si ok, 1 si hay error por parametros
)

/************************************************************************************************************
** Name: dbo.spUsuarioInsNodoGet
**
** Desc: Devuelve la lista de Nodos disponibles dentro de una Institucion y disponibles para que el usuario pueda evaluar
**
** 02/12/2016 - Created
**
*************************************************************************************************************/
BEGIN

	SET pError = 0;
    
	-- parametros requeridos
	IF (pUsuarioID IS NULL OR pInstitucionID IS NULL)
	THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error - Los parametros ID de Usuario e ID de institucion son requeridos.';
        SET pError = 1;
	END IF;

	SELECT n.InstitucionID
        , n.Nombre
        , n.Descripcion
    FROM GeoServiceQuality.Usuario u
    INNER JOIN GeoServiceQuality.UsuarioObjeto uo ON uo.UsuarioID = u.UsuarioID
    INNER JOIN GeoServiceQuality.Institucion institucion ON institucion.institucionID = uo.ObjetoID
    INNER JOIN GeoServiceQuality.Nodo n ON n.InstitucionID = institucion.InstitucionID
    WHERE u.UsuarioID
        AND uo.Tipo = 'Ins'
        AND uo.PuedeEvaluarFlag = 1
        AND institucion.InstitucionID = pInstitucionID
	ORDER BY n.NodoID;
    
END //
   	