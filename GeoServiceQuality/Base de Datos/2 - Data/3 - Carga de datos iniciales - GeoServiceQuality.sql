INSERT INTO UserGroup (Name, Description) VALUES
('Administrador Tecnico','Usuario administrador que tiene completo acceso a todas las funcionalidades.'),
('Administrador General','Usuario con el fin de realizar gestion y cuidado de la herramienta.'),
('Administrador IDE','Usuario que tiene como cometido realizar evaluaciones sobre IDEs.'),
('Administrador Institucional','Usuario que tiene como cometido realizar evaluaciones sobre Instituciones.');

-- Permisos
INSERT INTO UserPermission (Name, Description) VALUES
('Alta de Usuario','Alta de Usuario'),
('Baja de Usuario','Baja de Usuario'),
('Modificacion de Usuario','Modificacion de Usuario'),
('Alta de Perfil','Alta de Perfil de evaluacion'),
('Baja de Perfil','Baja de Perfil de evaluacion'),
('Modificacion de Perfil','Modificacion de Perfil de evaluacion'),
('Alta de objeto medible','Alta de objetos medibles'),
('Baja de objeto medible','Baja de objetos medibles'),
('Modificacion de objeto medible','Modificacion de objetos medibles'),
('Alta de modelo','Alta de modelo de calidad'),
('Baja de modelo','Baja de modelo de calidad'),
('Modificacion de modelo','Modificacion de modelo de calidad'),
('Evaluacion de objeto medible','Evaluacion de objetos medibles');

INSERT INTO GroupPermission (UserPermissionID, UserGroupID)
SELECT p.UserPermissionID, 1 -- Tecnico
FROM UserPermission p
UNION
SELECT p.UserPermissionID, 2 -- General
FROM UserPermission p
WHERE p.UserPermissionID IN (13) --Evaluacion
UNION
SELECT p.UserPermissionID, 3 -- IDE
FROM UserPermission p
WHERE p.UserPermissionID IN (13) --Evaluacion
UNION
SELECT p.UserPermissionID, 4 -- Institucion
FROM UserPermission p
WHERE p.UserPermissionID IN (13); --Evaluacion

INSERT INTO QualityModel (Name) VALUES
('ModeloIDEuy');

INSERT INTO Dimension (QualityModelID, Name) VALUES
(1, 'Seguridad'),
(1, 'Confiabilidad'),
(1, 'Rendimiento'),
(1, 'Interoperabilidad'),
(1, 'Publicacion de Datos'),
(1, 'Metadatos'),
(1, 'Usabilidad');

INSERT INTO Factor (DimensionID, Name) VALUES
(1, 'Ingegridad'),
(1, 'Proteccion'),
(2, 'Disponibilidad'),
(2, 'Robustez'),
(3, 'Tiempo de respuesta'),
(3, 'Capacidad'),
(4, 'Soporte de estandares'),
(4, 'Sistema de referencias'),
(5, 'Representacion Grafica'),
(5, 'Formatos soportados'),
(6, 'Publicacion Catalogo'),
(6, 'Metadatos Capa'),
(6, 'Metadatos Servicio'),
(7, 'Facilidad de aprendizaje');

INSERT INTO Unit (Name, Description) VALUES 
('Boleano',''),
('Porcentaje',''),
('Milisegundos',''),
('Basico-Intermedio-Completo',''),
('Entero','');

