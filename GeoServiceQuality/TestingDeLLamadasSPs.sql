CALL spUsuarioGet ('tecnico1@mail.com','tecnico1', @pError);
SELECT @pError;
-- ------------------------------------------------------------------
CALL spPermisosDeUsuarioGet (1, @pError);
SELECT @pError;
-- ------------------------------------------------------------------
CALL spUsuarioInsert ('userInsert1@gmail.com', 'passInsert1', 1, 'Tibursio', 'Gomez', 098898876, @pError);
SELECT @pError;
-- ------------------------------------------------------------------
CALL spUsuarioDelete (4, @pError);
SELECT @pError;
-- ------------------------------------------------------------------
CALL spUsuarioIdesGet (1, @pError);
SELECT @pError;
-- ------------------------------------------------------------------
CALL spUsuarioInstitucionesGet (1, @pError);
SELECT @pError;
-- ------------------------------------------------------------------
CALL spUsuarioInsNodoGet (1,1, @pError);
SELECT @pError;
-- ------------------------------------------------------------------
CALL spUsuarioInsNodoServicioGet (1,1,1, @pError);
SELECT @pError;
-- ------------------------------------------------------------------
CALL spUsuarioEvaluacionesGet (1, NULL, NULL, NULL, NULL, NULL, @pError);
SELECT @pError;
-- ------------------------------------------------------------------
