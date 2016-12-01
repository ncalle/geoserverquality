INSERT INTO GeoServiceQuality.Usuario (Email, UsuarioPassword, Tipo, Nombre, Apellido, Telefono) VALUES 
('tecnico1@mail.com', 'tecnico1', 'TC', 'Natalia', 'Calle', '098765432'),
('tecnico2@mail.com', 'tecnico2', 'TC', 'Ramiro', 'Sanchez', '098961259'),
('ide1@mail.com', 'ide1', 'ID', 'Carlos', 'Gutierrez', '098962253'),
('ide2@mail.com', 'ide2', 'ID', 'Juan', 'Alamo', '098332253'),
('institucional1@mail.com', 'institucional1', 'IN', 'Luciana', 'Ilenfeld', '091332253'),
('institucional2@mail.com', 'institucional2', 'IN', 'Javier', 'Rodriguez', '099332253'),
('general1@mail.com', 'general1', 'GR', 'Micaela', 'Gomez', '099336253'),
('general2@mail.com', 'general2', 'GR', 'Celso', 'Rodriguez', '099532253');

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
(7, 'Adopción del estandar OGC', 4),
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

-- UsuarioIdeInstitucion
-- Ide
-- Institucion
-- Nodo
-- ServicioGeografico
-- Perfil
-- PerfilMetrica
-- PerfilUsuario
-- Ponderacion
-- Evaluacion
-- EvaluacionParcial