INSERT INTO Metric (FactorID, Name, AgrgegationFlag, UnitID, Granurality) VALUES
(1, 'Integridad de datos', FALSE, 1, 'Nodo'),
(2, 'Informacion en excepciones', FALSE, 1, 'Servicio'),
(3, 'Disponibilidad diaria del servicio', FALSE, 2, 'Servicio'),
(4, 'Tolerancia a parametros nulos', FALSE, 1, 'Método'),
(4, 'Tolerancia a parametros largos', FALSE, 1, 'Método'),
(5, 'Promedio tiempo de respuesta diario', FALSE, 3, 'Método'),
(6, 'Tope Maximo de Objetos', FALSE, 1, 'Nodo'),
(7, 'Adopcion del estandar OGC', FALSE, 4, 'Servicio'),
(7, 'Excepciones en formato OGC', FALSE, 1, 'Servicio'),
(7, 'Estilo de capas en formato SLD', FALSE, 1, 'Servicio'),
(8, 'Capas del servicio con CRS adecuado (IDEuy)', FALSE, 2, 'Servicio'),
(9, 'Soporta imagen simplificada', FALSE, 1, 'Método'),
(9, 'Soporta imagen vacia', FALSE, 1, 'Método'),
(10, 'Formato PNG', FALSE, 1, 'Método'),
(10, 'Formato KML', FALSE, 1, 'Método'),
(10, 'Formato text/html metodo getFeatureInfo', FALSE, 1, 'Método'),
(10, 'Formato Excepcion application/vnd.ogc.se_inimage', FALSE, 1, 'Método'),
(10, 'Formato Excepcion application/vnd.ogc.se_blank', FALSE, 1, 'Método'),
(10, 'Cantidad de formatos soportados', FALSE, 5, 'Servicio'),
(10, 'Cantidad de formatos de excepciones soportadas', FALSE, 5, 'Servicio'),
(11, 'Contiene servicio CSW', FALSE, 1, 'Institución'),
(12, 'Fecha del dato', FALSE, 2, 'Institución'),
(13, 'Leyenda de la Capa', FALSE, 2, 'Servicio'),
(13, 'Especifica Rango Util', FALSE, 1, 'Capa'),
(14, 'Errores descriptivos', FALSE, 1, 'Servicio');

INSERT INTO Ide (Name, Description) VALUES
('ide.uy','Infraestructura de Datos Espaciales del Uruguay');

INSERT INTO Institution (IdeID, Name, Description) VALUES
(1, 'Presidencia', 'Presidencia de la República'),
(1, 'Ministerio de Defensa Nacional', 'Ministerio de Defensa Nacional'),
(1, 'MIDES', 'Ministerio de Desarrollo Social'),
(1, 'Ministerio de Economía y Finanzas', 'Ministerio de Economía y Finanzas'),
(1, 'MEC', 'Ministerio de Educación y Cultura'),
(1, 'Ministerio de Ganadería, Agricultura y Pesca', 'Ministerio de Ganadería, Agricultura y Pesca'),
(1, 'MIEM', 'Ministerio de Industria, Energía y Minería'),
(1, 'MTOP', 'Ministerio de Transporte y Obras Públicas'),
(1, 'Ministerio de Turismo', 'Ministerio de Turismo'),
(1, 'Ministerio de Vivienda, Ordenamiento Territorial y Medio Ambiente', 'Ministerio de Vivienda, Ordenamiento Territorial y Medio Ambiente'),
(1, 'ANEP', 'Administración Nacional de Educación Pública'),
(1, 'Correo Uruguayo', 'Administración Nacional de Correos'),
(1, 'INIA', 'Instituto Nacional de Investigación Agropecuaria'),
(1, 'Maldonado', 'Intendencia de Maldonado'),
(1, 'Montevideo', 'Intendencia de Montevideo'),
(1, 'Rivera', 'Intendencia de Rivera');

INSERT INTO Node (InstitutionID, Name, Description) VALUES
(1, 'INE', 'Instituto Nacional de Estadística'),
(1, 'SINAE', 'Sistema Nacional de Emergencia'),
(1, 'UNASEV', 'Unidad de Seguridad Vial'),
(2, 'Servicio Geográfico Militar', 'Servicio Geográfico Militar'),
(3, 'MIDES', 'Ministerio de Desarrollo Social'),
(4, 'DNC', 'Dirección Nacional de Catastro'),
(5, 'MEC', 'Ministerio de Educación y Cultura'),
(6, 'RENARE', 'Dirección Nacional de Recursos Renovables'),
(7, 'Dirección Nacional de Minería y Geología', 'Dirección Nacional de Minería y Geología'),
(8, 'Dirección Nacional de Topografía', 'Direción Nacional de Topografía'),
(9, 'Ministerio de Turismo', 'Ministerio de Turismo'),
(10, 'DINAMA', 'Dirección Nacional de Medio Ambiente'),
(10, 'DINOT', 'Dirección Nacional de Ordenamiento Territorial'),
(11, 'ANEP', 'Administración Nacional de Educación Pública'),
(12, 'Unidad de Geomáica', 'Unidad de Geomáica'),
(13, 'GRAS', 'GRAS'),
(14, 'Unidad del Sistema de Información Geográfica', 'Unidad del Sistema de Información Geográfica'),
(15, 'Servicio de Geomática', 'Servicio de Geomática'),
(16, 'Rivera', 'Intendencia de Rivera');

