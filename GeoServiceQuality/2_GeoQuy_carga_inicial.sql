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

-- cambiar grupoid por tipo
INSERT INTO GeoServiceQuality.Usuario (Email, UsuarioPassword, GrupoID, Nombre, Apellido, Telefono) VALUES 
('tecnico1@mail.com', 'tecnico1', 1, 'Natalia', 'Calle', '098765432'),
('tecnico2@mail.com', 'tecnico2', 1, 'Ramiro', 'Sanchez', '098961259'),
('general1@mail.com', 'general1', 2, 'Micaela', 'Gomez', '099336253'),
('general2@mail.com', 'general2', 2, 'Celso', 'Rodriguez', '099532253'),
('ide1@mail.com', 'ide1', 3, 'Carlos', 'Gutierrez', '098962253'),
('ide2@mail.com', 'ide2', 3, 'Juan', 'Alamo', '098332253'),
('institucional1@mail.com', 'institucional1', 4, 'Luciana', 'Ilenfeld', '091332253'),
('institucional2@mail.com', 'institucional2', 4, 'Javier', 'Rodriguez', '099332253');

INSERT INTO GeoServiceQuality.Ide (Nombre, Descripcion) VALUES
('Ide1','desc ide 1'),
('Ide2','desc ide 2'),
('Ide3','desc ide 3');

INSERT INTO GeoServiceQuality.Institucion (IdeID, Nombre, Descripcion) VALUES
(1, 'Ins1.1', 'desc Ins1.1'),
(2, 'Ins2.1', 'desc Ins2.1'),
(2, 'Ins2.2', 'desc Ins2.2'),
(3, 'Ins3.1', 'desc Ins3.1'),
(3, 'Ins3.2', 'desc Ins3.2'),
(3, 'Ins3.3', 'desc Ins3.3');

INSERT INTO GeoServiceQuality.Nodo (InstitucionID, Nombre, Descripcion) VALUES
(1, 'Nodo1.1', 'desc Nodo1.1'),
(2, 'Nodo2.1', 'desc Nodo2.1'),
(3, 'Nodo3.1', 'desc Nodo3.1'),
(4, 'Nodo4.1', 'desc Nodo4.1'),
(5, 'Nodo5.1', 'desc Nodo5.1'),
(6, 'Nodo6.1', 'desc Nodo6.1');

INSERT INTO GeoServiceQuality.ServicioGeografico (NodoID, Url, Tipo) VALUES
(1, 'http://Servicio1.1', 'WMS'),
(2, 'http://Servicio2.1', 'WFS'),
(3, 'http://Servicio3.1', 'CSW'),
(4, 'http://Servicio4.1', 'WMS'),
(5, 'http://Servicio5.1', 'WFS'),
(6, 'http://Servicio6.1', 'CSW');

INSERT INTO GeoServiceQuality.UsuarioObjeto (UsuarioID, ObjetoID, Tipo, PuedeEvaluarFlag)
SELECT 1, ide.IdeID, 'Ide', 1
FROM GeoServiceQuality.Ide ide;

INSERT INTO GeoServiceQuality.UsuarioObjeto (UsuarioID, ObjetoID, Tipo, PuedeEvaluarFlag)
SELECT 1, institucion.InstitucionID, 'Ins', 1
FROM GeoServiceQuality.Institucion institucion

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
