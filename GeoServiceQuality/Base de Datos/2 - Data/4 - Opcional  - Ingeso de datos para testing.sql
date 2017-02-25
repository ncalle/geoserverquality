INSERT INTO SystemUser (Email, Password, UserGroupID, FirstName, LastName, PhoneNumber, InstitutionID) VALUES 
('mgomez@mail.com', 'mgomez', 2, 'Micaela', 'Gomez', '099336253', 1),
('crodriguez@mail.com', 'crodriguez', 2, 'Celso', 'Rodriguez', '099532253', 1),
('cgutierrez@mail.com', 'cgutierrez', 3, 'Carlos', 'Gutierrez', '098962253', 1),
('jalamo@mail.com', 'jalamo', 3, 'Juan', 'Alamo', '098332253', 1),
('lilenfeld@mail.com', 'lilenfeld', 4, 'Luciana', 'Ilenfeld', '091332253', 1),
('jrodriguez@mail.com', 'jrodriguez', 4, 'Javier', 'Rodriguez', '099332253', 1),
('lsimaldone@mail.com', 'lsimaldone', 4, 'Luciano', 'Simaldone', '098715432', 1);

--Dar permisos de evaluación sobre todos los objetos medible existentes a los usuarios ncalle y rsanchez
INSERT INTO UserMeasurableObject (UserID, MeasurableObjectID, MeasurableObjectType, CanMeasureFlag)
SELECT u.UserID, ide.IdeID, 'Ide', TRUE
FROM Ide ide
CROSS JOIN 
   (
      SELECT su.UserID
      FROM SystemUser su
      WHERE su.UserID IN (1,2)
   ) u;

INSERT INTO UserMeasurableObject (UserID, MeasurableObjectID, MeasurableObjectType, CanMeasureFlag)
SELECT u.UserID, ins.InstitutionID, 'Institución', TRUE
FROM Institution ins
CROSS JOIN 
   (
      SELECT su.UserID
      FROM SystemUser su
      WHERE su.UserID IN (1,2)
   ) u;

INSERT INTO UserMeasurableObject (UserID, MeasurableObjectID, MeasurableObjectType, CanMeasureFlag)
SELECT u.UserID, n.NodeID, 'Nodo', TRUE
FROM Node n
CROSS JOIN 
   (
      SELECT su.UserID
      FROM SystemUser su
      WHERE su.UserID IN (1,2)
   ) u;

INSERT INTO UserMeasurableObject (UserID, MeasurableObjectID, MeasurableObjectType, CanMeasureFlag)
SELECT u.UserID, sg.GeographicServicesID, 'Servicio', TRUE
FROM GeographicServices sg
CROSS JOIN 
   (
      SELECT su.UserID
      FROM SystemUser su
      WHERE su.UserID IN (1,2)
   ) u;

--Negar permisos de evaluación sobre todos los objetos medible existentes a los usuarios que no sean ncalle o rsanchez
INSERT INTO UserMeasurableObject (UserID, MeasurableObjectID, MeasurableObjectType, CanMeasureFlag)
SELECT u.UserID, ide.IdeID, 'Ide', FALSE
FROM Ide ide
CROSS JOIN 
   (
      SELECT su.UserID
      FROM SystemUser su
      WHERE su.UserID NOT IN (1,2)
   ) u;

INSERT INTO UserMeasurableObject (UserID, MeasurableObjectID, MeasurableObjectType, CanMeasureFlag)
SELECT u.UserID, ins.InstitutionID, 'Institución', FALSE
FROM Institution ins
CROSS JOIN 
   (
      SELECT su.UserID
      FROM SystemUser su
      WHERE su.UserID NOT IN (1,2)
   ) u;

INSERT INTO UserMeasurableObject (UserID, MeasurableObjectID, MeasurableObjectType, CanMeasureFlag)
SELECT u.UserID, n.NodeID, 'Nodo', FALSE
FROM Node n
CROSS JOIN 
   (
      SELECT su.UserID
      FROM SystemUser su
      WHERE su.UserID NOT IN (1,2)
   ) u;

INSERT INTO UserMeasurableObject (UserID, MeasurableObjectID, MeasurableObjectType, CanMeasureFlag)
SELECT u.UserID, sg.GeographicServicesID, 'Servicio', FALSE
FROM GeographicServices sg
CROSS JOIN 
   (
      SELECT su.UserID
      FROM SystemUser su
      WHERE su.UserID NOT IN (1,2)
   ) u;
