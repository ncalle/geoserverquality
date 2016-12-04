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
