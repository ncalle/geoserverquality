SELECT * FROM user_get (NULL,'tecnico1@mail.com','tecnico1'); --ok
SELECT * FROM user_get (NULL,'institucional1@mail.com','institucional1'); --ok
SELECT * FROM user_get (4,NULL,NULL); --ok
SELECT * FROM user_get (NULL,NULL,NULL); --ok
--------------------------------------------------------------------
SELECT * FROM user_permission_get (1); --ok
SELECT * FROM user_permission_get (NULL); --err
SELECT * FROM user_permission_get (12345); --err
--------------------------------------------------------------------
SELECT * FROM user_insert ('userInsert1@gmail.com', 'passInsert1', 1, 'Tibursio', 'Gomez', 098898876, 3); --ok
   SELECT * FROM user_get (NULL,'userInsert1@gmail.com','passInsert1'); --ok
SELECT * FROM user_insert (NULL, 'passInsert1', 1, 'Tibursio', 'Gomez', 098898876, 3); --err
SELECT * FROM user_insert ('userInsert1@gmail.com', NULL, 1, 'Tibursio', 'Gomez', 098898876, 3); --err
SELECT * FROM user_insert ('userInsert1@gmail.com', 'passInsert1', NULL, 'Tibursio', 'Gomez', 098898876, 3); --err
SELECT * FROM user_insert ('userInsert1@gmail.com', 'otraPass', 2, 'Otro Tibursio', 'Otro Gomez', 098898876, 3); --err
--------------------------------------------------------------------
SELECT * FROM user_delete (10); --ok
   SELECT * FROM user_get (NULL,'userInsert1@gmail.com','passInsert1'); --ok
SELECT * FROM user_delete (1111); --err
--------------------------------------------------------------------
SELECT * FROM measurable_object_get (); --ok
	--prototipo
	SELECT * FROM prototype_measurable_objects_get (null); --ok
--------------------------------------------------------------------
SELECT * FROM measurable_objects_by_user_get (1); --ok
SELECT * FROM measurable_objects_by_user_get (NULL); --err
--------------------------------------------------------------------
SELECT * FROM user_evaluation_get (1, NULL, NULL, NULL, NULL, NULL); --ok
SELECT * FROM user_evaluation_get (NULL, NULL, NULL, NULL, NULL, NULL); --err
--------------------------------------------------------------------
SELECT * FROM prototype_measurable_objects_insert (1, 5, 'http://serviciogeografico/Nodo1.2.3/Servicio2.1.2.3', 'WMS'); --ok
   SELECT * FROM measurable_object_get (); --ok
   SELECT * FROM measurable_objects_by_user_get (1); --ok
--------------------------------------------------------------------
SELECT * FROM profile_insert ('TestPerfil2', 'Servicio', '1,2,3,4,5,6,7,8,9,10,11,12,43,56,14,231'); --ok
SELECT * FROM profile_insert ('TestPerfil2', NULL, '1,2,3,4,5,6,7,8,9,10,11,12,43,56,14,231'); --err
SELECT * FROM profile_insert (NULL, 'Servicio', '1,2,3,4,5,6,7,8,9,10,11,12,43,56,14,231'); --err
SELECT * FROM profile_insert ('TestPerfil2', 'Servicio', NULL); --err
--------------------------------------------------------------------
SELECT * FROM profile_get (); --ok
--------------------------------------------------------------------
SELECT * FROM evaluation_insert (1, 1, TRUE); --ok
   SELECT * FROM user_evaluation_get (1, NULL, NULL, NULL, NULL, NULL); --ok
SELECT * FROM evaluation_insert (1, 2, TRUE); --err
   