--INSERT INTO Layer (NodeID, Name, Url) VALUES
--(1, 'Capa de calles', 'http://CapaCalles1.1.1.1'),
--(2, 'Capa edificios', 'http://CapaEdificios1.1.1.2');

--ide.uy/Ministerio de Transporte y Obras Públicas/ Dirección Nacional de Topografía
INSERT INTO GeographicServices (NodeID, Url, GeographicServicesType) VALUES
(10,'http://geoservicios.mtop.gub.uy/geoserver/inf_tte_ttelog_logistica/wms?service=WMS&version=1.3.0&request=GetCapabilities','WMS'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/inf_tte_ttelog_logistica/ows?service=WFS&version=1.3.0&request=GetCapabilities','WFS'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/inf_tte_ttelog_terrestre/wms?service=WMS&version=1.3.0&request=GetCapabilities','WMS'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/inf_tte_ttelog_terrestre/ows?service=WFS&version=1.3.0&request=GetCapabilities','WFS'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/inf_tte_ttelog_fluvial/wms?service=WMS&version=1.3.0&request=GetCapabilities','WMS'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/inf_tte_ttelog_fluvial/ows?service=WFS&version=1.3.0&request=GetCapabilities','WFS'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/inf_tte_ttelog_ferroviario/wms?service=WMS&version=1.3.0&request=GetCapabilities','WMS'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/inf_tte_ttelog_ferroviario/ows?service=WFS&version=1.3.0&request=GetCapabilities','WFS'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/inf_tte_ttelog_aereo/wms?service=WMS&version=1.3.0&request=GetCapabilities','WMS'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/inf_tte_ttelog_aereo/ows?service=WFS&version=1.3.0&request=GetCapabilities','WFS'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/inf_tte_ttelog_otros/wms?service=WMS&version=1.3.0&request=GetCapabilities','WMS'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/inf_tte_ttelog_otros/ows?service=WFS&version=1.3.0&request=GetCapabilities','WFS'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/relevamiento_transito/wms?service=WMS&version=1.3.0&request=GetCapabilities','WMS'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/relevamiento_transito/ows?service=WFS&version=1.3.0&request=GetCapabilities','WFS'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/inf_soc_comunitaria/wms?service=WMS&version=1.3.0&request=GetCapabilities','WMS'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/inf_soc_comunitaria/ows?service=WFS&version=1.3.0&request=GetCapabilities','WFS'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/acc_intern_cosiplan/wms?service=WMS&version=1.3.0&request=GetCapabilities','WMS'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/acc_intern_cosiplan/ows?service=WFS&version=1.3.0&request=GetCapabilities','WFS'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/rec_hidrograficos/wms?service=WMS&version=1.3.0&request=GetCapabilities','WMS'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/rec_hidrograficos/ows?service=WFS&version=1.3.0&request=GetCapabilities','WFS'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/planos_publicar/wms?service=WMS&version=1.3.0&request=GetCapabilities','WMS'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/planos_publicar/ows?service=WFS&version=1.3.0&request=GetCapabilities','WFS'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/mb_hervidero/wms?service=WMS&version=1.3.0&request=GetCapabilities','WMS'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/mb_hervidero/ows?service=WFS&version=1.3.0&request=GetCapabilities','WFS'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/mb_sayago/wms?service=WMS&version=1.3.0&request=GetCapabilities','WMS'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/mb_sayago/ows?service=WFS&version=1.3.0&request=GetCapabilities','WFS'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/mb_pap/wms?service=WMS&version=1.3.0&request=GetCapabilities','WMS'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/mb_pap/ows?service=WFS&version=1.3.0&request=GetCapabilities','WFS'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/mb_piria/wms?service=WMS&version=1.3.0&request=GetCapabilities','WMS'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/mb_piria/ows?service=WFS&version=1.3.0&request=GetCapabilities','WFS'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/rutas_SD/ows?service=WFS&version=1.3.0&request=GetCapabilities','WFS');

INSERT INTO SystemUser (Email, Password, UserGroupID, FirstName, LastName, PhoneNumber, InstitutionID) VALUES 
('ncalle@mail.com', 'ncalle', 1, 'Natalia', 'Calle', '098765432', 1),
('rsanchez@mail.com', 'rsanchez', 1, 'Ramiro', 'Sanchez', '098961259', 1);