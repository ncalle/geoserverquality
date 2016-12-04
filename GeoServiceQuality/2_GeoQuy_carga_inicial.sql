INSERT INTO GeoServiceQuality.Grupo (Nombre, Descripcion) VALUES
('Administrador Tecnico','Usuario administrador que tiene completo acceso a todas las funcionalidades.'),
('Administrador General','Usuario con el fin de realizar gestion y cuidado de la herramienta.'),
('Administrador IDE','Usuario que tiene como cometido realizar evaluaciones sobre IDEs.'),
('Administrador Institucional','Usuario que tiene como cometido realizar evaluaciones sobre Instituciones.');

-- Permiso
INSERT INTO GeoServiceQuality.Permiso (Nombre, Descripcion) VALUES
('Alta de Usuario','Alta de Usuario'),
('Baja de Usuario','Baja de Usuario'),
('Modificacion de Usuario','Modificacion de Usuario'),
('Alta de Perfil','Alta de Perfil de evaluacion'),
('Baja de Perfil','Baja de Perfil de evaluacion'),
('Modificacion de Perfil','Modificacion de Perfil de evaluacion'),
('Alta de IDE','Alta de Infraestructura de datos espaciales'),
('Baja de IDE','Baja de Infraestructura de datos espaciales'),
('Modificacion de IDE','Modificacion de Infraestructura de datos espaciales'),
('Evaluacion de IDE','Evaluacion de Infraestructura de datos espaciales'),
('Evaluacion de Institucion','Evaluacion de Institucion'),
('Evaluacion de Nodo','Evaluacion de Nodo'),
('Evaluacion de Servicio Geografico','Evaluacion de Servicio Geografico');

INSERT INTO GeoServiceQuality.PermisoGrupo (PermisoID, GrupoID)
SELECT p.PermisoID, 1 -- Tecnico
FROM GeoServiceQuality.Permiso p
UNION
SELECT p.PermisoID, 2 -- General
FROM GeoServiceQuality.Permiso p
WHERE p.PermisoID IN (10, 11, 12, 13)
UNION
SELECT p.PermisoID, 3 -- IDE
FROM GeoServiceQuality.Permiso p
WHERE p.PermisoID IN (10, 11, 12, 13)
UNION
SELECT p.PermisoID, 4 -- Institucion
FROM GeoServiceQuality.Permiso p
WHERE p.PermisoID IN (11, 12, 13);

INSERT INTO GeoServiceQuality.Dimension (Nombre) VALUES
('Seguridad'),
('Confiabilidad'),
('Rendimiento'),
('Interoperabilidad'),
('Publicacion de Datos'),
('Metadatos'),
('Usabilidad');

INSERT INTO GeoServiceQuality.Factor (DimensionID, Nombre) VALUES
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

INSERT INTO GeoServiceQuality.Unidad (Nombre, Descripcion) VALUES 
('Boleano',''),
('Porcentaje',''),
('Milisegundos',''),
('Basico-Intermedio-Completo',''),
('Entero','');

INSERT INTO GeoServiceQuality.Metrica (FactorID, Nombre, UnidadID) VALUES
(1, 'Integridad de datos', 1),
(2, 'Informacion en excepciones', 1),
(3, 'Disponibilidad diaria del servicio', 2),
(4, 'Tolerancia a parametros nulos', 1),
(4, 'Tolerancia a parametros largos', 1),
(5, 'Promedio tiempo de respuesta diario', 3),
(6, 'Tope Maximo de Objetos', 1),
(7, 'Adopcion del estandar OGC', 4),
(7, 'Excepciones en formato OGC', 1),
(7, 'Estilo de capas en formato SLD', 1),
(8, 'Capas del servicio con CRS adecuado (IDEuy)', 2),
(9, 'Soporta imagen simplificada', 1),
(9, 'Soporta imagen vacia', 1),
(10, 'Formato PNG', 1),
(10, 'Formato KML', 1),
(10, 'Formato text/html metodo getFeatureInfo', 1),
(10, 'Formato Excepcion application/vnd.ogc.se_inimage' ,1),
(10, 'Formato Excepcion application/vnd.ogc.se_blank', 1),
(10, 'Cantidad de formatos soportados', 5),
(10, 'Cantidad de formatos de excepciones soportadas', 5),
(11, 'Contiene servicio CSW', 1),
(12, 'Fecha del dato', 2),
(13, 'Leyenda de la Capa', 2),
(13, 'Especifica Rango Util', 1),
(14, 'Errores descriptivos', 1);

INSERT INTO GeoServiceQuality.Usuario (Email, UsuarioPassword, GrupoID, Nombre, Apellido, Telefono) VALUES 
('adminTecnico@mail.com', 'admint', 1, 'NombreAdmint', 'ApellidoAdmint', '098715432');

-- UsuarioObjeto
-- Ide
-- Institucion
-- Nodo
-- ServicioGeografico
-- Perfil
-- Rango
-- Ponderacion
-- Evaluacion
-- EvaluacionParcial
