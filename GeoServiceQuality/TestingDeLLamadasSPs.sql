CALL spDatosDeUsuarioGet ('tecnico1@mail.com','tecnico1', @pError);
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
CALL spUsuarioInsert ('userInsert1@gmail.com', 'passInsert1', 1, 'Tibursio', 'Gomez', 098898876, @pError);
SELECT @pError;
-- ------------------------------------------------------------------