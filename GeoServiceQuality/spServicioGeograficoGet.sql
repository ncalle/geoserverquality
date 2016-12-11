USE GeoServiceQuality;

DROP PROCEDURE IF EXISTS spServicioGeograficoGet;

DELIMITER //

CREATE PROCEDURE spServicioGeograficoGet
(
	OUT pError INT -- 0 si ok, 1 si hay error por parametros
)

/************************************************************************************************************
** Name: dbo.spServicioGeograficoGet
**
** Desc: Devuelve conjunto de servicios geograficos disponibles
**
** 08/12/2016 Created
**
*************************************************************************************************************/
BEGIN

	SET pError = 0;

	SELECT sg.ServicioGeograficoID
		, sg.NodoID
        , sg.Url
        , sg.Tipo
    FROM GeoServiceQuality.ServicioGeografico sg
	ORDER BY sg.Url;
			
END //