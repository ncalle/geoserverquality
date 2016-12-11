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
CALL spServicioGeograficoGet (@pError);
SELECT @pError;
-- ------------------------------------------------------------------
CALL spServicioGeograficoInsert (5, 'http://serviciogeografico/Nodo5/Servicio5.1', 'WMS', @pError);
SELECT @pError;
-- ------------------------------------------------------------------
CALL spUsuarioObjetoEvaluableGet (1, @pError);
SELECT @pError;
-- ------------------------------------------------------------------
CALL spPerfilGet (@pError);
SELECT @pError;
-- ------------------------------------------------------------------
CALL spPerfilInsert ('TestPerfil2' , '1,2,3,4,5,6,7,8,9,10,11,12,43,56,14,231', @pError);
SELECT @pError;
-- ------------------------------------------------------------------
CALL spEvaluacionInsert (1, 1, 1, @pError);
SELECT @pError;
