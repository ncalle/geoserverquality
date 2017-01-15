--DROP FUNCTION objetos_medibles_get(integer)
CREATE OR REPLACE FUNCTION objetos_medibles_get ()
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
** Name: objetos_medibles_get
**
** Desc: Devuelve la lista de objetos medibles disponibles
**
** 02/12/2016   RS - Created
**
*************************************************************************************************************/
BEGIN

   -- Lista de objetos medibles
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