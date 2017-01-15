CREATE OR REPLACE FUNCTION evaluacion_insert
(
   pUsuarioID INT
   , pPerfilID INT
   , pResultadoExitosoFlag BOOLEAN
)
RETURNS VOID AS $$
/************************************************************************************************************
** Name: evaluacion_insert
**
** Desc: Ingreso de evaluacion
**
** 11/12/2016 Created
**
*************************************************************************************************************/
BEGIN
    
   -- parametros requeridos
   IF (pUsuarioID IS NULL OR pPerfilID IS NULL)
   THEN
      RAISE EXCEPTION 'Error - Los parametros ID de Usuario, ID de Perfil son requerido.';
   END IF;
    
   -- validacion
   IF NOT EXISTS (SELECT 1 FROM Usuario u WHERE u.UsuarioID = pUsuarioID)
   THEN
      RAISE EXCEPTION 'Error - El ID de Usuario no es correcto.';
   END IF;
    
   -- validacion
   IF NOT EXISTS (SELECT 1 FROM Perfil p WHERE p.PerfilID = pPerfilID)
   THEN
      RAISE EXCEPTION 'Error - El ID de Perfil no es correcto.';
   END IF;    

   -- Ingreso de Evaluacion
   INSERT INTO Evaluacion
   (UsuarioID, PerfilID, FechaDeComienzo, FechaDeFin, EvaluacionCompletaFlag, ResultadoExitosoFlag)
   VALUES
   (pUsuarioID, pPerfilID, CURRENT_DATE, CURRENT_DATE, TRUE, pResultadoExitosoFlag);

END;
$$ LANGUAGE plpgsql;