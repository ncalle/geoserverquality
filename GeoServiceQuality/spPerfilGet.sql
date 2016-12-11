USE GeoServiceQuality;

DROP PROCEDURE IF EXISTS spPerfilGet;

DELIMITER //

CREATE PROCEDURE spPerfilGet
(
	OUT pError INT -- 0 si ok, 1 si hay error por parametros
)

/************************************************************************************************************
** Name: dbo.spPerfilGet
**
** Desc: Devuelve el conunto de Perfiles disponibles con sus Rangos y Metricas asociadas
**
** 08/12/2016 Created
**
*************************************************************************************************************/
BEGIN

	SET pError = 0;

	SELECT p.PerfilID
		, p.Nombre
		, p.EsPerfilPonderadoFlag
        , m.MetricaID
        , m.Nombre
        , m.FactorID
        , m.UnidadID
        , r.RangoID
        , r.BoleanoFlag
        , r.EnteroFlag
        , r.EnumeradoFlag
        , r.PorcentajeFlag
        , r.ValorAcepatcionBoleano
        , r.ValorAceptacionEntero
        , r.ValorAceptacionEnumerado
        , r.ValorAceptacionPorcentaje
    FROM GeoServiceQuality.Perfil p
    INNER JOIN GeoServiceQualitY.Rango r ON r.PerfilID = p.PerfilID
    INNER JOIN GeoServiceQuality.Metrica m ON m.MetricaID = r.MetricaID
    ORDER BY p.PerfilID
		, m.MetricaID
        , r.RangoID;
			
END //