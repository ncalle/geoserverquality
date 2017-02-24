INSERT INTO SystemUser (Email, Password, UserGroupID, FirstName, LastName, PhoneNumber, InstitutionID) VALUES 
('tecnico1@mail.com', 'tecnico1', 1, 'Natalia', 'Calle', '098765432', 2),
('tecnico2@mail.com', 'tecnico2', 1, 'Ramiro', 'Sanchez', '098961259', 3),
('general1@mail.com', 'general1', 2, 'Micaela', 'Gomez', '099336253', 4),
('general2@mail.com', 'general2', 2, 'Celso', 'Rodriguez', '099532253', 5),
('ide1@mail.com', 'ide1', 3, 'Carlos', 'Gutierrez', '098962253', 6),
('ide2@mail.com', 'ide2', 3, 'Juan', 'Alamo', '098332253', 1),
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

INSERT INTO GeographicServices (NodeID, Url, GeographicServicesType) VALUES
(6, 'http://Servicio1.1.3.4', 'CSW');

INSERT INTO UserMeasurableObject (UserID, MeasurableObjectID, MeasurableObjectType, CanMeasureFlag)
SELECT 1, 7, 'Servicio', FALSE;


INSERT INTO UserMeasurableObject (UserID, MeasurableObjectID, MeasurableObjectType, CanMeasureFlag)
SELECT 2, ide.IdeID, 'Ide', FALSE
FROM Ide ide;

INSERT INTO UserMeasurableObject (UserID, MeasurableObjectID, MeasurableObjectType, CanMeasureFlag)
SELECT 2, ins.InstitutionID, 'Institución', FALSE
FROM Institution ins;

INSERT INTO UserMeasurableObject (UserID, MeasurableObjectID, MeasurableObjectType, CanMeasureFlag)
SELECT 2, n.NodeID, 'Nodo', FALSE
FROM Node n;

INSERT INTO UserMeasurableObject (UserID, MeasurableObjectID, MeasurableObjectType, CanMeasureFlag)
SELECT 2, sg.GeographicServicesID, 'Servicio', FALSE
FROM GeographicServices sg;