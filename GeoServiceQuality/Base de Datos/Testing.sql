SELECT * FROM usuario_get ('tecnico1@mail.com','tecnico1'); --ok
SELECT * FROM usuario_get ('institucional1@mail.com','institucional1'); --ok
SELECT * FROM usuario_get (NULL,'institucional1'); --err
SELECT * FROM usuario_get ('tecnico1@mail.com',NULL); --err
--------------------------------------------------------------------
SELECT * FROM permisos_de_usuario_get (1); --ok
SELECT * FROM permisos_de_usuario_get (NULL); --err
SELECT * FROM permisos_de_usuario_get (12345); --err
--------------------------------------------------------------------
SELECT * FROM usuario_insert ('userInsert1@gmail.com', 'passInsert1', 1, 'Tibursio', 'Gomez', 098898876, 3); --ok
   SELECT * FROM usuario_get ('userInsert1@gmail.com','passInsert1'); --ok
SELECT * FROM usuario_insert (NULL, 'passInsert1', 1, 'Tibursio', 'Gomez', 098898876, 3); --err
SELECT * FROM usuario_insert ('userInsert1@gmail.com', NULL, 1, 'Tibursio', 'Gomez', 098898876, 3); --err
SELECT * FROM usuario_insert ('userInsert1@gmail.com', 'passInsert1', NULL, 'Tibursio', 'Gomez', 098898876, 3); --err
SELECT * FROM usuario_insert ('userInsert1@gmail.com', 'otraPass', 2, 'Otro Tibursio', 'Otro Gomez', 098898876, 3); --err
--------------------------------------------------------------------
SELECT * FROM usuario_delete (10); --ok
   SELECT * FROM usuario_get ('userInsert1@gmail.com','passInsert1'); --ok
SELECT * FROM usuario_delete (1111); --err
--------------------------------------------------------------------
SELECT * FROM objetos_medibles_get (); --ok
--------------------------------------------------------------------
SELECT * FROM usuario_objetos_medibles_get (1); --ok
SELECT * FROM usuario_objetos_medibles_get (NULL); --err
--------------------------------------------------------------------
SELECT * FROM usuario_evaluaciones_get (1, NULL, NULL, NULL, NULL, NULL); --ok
SELECT * FROM usuario_evaluaciones_get (NULL, NULL, NULL, NULL, NULL, NULL); --err
--------------------------------------------------------------------
SELECT * FROM servicio_geografico_insert (1, 5, 'http://serviciogeografico/Nodo1.2.3/Servicio2.1.2.3', 'WMS'); --ok
   SELECT * FROM objetos_medibles_get (); --ok
   SELECT * FROM usuario_objetos_medibles_get (1); --ok
--------------------------------------------------------------------
SELECT * FROM perfil_insert ('TestPerfil2', 'Servicio', '1,2,3,4,5,6,7,8,9,10,11,12,43,56,14,231'); --ok
SELECT * FROM perfil_insert ('TestPerfil2', NULL, '1,2,3,4,5,6,7,8,9,10,11,12,43,56,14,231'); --err
SELECT * FROM perfil_insert (NULL, 'Servicio', '1,2,3,4,5,6,7,8,9,10,11,12,43,56,14,231'); --err
SELECT * FROM perfil_insert ('TestPerfil2', 'Servicio', NULL); --err
--------------------------------------------------------------------
SELECT * FROM perfil_get (); --ok
--------------------------------------------------------------------
SELECT * FROM evaluacion_insert (1, 1, TRUE); --ok
   SELECT * FROM usuario_evaluaciones_get (1, NULL, NULL, NULL, NULL, NULL); --ok
SELECT * FROM evaluacion_insert (1, 2, TRUE); --err
   