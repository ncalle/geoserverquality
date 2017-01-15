CREATE OR REPLACE FUNCTION usuario_delete
(
   pUsuarioID INT
)
RETURNS VOID AS $$
/************************************************************************************************************
** Name: usuario_delete
**
** Desc: Quita el Usuario de UsuarioID de la tabla Usuario
**
** 04/12/2016 Created
**
*************************************************************************************************************/
-- TODO: Asegurarse desde el codigo o BD que al solicitar un borrado, no se llamen a posibles instancias pendientes de evaluacion para el usuario eliminado
BEGIN
   
   -- parametros requeridos
   IF (pUsuarioID IS NULL)
   THEN
      RAISE EXCEPTION 'Error - El parametro ID de usuario es requerido.';
   END IF;
    
   IF NOT EXISTS (SELECT 1 FROM Usuario u WHERE u.UsuarioID = pUsuarioID)
   THEN
      RAISE EXCEPTION 'Error - El usuario de ID: % no existe.', pUsuarioID;
   END IF;

   -- Borrado de registros dependientes del usuario  
   DELETE FROM UsuarioObjeto
   WHERE UsuarioID = pUsuarioID;
    
   DELETE FROM EvaluacionParcial ep
   USING Evaluacion e 
   WHERE e.EvaluacionID = ep.EvaluacionID
      AND e.UsuarioID = pUsuarioID;
    
   DELETE FROM Evaluacion
   WHERE UsuarioID = pUsuarioID;
    
   -- Borrado del usuario de la tabla Usuario
   DELETE FROM Usuario
   WHERE UsuarioID = pUsuarioID;
    
END;
$$ LANGUAGE plpgsql;