--DROP FUNCTION usuario_objetos_medibles_get(integer)
CREATE OR REPLACE FUNCTION usuario_objetos_medibles_get
(
   pUsuarioID INT
)
RETURNS TABLE 
   (
      IdeID INT
      , IdeNombre VARCHAR(40)
      , IdeDescripcion VARCHAR(100)
      , InstitucionID INT
      , InstitucionNombre VARCHAR(40)
      , InstitucionDescripcion VARCHAR(100)
      , NodoID INT
      , NodoNombre VARCHAR(40)
      , NodoDescripcion VARCHAR(100)
      --, CapaID INT
      , ServicioGeograficoID INT
      , ServicioGeograficoURL VARCHAR(1024)
      , ServicioGeograficoTipo CHAR(3)
 ) AS $$
/************************************************************************************************************
** Name: usuario_objetos_medibles_get
**
** Desc: Devuelve la lista de objetos medibles disponibles para que usuario pueda evaluar
**
** 02/12/2016   RS - Created
**
*************************************************************************************************************/
BEGIN

   -- parametros requeridos
   IF (pUsuarioID IS NULL)
   THEN
      RAISE EXCEPTION 'Error - El ID del Usuario es requerido.';
   END IF;

   -- Lista de objetos medibles sobre los cuales el usuario puede realizar evaluaciones
   RETURN QUERY
   SELECT ide.IdeID
      , ide.Nombre AS IdeNombre
      , ide.Descripcion AS IdeDescripcion
      , ins.InstitucionID
      , ins.Nombre AS InstitucionNombre
      , ins.Descripcion AS InstitucionDescripcion
      , n.NodoID
      , n.Nombre AS NodoNombre
      , n.Descripcion AS NodoDescripcion
      --, CapaID
      , sg.ServicioGeograficoID
      , sg.URL AS ServicioGeograficoURL
      , sg.Tipo AS ServicioGeograficoTipo
   FROM Ide ide
   INNER JOIN Institucion ins ON ins.IdeID = ide.IdeID
   INNER JOIN Nodo n ON n.InstitucionID = ins.InstitucionID
   --INNER JOIN Capa c
   INNER JOIN ServicioGeografico sg ON sg.NodoID = n.NodoID
   INNER JOIN UsuarioObjeto uo ON 
      CASE
         WHEN uo.Tipo = 'Ide' THEN uo.ObjetoID = ide.IdeID
         WHEN uo.Tipo = 'Ins' THEN uo.ObjetoID = ins.InstitucionID
         WHEN uo.Tipo = 'Nodo' THEN uo.ObjetoID = n.NodoID
         --WHEN uo.Tipo = 'Capa' THEN uo.ObjetoID = c.CapaID
         WHEN uo.Tipo = 'Servicio' THEN uo.ObjetoID = sg.ServicioGeograficoID
      END
   INNER JOIN Usuario u ON u.UsuarioID = uo.UsuarioID
   WHERE u.UsuarioID = pUsuarioID
      AND uo.PuedeEvaluarFlag = TRUE
   GROUP BY ide.IdeID
      , ide.Nombre
      , ide.Descripcion
      , ins.InstitucionID
      , ins.Nombre
      , ins.Descripcion
      , n.NodoID
      , n.Nombre
      , n.Descripcion
      --, CapaID
      , sg.ServicioGeograficoID
      , sg.URL
      , sg.Tipo
   ORDER BY IdeID
      , InstitucionID
      , NodoID
      --, CapaID INT
      , ServicioGeograficoID;
        
END;
$$ LANGUAGE plpgsql;