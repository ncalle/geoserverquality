USE GeoServiceQuality;

DROP PROCEDURE IF EXISTS spUsuarioInsNodoServicioGet;

DELIMITER //

CREATE PROCEDURE spUsuarioInsNodoServicioGet
(
	pUsuarioID INT
    , pInstitucionID INT
    , pNodoID INT
    , OUT pError INT -- 0 si ok, 1 si hay error por parametros
)

/************************************************************************************************************
** Name: dbo.spUsuarioInsNodoServicioGet
**
** Desc: Devuelve la lista de Servicios disponibles dentro de una (Institucion, Nodo) y disponibles para que el usuario pueda evaluar
**
** 02/12/2016 - Created
**
*************************************************************************************************************/
BEGIN

	SET pError = 0;
    
	-- parametros requeridos
	IF (pUsuarioID IS NULL OR pInstitucionID IS NULL OR pNodoID IS NULL)
	THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error - Los parametros ID de Usuario, ID de institucion e ID del Nodo son requeridos.';
        SET pError = 1;
	END IF;

	SELECT sg.ServicioGeograficoID
        , sg.Url
        , sg.Tipo
    FROM GeoServiceQuality.Usuario u
    INNER JOIN GeoServiceQuality.UsuarioObjeto uo ON uo.UsuarioID = u.UsuarioID
    INNER JOIN GeoServiceQuality.Institucion institucion ON institucion.institucionID = uo.ObjetoID
    INNER JOIN GeoServiceQuality.Nodo n ON n.InstitucionID = institucion.InstitucionID
    INNER JOIN GeoServiceQuality.ServicioGeografico sg ON sg.NodoID = n.NodoID
    WHERE u.UsuarioID
        AND uo.Tipo = 'Ins'
        AND uo.PuedeEvaluarFlag = 1
        AND institucion.InstitucionID = pInstitucionID
        AND n.NodoID = pNodoID
	ORDER BY sg.ServicioGeograficoID;
    
END //
   	