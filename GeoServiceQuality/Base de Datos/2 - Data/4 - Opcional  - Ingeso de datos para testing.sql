﻿INSERT INTO Ide (Name, Description) VALUES
('Ide1','desc ide 1'),
('Ide2','desc ide 2'),
('Ide3','desc ide 3');

INSERT INTO Institution (IdeID, Name, Description) VALUES
(1, 'Ins1.1', 'desc Ins1.1'),
(2, 'Ins1.2', 'desc Ins1.2'),
(2, 'Ins2.2', 'desc Ins2.2'),
(3, 'Ins1.3', 'desc Ins1.3'),
(3, 'Ins2.3', 'desc Ins2.3'),
(3, 'Ins3.3', 'desc Ins3.3');

INSERT INTO Node (InstitutionID, Name, Description) VALUES
(1, 'Nodo1.1.1', 'desc Nodo1.1.1'),
(2, 'Nodo1.1.2', 'desc Nodo1.1.2'),
(3, 'Nodo1.2.2', 'desc Nodo1.2.2'),
(4, 'Nodo1.1.3', 'desc Nodo1.1.3'),
(5, 'Nodo1.2.3', 'desc Nodo1.2.3'),
(6, 'Nodo1.3.3', 'desc Nodo1.3.3');

INSERT INTO Layer (NodeID, Name, Url) VALUES
(1, 'Capa de calles', 'http://CapaCalles1.1.1.1'),
(2, 'Capa edificios', 'http://CapaEdificios1.1.1.2');

INSERT INTO GeographicServices (NodeID, Url, GeographicServicesType) VALUES
(1, 'http://Servicio1.1.1.1', 'WMS'),
(2, 'http://Servicio1.1.1.2', 'WFS'),
(3, 'http://Servicio1.1.2.2', 'CSW'),
(4, 'http://Servicio1.1.1.3', 'WMS'),
(5, 'http://Servicio1.1.2.3', 'WFS'),
(6, 'http://Servicio1.1.3.3', 'CSW');

INSERT INTO SystemUser (Email, Password, UserGroupID, FirstName, LastName, PhoneNumber, InstitutionID) VALUES 
('tecnico1@mail.com', 'tecnico1', 1, 'Natalia', 'Calle', '098765432', NULL),
('tecnico2@mail.com', 'tecnico2', 1, 'Ramiro', 'Sanchez', '098961259', NULL),
('general1@mail.com', 'general1', 2, 'Micaela', 'Gomez', '099336253', NULL),
('general2@mail.com', 'general2', 2, 'Celso', 'Rodriguez', '099532253', NULL),
('ide1@mail.com', 'ide1', 3, 'Carlos', 'Gutierrez', '098962253', NULL),
('ide2@mail.com', 'ide2', 3, 'Juan', 'Alamo', '098332253', NULL),
('institucional1@mail.com', 'institucional1', 4, 'Luciana', 'Ilenfeld', '091332253', 1),
('institucional2@mail.com', 'institucional2', 4, 'Javier', 'Rodriguez', '099332253', 2);

INSERT INTO UserMeasurableObject (UserID, MeasurableObjectID, MeasurableObjectType, CanMeasureFlag)
SELECT 1, ide.IdeID, 'Ide', TRUE
FROM Ide ide;

INSERT INTO UserMeasurableObject (UserID, MeasurableObjectID, MeasurableObjectType, CanMeasureFlag)
SELECT 1, ins.InstitutionID, 'Institución', TRUE
FROM Institution ins;

INSERT INTO UserMeasurableObject (UserID, MeasurableObjectID, MeasurableObjectType, CanMeasureFlag)
SELECT 1, n.NodeID, 'Nodo', TRUE
FROM Node n;

INSERT INTO UserMeasurableObject (UserID, MeasurableObjectID, MeasurableObjectType, CanMeasureFlag)
SELECT 1, sg.GeographicServicesID, 'Servicio', TRUE
FROM GeographicServices sg;
