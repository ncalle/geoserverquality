--DROP FUNCTION servicio_geografico_insert(integer,integer,character varying,character)
CREATE OR REPLACE FUNCTION servicio_geografico_insert
(
   pUsuarioID INT
   , pNodoID INT
   , pUrl VARCHAR(1024)
   , pTipo CHAR(3)
)
RETURNS VOID AS $$
/************************************************************************************************************
** Name: servicio_geografico_insert
**
** Desc: Agrega un servicios geograficos disponibles al sistema y lo asocia al usuario que lo da de alta
**
** 08/12/2016 Created
**
*************************************************************************************************************/
DECLARE SGID INT;

BEGIN

   -- parametros requeridos
   IF (pUsuarioID IS NULL OR pNodoID IS NULL OR pUrl IS NULL OR pTipo IS NULL)
   THEN
      RAISE EXCEPTION 'Error - Los parametro ID de Usuario, ID de Nodo, URL y Tipo de servicio son requerido.';
   END IF;
    
   -- validacion Usuario
   IF NOT EXISTS (SELECT 1 FROM Usuario u WHERE u.UsuarioID = pUsuarioID)
   THEN
      RAISE EXCEPTION 'Error - El Usuario que intenta agregar el Servicio no es correcto.';
   END IF;

   -- validacion NodoID
   IF NOT EXISTS (SELECT 1 FROM Nodo n WHERE n.NodoID = pNodoID)
   THEN
      RAISE EXCEPTION 'Error - El Nodo que se intenta agregar para el Servicio no existe.';
   END IF;

   INSERT INTO ServicioGeografico
   (NodoID, Url, Tipo)
   VALUES
   (pNodoID, pUrl, pTipo)
      RETURNING ServicioGeograficoID INTO SGID;

   INSERT INTO UsuarioObjeto
   (UsuarioID, ObjetoID, Tipo, PuedeEvaluarFlag)
   VALUES
   (pUsuarioID, SGID, 'Servicio', TRUE);
         
END;
$$ LANGUAGE plpgsql;