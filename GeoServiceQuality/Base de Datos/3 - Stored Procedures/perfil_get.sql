--DROP FUNCTION perfil_get()
CREATE OR REPLACE FUNCTION perfil_get()
RETURNS TABLE 
   (
      PerfilID INT
      , PerfilNombre VARCHAR(40)
      , EsPerfilPonderadoFlag BOOLEAN
      , MetricaID INT
      , MetricaNombre VARCHAR(100)
      , FactorID INT
      , UnidadID INT
      , RangoID INT
      , BoleanoFlag BOOLEAN
      , EnteroFlag BOOLEAN
      , EnumeradoFlag BOOLEAN
      , PorcentajeFlag BOOLEAN
      , ValorAceptacionBoleano BOOLEAN
      , ValorAceptacionEntero INT
      , ValorAceptacionEnumerado CHAR(1)
      , ValorAceptacionPorcentaje INT
   ) AS $$
/************************************************************************************************************
** Name: perfil_get
**
** Desc: Devuelve el conunto de Perfiles disponibles con sus Rangos y Metricas asociadas
**
** 08/12/2016 Created
**
*************************************************************************************************************/
BEGIN

   RETURN QUERY
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
      , r.ValorAceptacionBoleano
      , r.ValorAceptacionEntero
      , r.ValorAceptacionEnumerado
      , r.ValorAceptacionPorcentaje
   FROM Perfil p
   INNER JOIN Rango r ON r.PerfilID = p.PerfilID
   INNER JOIN Metrica m ON m.MetricaID = r.MetricaID
   ORDER BY p.PerfilID
      , m.MetricaID
      , r.RangoID;
         
END;
$$ LANGUAGE plpgsql;