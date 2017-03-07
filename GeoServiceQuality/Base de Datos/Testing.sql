SELECT * FROM user_get (NULL,'ncalle@mail.com','ncalle'); --ok
SELECT * FROM user_get (NULL,'rsanchez@mail.com','rsanchez'); --ok
SELECT * FROM user_get (4,NULL,NULL); --ok
SELECT * FROM user_get (NULL,NULL,NULL); --ok
--------------------------------------------------------------------
SELECT * FROM user_permission_get (1); --ok
SELECT * FROM user_permission_get (NULL); --err ok
SELECT * FROM user_permission_get (12345); --err ok
--------------------------------------------------------------------
SELECT * FROM user_insert ('userInsert1@gmail.com', 'passInsert1', 1, 'Tibursio', 'Gomez', 098898876, 3); --ok
   SELECT * FROM user_get (NULL,'userInsert1@gmail.com','passInsert1'); --ok
SELECT * FROM user_insert (NULL, 'passInsert1', 1, 'Tibursio', 'Gomez', 098898876, 3); --err ok
SELECT * FROM user_insert ('userInsert1@gmail.com', NULL, 1, 'Tibursio', 'Gomez', 098898876, 3); --err ok
SELECT * FROM user_insert ('userInsert1@gmail.com', 'passInsert1', NULL, 'Tibursio', 'Gomez', 098898876, 3); --err ok
SELECT * FROM user_insert ('userInsert1@gmail.com', 'otraPass', 2, 'Otro Tibursio', 'Otro Gomez', 098898876, 3); --err ok
--------------------------------------------------------------------
SELECT * FROM user_delete (10); --ok
   SELECT * FROM user_get (NULL,'userInsert1@gmail.com','passInsert1'); --ok
SELECT * FROM user_delete (1111); --err ok
--------------------------------------------------------------------
SELECT * FROM measurable_object_get (); --ok
   SELECT * FROM prototype_measurable_objects_get (null); --ok
   SELECT * FROM prototype_measurable_objects_get (1); --ok	
   SELECT * FROM prototype_measurable_objects_get (2); --ok
   SELECT * FROM prototype_measurable_objects_get (3); --ok
--------------------------------------------------------------------
SELECT * FROM prototype_user_measurable_object_to_add_get(1); --ok
SELECT * FROM prototype_user_measurable_object_to_add_get(3); --ok
SELECT * FROM prototype_user_remove_measurable_object(1,4,'Servicio'); --ok
SELECT * FROM prototype_user_measurable_object_to_add_get(1); --ok
--------------------------------------------------------------------
SELECT * FROM prototype_user_add_measurable_object(2, 1, 'Servicio'); --err ok
--------------------------------------------------------------------
SELECT * FROM measurable_objects_by_user_get (1); --ok
SELECT * FROM measurable_objects_by_user_get (NULL); --err ok
--------------------------------------------------------------------
SELECT * FROM user_evaluation_get (1, NULL, NULL, NULL, NULL, NULL); --ok
SELECT * FROM user_evaluation_get (NULL, NULL, NULL, NULL, NULL, NULL); --err ok
--------------------------------------------------------------------
SELECT * FROM prototype_measurable_objects_insert (5, 'http://serviciogeografico/Nodo1.2.3/Servicio2.1.2.3', 'WMS', 'Descripcion TESTING', 'Servicio'); --ok
   SELECT * FROM measurable_object_get (); --ok
   SELECT * FROM measurable_objects_by_user_get (1); --ok
   SELECT * FROM prototype_user_measurable_object_to_add_get(1); --ok
--------------------------------------------------------------------
SELECT * FROM profile_insert ('TestPerfil2', 'Servicio', '1,2,3,4,5,6,7,8,9,10,11,12,43,56,14,231'); --ok
SELECT * FROM profile_insert ('TestPerfil2', NULL, '1,2,3,4,5,6,7,8,9,10,11,12,43,56,14,231'); --err ok
SELECT * FROM profile_insert (NULL, 'Servicio', '1,2,3,4,5,6,7,8,9,10,11,12,43,56,14,231'); --err ok
SELECT * FROM profile_insert ('TestPerfil2', 'Servicio', NULL); --err ok
--------------------------------------------------------------------
SELECT * FROM profile_get (); --ok
--------------------------------------------------------------------
SELECT * FROM evaluation_insert (1, 1, TRUE); --ok
   SELECT * FROM user_evaluation_get (1, NULL, NULL, NULL, NULL, NULL); --ok
SELECT * FROM evaluation_insert (1, 2, TRUE); --err ok
--------------------------------------------------------------------
SELECT * FROM user_group_get(null); --ok
SELECT * FROM user_group_get(2); --ok
--------------------------------------------------------------------   
SELECT * FROM institution_get(null); --ok
SELECT * FROM institution_get(2); --ok
--------------------------------------------------------------------   
SELECT * FROM quality_models_get(); --ok
--------------------------------------------------------------------  
SELECT * FROM prototype_measurable_objects_get (null); --ok
SELECT * FROM prototype_measurable_objects_delete(5, 'Servicio'); --ok
--------------------------------------------------------------------  
SELECT * FROM prototype_measurable_object_update(2, 'Servicio', 'http://testing', 'CSW', 'Testing url description'); --ok
SELECT * FROM prototype_measurable_objects_get (null); --ok
--------------------------------------------------------------------  
SELECT * FROM profile_metric_get(1,null); --ok
SELECT * FROM profile_metric_get(1,1); --ok
SELECT * FROM profile_metric_get(1,2); --ok
SELECT * FROM profile_metric_get(1121); --err ok
SELECT * FROM profile_metric_get(null); --err ok
--------------------------------------------------------------------  
SELECT * FROM profile_delete(2); --ok
SELECT * FROM profile_delete(null); --err ok
SELECT * FROM profile_delete(67); --err ok
--------------------------------------------------------------------
SELECT * FROM profile_update (1, 'Cambio de Nombre', 'Ide'); --ok
SELECT * FROM profile_get (); --ok
SELECT * FROM profile_update (1, 'Cambio de Nombre', 'otra cosa'); --err ok
SELECT * FROM profile_update (123, 'Cambio de Nombre', 'Ide'); --err ok
--------------------------------------------------------------------
SELECT * FROM profile_remove_metric (2, 3); --ok
SELECT * FROM profile_remove_metric (64, 3); --ok
SELECT * FROM profile_remove_metric (2, 34533); --ok
--------------------------------------------------------------------
SELECT * FROM prototype_profile_add_metric (2, 5); --err ok
SELECT * FROM prototype_profile_add_metric (30, 5); --err ok
SELECT * FROM prototype_profile_add_metric (1, 5); --ok
--------------------------------------------------------------------
SELECT * FROM prototype_profile_metric_to_add_get (1); --ok
--------------------------------------------------------------------
SELECT * FROM metric_get(); --ok
--------------------------------------------------------------------
SELECT * FROM profile_metric_update (2,FALSE,NULL,NULL,NULL); --ok
SELECT * FROM profile_metric_get(1,null); --ok
SELECT * FROM profile_metric_update (2,TRUE,NULL,NULL,NULL); --ok
SELECT * FROM profile_metric_get(1,null); --ok
SELECT * FROM profile_metric_update (2,FALSE,NULL,NULL,'I'); --err ok
SELECT * FROM profile_metric_get(1,null); --ok