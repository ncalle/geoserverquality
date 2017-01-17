INSERT INTO Grupo (Nombre, Descripcion) VALUES
('Administrador Tecnico','Usuario administrador que tiene completo acceso a todas las funcionalidades.'),
('Administrador General','Usuario con el fin de realizar gestion y cuidado de la herramienta.'),
('Administrador IDE','Usuario que tiene como cometido realizar evaluaciones sobre IDEs.'),
('Administrador Institucional','Usuario que tiene como cometido realizar evaluaciones sobre Instituciones.');

-- Permiso
INSERT INTO Permiso (Nombre, Descripcion) VALUES
('Alta de Usuario','Alta de Usuario'),
('Baja de Usuario','Baja de Usuario'),
('Modificacion de Usuario','Modificacion de Usuario'),
('Alta de Perfil','Alta de Perfil de evaluacion'),
('Baja de Perfil','Baja de Perfil de evaluacion'),
('Modificacion de Perfil','Modificacion de Perfil de evaluacion'),
('Alta de objeto medible','Alta de objetos medibles'),
('Baja de objeto medible','Baja de objetos medibles'),
('Modificacion de objeto medible','Modificacion de objetos medibles'),
('Evaluacion de objeto medible','Evaluacion de objetos medibles');

INSERT INTO PermisoGrupo (PermisoID, GrupoID)
SELECT p.PermisoID, 1 -- Tecnico
FROM Permiso p
UNION
SELECT p.PermisoID, 2 -- General
FROM Permiso p
WHERE p.PermisoID IN (10) --Evaluacion
UNION
SELECT p.PermisoID, 3 -- IDE
FROM Permiso p
WHERE p.PermisoID IN (10) --Evaluacion
UNION
SELECT p.PermisoID, 4 -- Institucion
FROM Permiso p
WHERE p.PermisoID IN (11); --Evaluacion

INSERT INTO Modelo (Nombre) VALUES
('ModeloIDEuy');

INSERT INTO Dimension (ModeloID, Nombre) VALUES
(1, 'Seguridad'),
(1, 'Confiabilidad'),
(1, 'Rendimiento'),
(1, 'Interoperabilidad'),
(1, 'Publicacion de Datos'),
(1, 'Metadatos'),
(1, 'Usabilidad');

INSERT INTO Factor (DimensionID, Nombre) VALUES
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

INSERT INTO Unidad (Nombre, Descripcion) VALUES 
('Boleano',''),
('Porcentaje',''),
('Milisegundos',''),
('Basico-Intermedio-Completo',''),
('Entero','');

INSERT INTO Metrica (FactorID, Nombre, AgregacionFlag, UnidadID, Granuralidad) VALUES
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

INSERT INTO Usuario (Email, UsuarioPassword, GrupoID, Nombre, Apellido, Telefono, InstitucionID) VALUES 
('adminTecnico@mail.com', 'admint', 1, 'NombreAdmint', 'ApellidoAdmint', '098715432', NULL);

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
