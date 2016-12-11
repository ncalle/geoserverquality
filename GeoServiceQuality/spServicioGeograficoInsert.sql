USE GeoServiceQuality;

DROP PROCEDURE IF EXISTS spServicioGeograficoInsert;

DELIMITER //

CREATE PROCEDURE spServicioGeograficoInsert
(
    pNodoID INT
    , pUrl VARCHAR(1024)
    , pTipo CHAR(3)
	, OUT pError INT -- 0 si ok, 1 si hay error por parametros
)

/************************************************************************************************************
** Name: dbo.spServicioGeograficoInsert
**
** Desc: Agrega un servicios geograficos disponibles al sistema
**
** 08/12/2016 Created
**
*************************************************************************************************************/
BEGIN

	SET pError = 0;
    
	-- parametros requeridos
	IF (pNodoID IS NULL OR pUrl IS NULL OR pTipo IS NULL)
	THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error - Los parametro ID de Nodo, URL y Tipo de servicio son requerido.';
        SET pError = 1;
	END IF;
    
	-- validacion NodoID
	IF NOT EXISTS (SELECT 1 FROM GeoServiceQuality.Nodo n WHERE n.NodoID = pNodoID)
	THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error - El Nodo que se intenta agregar para el Servicio no existe.';
        SET pError = 1;
	END IF;

	INSERT INTO GeoServiceQuality.ServicioGeografico
    (NodoID, Url, Tipo)
    VALUES
    (pNodoID, pUrl, pTipo);
			
END //