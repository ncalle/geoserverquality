USE GeoServiceQuality;

DROP PROCEDURE IF EXISTS spUsuarioInstitucionesGet;

DELIMITER //

CREATE PROCEDURE spUsuarioInstitucionesGet
(
	pUsuarioID INT
    , OUT pError INT -- 0 si ok, 1 si hay error por parametros
)

/************************************************************************************************************
** Name: dbo.spUsuarioInstitucionesGet
**
** Desc: Devuelve la lista de Instituciones disponibles para que usuario pueda evaluar
**
** 02/12/2016 - Created
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

	SELECT institucion.InstitucionID
        , institucion.Nombre
        , institucion.Descripcion
    FROM GeoServiceQuality.Usuario u
    INNER JOIN GeoServiceQuality.UsuarioObjeto uo ON uo.UsuarioID = u.UsuarioID
    INNER JOIN GeoServiceQuality.Institucion institucion ON institucion.institucionID = uo.ObjetoID
    WHERE u.UsuarioID
        AND uo.Tipo = 'Ins'
        AND uo.PuedeEvaluarFlag = 1
	ORDER BY institucion.InstitucionID;
END //
   	