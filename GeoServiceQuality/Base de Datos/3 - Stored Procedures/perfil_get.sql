--DROP FUNCTION perfil_get()
CREATE OR REPLACE FUNCTION perfil_get()
RETURNS TABLE 
   (
      PerfilID INT
      , PerfilNombre VARCHAR(40)
      , PerfilGranuralidad VARCHAR(11)
      , EsPerfilPonderadoFlag BOOLEAN
      , MetricaID INT
      , MetricaFactorID INT	  
      , MetricaNombre VARCHAR(100)
      , MetricaAgregacionFlag BOOLEAN
      , MetricaUnidadID INT
      , MetricaGranuralidad VARCHAR(11)
      , MetricaDescripcion VARCHAR(100)
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
      , p.Granuralidad
      , p.EsPerfilPonderadoFlag
      , m.MetricaID
      , m.FactorID	  
      , m.Nombre
      , m.AgregacionFlag
      , m.UnidadID
      , m.Granuralidad
      , m.Descripcion
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