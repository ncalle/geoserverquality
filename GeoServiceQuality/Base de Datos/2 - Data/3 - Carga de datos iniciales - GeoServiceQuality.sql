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
(2, 'Informacion en excepciones', FALSE, 1, 'Servicio'),
(7, 'Excepciones en formato OGC', FALSE, 1, 'Servicio'),
(8, 'Capas del servicio con CRS adecuado (IDEuy)', FALSE, 2, 'Servicio'),
(10, 'Formato PNG', FALSE, 1, 'Método'),
(10, 'Formato KML', FALSE, 1, 'Método'),
(10, 'Formato text/html metodo getFeatureInfo', FALSE, 1, 'Método'),
(10, 'Formato Excepcion application/vnd.ogc.se_inimage', FALSE, 1, 'Método'),
(10, 'Formato Excepcion application/vnd.ogc.se_blank', FALSE, 1, 'Método'),
(10, 'Cantidad de formatos soportados', FALSE, 5, 'Servicio'),
(10, 'Cantidad de formatos de excepciones soportadas', FALSE, 5, 'Servicio'),
(13, 'Leyenda de la Capa', FALSE, 2, 'Servicio'),
(13, 'Especifica Rango Util', FALSE, 1, 'Capa');
--(14, 'Errores descriptivos', FALSE, 1, 'Servicio');
--(3, 'Disponibilidad diaria del servicio', FALSE, 2, 'Servicio'),
--(4, 'Tolerancia a parametros nulos', FALSE, 1, 'Método'),
--(4, 'Tolerancia a parametros largos', FALSE, 1, 'Método'),
--(5, 'Promedio tiempo de respuesta diario', FALSE, 3, 'Método'),
--(7, 'Adopcion del estandar OGC', FALSE, 4, 'Servicio'),
--(1, 'Integridad de datos', FALSE, 1, 'Nodo'),
--(11, 'Contiene servicio CSW', FALSE, 1, 'Institución'),
--(12, 'Fecha del dato', FALSE, 2, 'Institución'),

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


INSERT INTO Profile (ProfileID, Name, Granurality, IsWeightedFlag) VALUES
(0, 'Perfil 1', 'Servicio', FALSE);

INSERT INTO MetricRange (MetricID, ProfileID, BooleanFlag, BooleanAcceptanceValue, PercentageFlag, PercentageAcceptanceValue, IntegerFlag, IntegerAcceptanceValue, EnumerateFlag, EnumerateAcceptanceValue) VALUES
(1, 0, TRUE, TRUE, FALSE, NULL, FALSE, NULL, FALSE, NULL);

--INSERT INTO Layer (NodeID, Name, Url) VALUES
--(1, 'Capa de calles', 'http://CapaCalles1.1.1.1'),
--(2, 'Capa edificios', 'http://CapaEdificios1.1.1.2');

--ide.uy/Presidencia de la República/Unidad de Seguridad Vial
   --http://aplicaciones.unasev.gub.uy/mapas/Descarga/Descarga
INSERT INTO GeographicServices (NodeID, Url, GeographicServicesType, Description) VALUES
(3,'http://gissrv.unasev.gub.uy/arcgis/services/UNASEV/srvUNASEVWFS/MapServer/WFSServer','WFS', 'Siniestros Fatales'),
(3,'http://gissrv.unasev.gub.uy/arcgis/services/UNASEV/srvUNASEVWFS/MapServer/WMSServer','WMS', 'Siniestros Fatales');

--ide.uy/Ministerio de Defensa Nacional/Servicio Geográfico Militar
   --http://www.sgm.gub.uy/geoportal/index.php/geoservicios/listado-de-servicios
INSERT INTO GeographicServices (NodeID, Url, GeographicServicesType, Description) VALUES
(4,'http://geoservicios.sgm.gub.uy/UYAR.cgi?','WMS', 'Artigas - Artigas'),
(4,'http://geoservicios.sgm.gub.uy/DPTO_UYAR.cgi?','WMS', 'Artigas - Otros'),
(4,'http://geoservicios.sgm.gub.uy/UYCA.cgi?','WMS', 'Canelones - Canelones'),
(4,'http://geoservicios.sgm.gub.uy/DPTO_UYCA.cgi?','WMS', 'Canelones - Otros'),
(4,'http://geoservicios.sgm.gub.uy/UYCL.cgi?','WMS', 'Cerro Largo - Melo'),
(4,'http://geoservicios.sgm.gub.uy/DPTO_UYCL.cgi?','WMS', 'Cerro Largo - Otros'),
(4,'http://geoservicios.sgm.gub.uy/UY_Landsat.cgi?','WMS', 'Cobertura Nacional - Mosaico de imagenes'),
(4,'http://geoservicios.sgm.gub.uy/SGMVectorial.cgi?','WMS', 'Cobertura Nacional'),
(4,'http://geoservicios.sgm.gub.uy/SGMRaster.cgi?','WMS', 'Cobertura Nacional - PCN50'),
(4,'http://geoservicios.sgm.gub.uy/wfsPCN1000.cgi?','WFS', 'Cobertura Nacional'),
(4,'http://geoservicios.sgm.gub.uy/UYCO.cgi?','WMS', 'Colonia - Colonia del Sacramento'),
(4,'http://geoservicios.sgm.gub.uy/PCN25_N27a.cgi?','WMS', 'Colonia - Boca del Rosario'),
(4,'http://geoservicios.sgm.gub.uy/DPTO_UYCO.cgi?','WMS', 'Colonia - Otros'),
(4,'http://geoservicios.sgm.gub.uy/UYDU.cgi?','WMS', 'Durazno - Durazno'),
(4,'http://geoservicios.sgm.gub.uy/DPTO_UYDU.cgi?','WMS', 'Durazno - Otros'),
(4,'http://geoservicios.sgm.gub.uy/UYFS.cgi?','WMS', 'Flores - Trinidad'),
(4,'http://geoservicios.sgm.gub.uy/UYFD.cgi?','WMS', 'Florida - Florida'),
(4,'http://geoservicios.sgm.gub.uy/DPTO_UYFD.cgi?','WMS', 'Florida - Otros'),
(4,'http://geoservicios.sgm.gub.uy/UYLA.cgi?','WMS', 'Lavalleja - Minas'),
(4,'http://geoservicios.sgm.gub.uy/DPTO_UYLA.cgi?','WMS', 'Lavalleja - Otros'),
(4,'http://geoservicios.sgm.gub.uy/UYMA.cgi?','WMS', 'Maldonado - Maldonado'),
(4,'http://geoservicios.sgm.gub.uy/DPYO_UYMA.cgi?','WMS', 'Maldonado - Otros'),
(4,'http://geoservicios.sgm.gub.uy/UYPA.cgi?','WMS', 'Paysandú - Paysandú'),
(4,'http://geoservicios.sgm.gub.uy/DPTO_UYPA.cgi?','WMS', 'Paysandú - Otros'),
(4,'http://geoservicios.sgm.gub.uy/UYRV.cgi?','WMS', 'Rivera - Rivera'),
(4,'http://geoservicios.sgm.gub.uy/DPTO_UYRV.cgi?','WMS', 'Rivera - Otros'),
(4,'http://geoservicios.sgm.gub.uy/UYRO.cgi?','WMS', 'Rocha - Rocha'),
(4,'http://geoservicios.sgm.gub.uy/DPTO_UYRO.cgi?','WMS', 'Rocha - Otros'),
(4,'http://geoservicios.sgm.gub.uy/UYRN.cgi?','WMS', 'Río Negro - Fray Bentos'),
(4,'http://geoservicios.sgn.gub.uy/DPTO_UYRN.cgi?','WMS', 'Río Negro - Otros'),
(4,'http://geoservicios.sgm.gub.uy/UYSA.cgi?','WMS', 'Salto - Salto'),
(4,'http://geoservicios.sgm.gub.uy/DPTO_UYSA.cgi?','WMS', 'Salto - Otros'),
(4,'http://geoservicios.sgm.gub.uy/UYSJ.cgi?','WMS', 'San José - San José'),
(4,'http://geoservicios.sgm.gub.uy/DPTO_UYSJ.cgi?','WMS', 'San José - Otros'),
(4,'http://geoservicios.sgm.gub.uy/UYSO.cgi?','WMS', 'Soriano - Mercedes'),
(4,'http://geoservicios.sgm.gub.uy/DPYO_UYSO.cgi?','WMS', 'Soriano - Dolores'),
(4,'http://geoservicios.sgm.gub.uy/DPTO_UYSO.cgi?','WMS', 'Soriano - Otros'),
(4,'http://geoservicios.sgm.gub.uy/UYTA.cgi?','WMS', 'Tacuarembó - Tacuarembó'),
(4,'http://geoservicios.sgm.gub.uy/DPTO_UYTA.cgi?','WMS', 'Tacuarembó - Otros'),
(4,'http://geoservicios.sgm.gub.uy/UYTT.cgi?','WMS', 'Treinta y Tres - Treinta y Tres'),
(4,'http://geoservicios.sgm.gub.uy/DPTO_UYTT.cgi','WMS', 'Treinta y Tres - Otros');

--ide.uy/Ministerio de Economía y Finanzas/Dirección Nacional de Catastro
	--http://catastro.mef.gub.uy/12360/10/areas/geocatastro.html#wfs
INSERT INTO GeographicServices (NodeID, Url, GeographicServicesType, Description) VALUES
(6,'http://gis.catastro.gub.uy/arcgis/services/WFS/Artigas_WFS/MapServer/WFSServer','WFS', 'Artigas'),
(6,'http://gis.catastro.gub.uy/arcgis/services/WFS/Lavalleja_WFS/MapServer/WFSServer','WFS', 'Lavalleja'),
(6,'http://gis.catastro.gub.uy/arcgis/services/WFS/Canelones_WFS/MapServer/WFSServer','WFS', 'Canelones'),
(6,'http://gis.catastro.gub.uy/arcgis/services/WFS/Colonia_WFS/MapServer/WFSServer','WFS', 'Colonia'),
(6,'http://gis.catastro.gub.uy/arcgis/services/WFS/Flores_WFS/MapServer/WFSServer','WFS', 'Flores'),
(6,'http://gis.catastro.gub.uy/arcgis/services/WFS/Montevideo_WFS/MapServer/WFSServer','WFS', 'Montevideo'),
(6,'http://gis.catastro.gub.uy/arcgis/services/WFS/Maldonado_WFS/MapServer/WFSServer','WFS', 'Maldonado'),
(6,'http://gis.catastro.gub.uy/arcgis/services/WFS/Rocha_WFS/MapServer/WFSServer','WFS', 'Rocha'),
(6,'http://gis.catastro.gub.uy/arcgis/services/WFS/Soriano_WFS/MapServer/WFSServer','WFS', 'Soriano'),
(6,'http://gis.catastro.gub.uy/arcgis/services/WFS/Florida_WFS/MapServer/WFSServer','WFS', 'Florida'),
(6,'http://gis.catastro.gub.uy/arcgis/services/WFS/TreintayTres_WFS/MapServer/WFSServer','WFS', 'Treinta y Tres'),
(6,'http://gis.catastro.gub.uy/arcgis/services/WFS/Durazno_WFS/MapServer/WFSServer','WFS', 'Durazno'),
(6,'http://gis.catastro.gub.uy/arcgis/services/WFS/CerroLargo_WFS/MapServer/WFSServer','WFS', 'CerroLargo'),
(6,'http://gis.catastro.gub.uy/arcgis/services/WFS/Tacuarembo_WFS/MapServer/WFSServer','WFS', 'Tacuarembo'),
(6,'http://gis.catastro.gub.uy/arcgis/services/WFS/RioNegro_WFS/MapServer/WFSServer','WFS', 'Rio Negro'),
(6,'http://gis.catastro.gub.uy/arcgis/services/WFS/Rivera_WFS/MapServer/WFSServer','WFS', 'Rivera'),
(6,'http://gis.catastro.gub.uy/arcgis/services/WFS/Paysandu_WFS/MapServer/WFSServer','WFS', 'Paysandu'),
(6,'http://gis.catastro.gub.uy/arcgis/services/WFS/Salto_WFS/MapServer/WFSServer','WFS', 'Salto'),
(6,'http://gis.catastro.gub.uy/arcgis/services/WFS/SanJose_WFS/MapServer/WFSServer','WFS', 'SanJose');

--ide.uy/Ministerio de Ganadería, Agricultura y Pesca/Dirección Nacional de Recursos Renovables
    --http://www.cebra.com.uy/renare/visualizadores-graficos-y-consulta-de-mapas
INSERT INTO GeographicServices (NodeID, Url, GeographicServicesType, Description) VALUES
(8,'http://web.renare.gub.uy/arcgis/services/SUELOS/MOSAICO_FOTOPLANOS/MapServer/WMSServer','WMS', 'FOTOPLANOS'),
(8,'http://web.renare.gub.uy/arcgis/services/TEMATICOS/IntConeat/MapServer/WMSServer','WMS', 'Mapas interpretativos a partir de la Cartografia CONEAT'),
(8,'http://web.renare.gub.uy/arcgis/services/SUELOS/SUELOS/MapServer/WMSServer','WMS', 'Cartas de Suelos');

--ide.uy/Ministerio de Industria, Energía y Minería/Dirección Nacional de Minería y Geología
   --http://www.miem.gub.uy/web/mineria-y-geologia/sistema-de-informacion-geografica/-/asset_publisher/Kh0fSy8zj77G/content/sistema-de-informacion-geografica?redirect=http%3A//www.miem.gub.uy/web/mineria-y-geologia/sistema-de-informacion-geografica%3Fp_p_id%3D101_INSTANCE_Kh0fSy8zj77G%26p_p_lif
INSERT INTO GeographicServices (NodeID, Url, GeographicServicesType, Description) VALUES
(9,'http://visualizadorgeominero.dinamige.gub.uy:8080/arcgis/services/Dinamige_GeoS/CatastroMineroGeoS/MapServer/WMSServer?SERVICE=WMS&VERSION=1.3.0&REQUEST=GetCapabilities','WMS', 'Catastro Minero'),
(9,'http://visualizadorgeominero.dinamige.gub.uy:8080/arcgis/services/Dinamige_GeoS/CatastroMineroGeoS/MapServer/WFSServer?SERVICE=WFS&VERSION=1.3.0&REQUEST=GetCapabilities','WFS', 'Catastro Minero'),
--(9,'http://visualizadorgeominero.dinamige.gub.uy/shapefiles/CanteraObraPublica_Dinamige.zip','', 'Catastro Minero'),
--(9,'http://visualizadorgeominero.dinamige.gub.uy/shapefiles/ReservaMinera_Dinamige.zip','', 'Catastro Minero'),
--(9,'http://visualizadorgeominero.dinamige.gub.uy/shapefiles/Servidumbres_Dinamige.zip','', 'Catastro Minero'),
--(9,'http://visualizadorgeominero.dinamige.gub.uy/shapefiles/ZonasExclusion_Dinamige.zip','', 'Catastro Minero'),
--(9,'http://visualizadorgeominero.dinamige.gub.uy/shapefiles/PedimentosOtorgados_Dinamige.zip','', 'Catastro Minero'),
--(9,'http://visualizadorgeominero.dinamige.gub.uy/shapefiles/PedimentosTramite_Dinamige.zip','', 'Catastro Minero'),
(9,'http://visualizadorgeominero.dinamige.gub.uy:8080/arcgis/services/Dinamige_GeoS/HidrogeologiaGeoS/MapServer/WMSServer?SERVICE=WMS&VERSION=1.3.0&REQUEST=GetCapabilities','WMS', 'Hidrogeología'),
--(9,'http://visualizadorgeominero.dinamige.gub.uy/shapefiles/Pozos_Dinamige.zip','', 'Hidrogeología'),
(9,'http://visualizadorgeominero.dinamige.gub.uy:8080/arcgis/services/Dinamige_GeoS/MapaBaseUnidadesGeologicasGeoS/MapServer/WMSServer?SERVICE=WMS&VERSION=1.3.0&REQUEST=GetCapabilities','WMS', 'Mapa Geológico'),
(9,'http://visualizadorgeominero.dinamige.gub.uy:8080/arcgis/services/Dinamige_GeoS/GeolUnidadesGeologicas500000WFS/MapServer/WFSServer','WFS', 'Mapa Geológico'),
(9,'http://visualizadorgeominero.dinamige.gub.uy:8080/arcgis/services/Dinamige_GeoS/LaboratorioGeoS/MapServer/WMSServer?SERVICE=WMS&VERSION=1.3.0&REQUEST=GetCapabilities','WMS', 'Laboratorio'),
(9,'http://visualizadorgeominero.dinamige.gub.uy:8080/arcgis/services/Dinamige_GeoS/GeologiaGeoS/MapServer/WMSServer','WMS', 'Distritos Mineros'),
(9,'http://visualizadorgeominero.dinamige.gub.uy:8080/arcgis/services/Dinamige_GeoS/GeologiaGeoS/MapServer/WFSServer','WFS', 'Distritos Mineros');
--(9,'http://visualizadorgeominero.dinamige.gub.uy/shapefiles/GeoMinera_Dinamige.zip','', 'Canteras');

--ide.uy/Ministerio de Transporte y Obras Públicas/Dirección Nacional de Topografía
   --http://geoportal.mtop.gub.uy/geoserv.html
INSERT INTO GeographicServices (NodeID, Url, GeographicServicesType, Description) VALUES
(10,'http://geoservicios.mtop.gub.uy/geoserver/inf_tte_ttelog_logistica/wms?service=WMS&version=1.3.0&request=GetCapabilities','WMS', 'INFRAESTRUCTURA, TRANSPORTE Y LOGÍSTICA - Información Logística'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/inf_tte_ttelog_logistica/ows?service=WFS&version=1.3.0&request=GetCapabilities','WFS', 'INFRAESTRUCTURA, TRANSPORTE Y LOGÍSTICA - Información Logística'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/inf_tte_ttelog_terrestre/wms?service=WMS&version=1.3.0&request=GetCapabilities','WMS', 'INFRAESTRUCTURA, TRANSPORTE Y LOGÍSTICA - Transporte Terrestre'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/inf_tte_ttelog_terrestre/ows?service=WFS&version=1.3.0&request=GetCapabilities','WFS', 'INFRAESTRUCTURA, TRANSPORTE Y LOGÍSTICA - Transporte Terrestre'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/inf_tte_ttelog_fluvial/wms?service=WMS&version=1.3.0&request=GetCapabilities','WMS', 'INFRAESTRUCTURA, TRANSPORTE Y LOGÍSTICA - Transporte Fluvial'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/inf_tte_ttelog_fluvial/ows?service=WFS&version=1.3.0&request=GetCapabilities','WFS', 'INFRAESTRUCTURA, TRANSPORTE Y LOGÍSTICA - Transporte Fluvial'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/inf_tte_ttelog_ferroviario/wms?service=WMS&version=1.3.0&request=GetCapabilities','WMS', 'INFRAESTRUCTURA, TRANSPORTE Y LOGÍSTICA - Transporte Ferroviario'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/inf_tte_ttelog_ferroviario/ows?service=WFS&version=1.3.0&request=GetCapabilities','WFS', 'INFRAESTRUCTURA, TRANSPORTE Y LOGÍSTICA - Transporte Ferroviario'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/inf_tte_ttelog_aereo/wms?service=WMS&version=1.3.0&request=GetCapabilities','WMS', 'INFRAESTRUCTURA, TRANSPORTE Y LOGÍSTICA - Transporte Aéreo'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/inf_tte_ttelog_aereo/ows?service=WFS&version=1.3.0&request=GetCapabilities','WFS', 'INFRAESTRUCTURA, TRANSPORTE Y LOGÍSTICA - Transporte Aéreo'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/inf_tte_ttelog_otros/wms?service=WMS&version=1.3.0&request=GetCapabilities','WMS', 'INFRAESTRUCTURA, TRANSPORTE Y LOGÍSTICA - Otras Infraestructuras'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/inf_tte_ttelog_otros/ows?service=WFS&version=1.3.0&request=GetCapabilities','WFS', 'INFRAESTRUCTURA, TRANSPORTE Y LOGÍSTICA - Otras Infraestructuras'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/relevamiento_transito/wms?service=WMS&version=1.3.0&request=GetCapabilities','WMS', 'INFRAESTRUCTURA, TRANSPORTE Y LOGÍSTICA - Relevamiento Estadístico de Tránsito'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/relevamiento_transito/ows?service=WFS&version=1.3.0&request=GetCapabilities','WFS', 'INFRAESTRUCTURA, TRANSPORTE Y LOGÍSTICA - Relevamiento Estadístico de Tránsito'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/inf_soc_comunitaria/wms?service=WMS&version=1.3.0&request=GetCapabilities','WMS', 'INFRAESTRUCTURA SOCIAL - Infraestructura Comunitaria'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/inf_soc_comunitaria/ows?service=WFS&version=1.3.0&request=GetCapabilities','WFS', 'INFRAESTRUCTURA SOCIAL - Infraestructura Comunitaria'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/acc_intern_cosiplan/wms?service=WMS&version=1.3.0&request=GetCapabilities','WMS', 'ACCIÓN INTERNACIONAL - Cartografía COSIPLAN'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/acc_intern_cosiplan/ows?service=WFS&version=1.3.0&request=GetCapabilities','WFS', 'ACCIÓN INTERNACIONAL - Cartografía COSIPLAN'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/rec_hidrograficos/wms?service=WMS&version=1.3.0&request=GetCapabilities','WMS', 'RECURSOS HIDROGRÁFICOS'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/rec_hidrograficos/ows?service=WFS&version=1.3.0&request=GetCapabilities','WFS', 'RECURSOS HIDROGRÁFICOS'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/planos_publicar/wms?service=WMS&version=1.3.0&request=GetCapabilities','WMS', 'CONSULTA DE PLANOS DE MENSURA - Planos de mensura'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/planos_publicar/ows?service=WFS&version=1.3.0&request=GetCapabilities','WFS', 'CONSULTA DE PLANOS DE MENSURA - Planos de mensura'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/mb_hervidero/wms?service=WMS&version=1.3.0&request=GetCapabilities','WMS', 'VUELOS FOTOGRAMÉTRICOS - Parque Arroyo Hervidero'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/mb_hervidero/ows?service=WFS&version=1.3.0&request=GetCapabilities','WFS', 'VUELOS FOTOGRAMÉTRICOS - Parque Arroyo Hervidero'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/mb_sayago/wms?service=WMS&version=1.3.0&request=GetCapabilities','WMS', 'VUELOS FOTOGRAMÉTRICOS - Regasificadora Puntas de Sayago'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/mb_sayago/ows?service=WFS&version=1.3.0&request=GetCapabilities','WFS', 'VUELOS FOTOGRAMÉTRICOS - Regasificadora Puntas de Sayago'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/mb_pap/wms?service=WMS&version=1.3.0&request=GetCapabilities','WMS', 'VUELOS FOTOGRAMÉTRICOS - Puerto de Aguas Profundas'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/mb_pap/ows?service=WFS&version=1.3.0&request=GetCapabilities','WFS', 'VUELOS FOTOGRAMÉTRICOS - Puerto de Aguas Profundas'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/mb_piria/wms?service=WMS&version=1.3.0&request=GetCapabilities','WMS', 'VUELOS FOTOGRAMÉTRICOS - Piriápolis'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/mb_piria/ows?service=WFS&version=1.3.0&request=GetCapabilities','WFS', 'VUELOS FOTOGRAMÉTRICOS - Piriápolis'),
(10,'http://geoservicios.mtop.gub.uy/geoserver/rutas_SD/ows?service=WFS&version=1.3.0&request=GetCapabilities','WFS', 'SEGMENTACIÓN DINÁMICA - Rutas nacionales ');

--ide.uy/Ministerio de Vivienda, Ordenamiento Territorial y Medio Ambiente/Dirección Nacional de Medio Ambiente
   --https://www.dinama.gub.uy/geoservicios/
INSERT INTO GeographicServices (NodeID, Url, GeographicServicesType, Description) VALUES
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c255','WMS', 'Localidades (polígonos)'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c005','WMS', 'Control de Vertidos'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c008','WMS', 'Calidad de aire'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c010','WMS', 'Emprendimientos'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c012','WMS', 'Indicador Calidad de Agua'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c087','WMS', 'Unidades de Paisaje'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c088','WMS', 'Ornitogeográfica'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c089','WMS', 'Flora'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c090','WMS', 'Biozonas tetrápodos'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c091','WMS', 'Praderas'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c093','WMS', 'Macrozonificación'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c094','WMS', 'Ambientes acuáticos'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c095','WMS', 'Índice estado trófico 2012'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c096','WMS', 'Índice estado trófico 2014'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c097','WMS', 'Cuencas hidrográficas - Nivel 1'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c098','WMS', 'Cuencas hidrográficas - Nivel 2'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c099','WMS', 'Cuencas hidrográficas - Nivel 3'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c100','WMS', 'Contorno País'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c101','WMS', 'Municipios'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c102','WMS', 'Secciones catastrales'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c103','WMS', 'Densidad Población Cuenca Nivel 1 - 2011'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c104','WMS', 'Densidad Población Cuenca Nivel 2 - 2011'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c105','WMS', 'Densidad Población Cuenca Nivel 3 - 2011'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c106','WMS', 'Densidad Población Cuenca Nivel 4 - 2011'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c107','WMS', 'Densidad Población Cuenca Nivel 5 - 2011'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c108','WMS', 'Población Total Cuenca Nivel 1 - 2011'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c109','WMS', 'Población Total Cuenca Nivel 2 - 2011'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c110','WMS', 'Población Total Cuenca Nivel 3 - 2011'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c111','WMS', 'Población Total Cuenca Nivel 4 - 2011'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c112','WMS', 'Población Total Cuenca Nivel 5 - 2011'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c051','WMS', 'Embalse Paso Severino'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c050','WMS', 'Buffer Paso Severino'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c052','WMS', 'Buffer Canelón Grande'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c053','WMS', 'Embalse Canelón Grande'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c054','WMS', 'Buffer San Francisco'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c055','WMS', 'Embalse San Francisco'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c056','WMS', 'Buffer Tramo RSL entre Casupá y desembocadura RSJ'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c057','WMS', 'RSL entre Aº Casupá y desembocadura RSJ'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c058','WMS', 'Buffer Tramo RSJ aguas abajo A Cagancha'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c059','WMS', 'RSJ aguas abajo Aº Cagancha'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c060','WMS', 'Buffer Tramo RSLC aguas debajo A Las Piedras'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c061','WMS', 'RSLC aguas debajo de Aº de las Piedras'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c062','WMS', 'Buffer Tramo RSL aguas arriba de A Casupá'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c063','WMS', 'RSL aguas arriba de Aº Casupá'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c064','WMS', 'Buffer Tramo RSJ entre A San Gregorio y A Cagancha'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c065','WMS', 'RSJ entre Aº San Gregorio y Aº Cagancha'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c066','WMS', 'Buffer Tramo RSJ aguas arriba A San Gregorio'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c067','WMS', 'RSJ aguas arriba Aº San Gregorio'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c068','WMS', 'Buffer Tramo RSLC entre A de las Piedras y A del Sauce II'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c069','WMS', 'RSLC entre Aº de las Piedras y Aº del Sauce II'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c070','WMS', 'Buffer Tramo RSLC aguas arriba A del Sauce II'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c071','WMS', 'RSLC aguas arriba Aº del Sauce II'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c072','WMS', 'Buffer Tramo A de la Virgen'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c073','WMS', 'Aº de la Vírgen'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c074','WMS', 'Buffer Tramo A Canelon Grande'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c075','WMS', 'Tramo Aº Canelón Grande'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c076','WMS', 'Buffer Tramo A Canelon Chico'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c077','WMS', 'Aº Canelón Chico'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c078','WMS', 'Buffer Tramo A Casupa'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c079','WMS', 'Aº Casupá'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c080','WMS', 'Buffer Tramo A del Soldado'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c081','WMS', 'Tramo Aº del Soldado'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c085','WMS', 'Padrones Urbanos Cursos Principales'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c205','WMS', 'Oficinas MVOTMA'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c210','WMS', 'Comisiones Asesoras Específicas'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c211','WMS', 'Áreas RAMSAR'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c212','WMS', 'Límites de Reservas de Biósfera'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c213','WMS', 'Zonifiación Reservas de Biósfera'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c256','WMS', 'Localidades (puntos)'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c259','WMS', 'Padrones rurales'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c260','WMS', 'Padrones urbanos'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c258','WMS', 'Espejos de agua (polígonos)'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c257','WMS', 'Cursos de agua - lineas'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c262','WMS', 'Cuencas hidrográficas - Nivel 5'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c261','WMS', 'Cuencas hidrográficas - Nivel 4'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c251','WMS', 'Regionales en recursos hídricos'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c254','WMS', 'Estaciones de Monitoreo'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c252','WMS', 'Comisiones de Seguimiento'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c253','WMS', 'Comisiones de Cuencas'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c004','WMS', 'Departamentos'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c265','WMS', 'Zonas de Cambios'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c266','WMS', 'Cobertura del Suelo 2000'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c267','WMS', 'Cobertura del Suelo 2008'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c268','WMS', 'Cobertura del Suelo 2011'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c270','WMS', 'Modelo digital de territorio'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c272','WMS', 'Zonas adyacentes a áreas ingresadas'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c274','WMS', 'Áreas Protegidas 2016'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c275','WMS', 'Celdas sitios SNAP 2015-2020'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c276','WMS', 'Residuos agroindustriales totales'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c278','WMS', 'Residuos de Tambos'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c277','WMS', 'Residuos sector porcino'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c279','WMS', 'Residuos encierro de corral'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c280','WMS', 'Ronda I ANCAP'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c281','WMS', 'Ronda II ANCAP'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c285','WMS', 'Canales de Navegación'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c284','WMS', 'Navegación segura'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c283','WMS', 'Pesca artesanal'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c282','WMS', 'Puertos'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c286','WMS', 'Ambientes acuáticos'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c288','WMS', 'Área de desove especies nectonicas'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c289','WMS', 'Áreas acuáticas prioritarias'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c287','WMS', 'Área de cría y reproducción de peces dermesales'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c290','WMS', 'Áreas de especies carismáticas'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c298','WMS', 'Especies invasoras'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c291','WMS', 'Áreas de mayor riqueza específica'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c292','WMS', 'Áreas potenciales protegidas - DINARA'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c293','WMS', 'Áreas de productividad planctónica'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c294','WMS', 'Áreas de reproducción de peces nectónicos'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c295','WMS', 'Contaminación'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c296','WMS', 'Corredores hidrológicos'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c297','WMS', 'Erosión costera'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c299','WMS', 'Paisajes costeros'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c300','WMS', 'Veda pesca anchoita'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c301','WMS', 'Veda pesca corvina'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c302','WMS', 'Veda pesca pescadilla'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c303','WMS', 'Vegetación costera'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c304','WMS', 'Áreas frentes'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c305','WMS', 'Batimetría'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c306','WMS', 'Batimetría puntos'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c307','WMS', 'Frentes modales'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c308','WMS', 'Geomorfología'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c309','WMS', 'Isobatas'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c310','WMS', 'Salinidad fondo'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c311','WMS', 'Salinidad superficie'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c312','WMS', 'Sedimentos de fondo'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c313','WMS', 'Barcos hundidos'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c314','WMS', 'Campings'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c315','WMS', 'Espigones en playas'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c316','WMS', 'Faros'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c317','WMS', 'Infraestructura costera'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c318','WMS', 'Accidentes geográficos'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c319','WMS', 'Juridicción marítima'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c320','WMS', 'Prefecturas'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c321','WMS', 'Zonas jurídicas'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c322','WMS', 'Índice de vulnerabilidad costera'),
(12,'https://www.dinama.gub.uy/geoserver/u19600217/wms?service=WMS&version=1.1.0&request=GetMap&layers=u19600217:c323','WMS', 'Prioridades de conservación');

--ide.uy/Ministerio de Vivienda, Ordenamiento Territorial y Medio Ambiente/Dirección Nacional de Ordenamiento Territorial
   --http://sit.mvotma.gub.uy/serviciosOGC.htm
INSERT INTO GeographicServices (NodeID, Url, GeographicServicesType, Description) VALUES
(13,'http://sit.mvotma.gub.uy/ArcGIS/services/SIT/instrumentosOT/MapServer/WMSServer?','WMS', 'NORMATIVA DE ORDENAMIENTO TERRITORIAL'),
(13,'http://sit.mvotma.gub.uy/arcgis/services/SIT/instrumentosOT/MapServer/WFSServer?','WFS', 'NORMATIVA DE ORDENAMIENTO TERRITORIAL'),
(13,'http://sit.mvotma.gub.uy/ArcGIS/services/SIT/instrumentos_elaboracion/MapServer/WMSServer?','WMS', 'INSTRUMENTOS DE O.T EN ELABORACIÓN'),
(13,'http://sit.mvotma.gub.uy/arcgis/services/SIT/instrumentos_elaboracion/MapServer/WFSServer?','WFS', 'INSTRUMENTOS DE O.T EN ELABORACIÓN'),
(13,'http://sit.mvotma.gub.uy/ArcGIS/services/SIT/chs/MapServer/WMSServer?','WMS', 'CONJUNTOS HABITACIONALES DE PROMOCIÓN PÚBLICA'),
(13,'http://sit.mvotma.gub.uy/ArcGIS/services/SIT/chs/MapServer/WFSServer?','WFS', 'CONJUNTOS HABITACIONALES DE PROMOCIÓN PÚBLICA'),
(13,'http://sit.mvotma.gub.uy/ArcGIS/services/SIT/asentamientos/MapServer/WMSServer?','WMS', 'ASENTAMIENTOS'),
(13,'http://sit.mvotma.gub.uy/ArcGIS/services/SIT/asentamientos/MapServer/WFSServer?','WFS', 'ASENTAMIENTOS'),
(13,'http://sit.mvotma.gub.uy/ArcGIS/services/OGC/OGC_cobertura/MapServer/WMSServer?','WMS', 'COBERTURA DEL SUELO'),
(13,'http://sit.mvotma.gub.uy/ArcGIS/services/OGC/OGC_cobertura/MapServer/WFSServer?','WFS', 'COBERTURA DEL SUELO');

--ide.uy/Intendencia de Montevideo/Servicio de Geomática
   --http://sig.montevideo.gub.uy/content/geoservicios-web
   --TODO: Ver como cargar los WS de la IM
INSERT INTO GeographicServices (NodeID, Url, GeographicServicesType, Description) VALUES
(18,'http://geoweb.montevideo.gub.uy/geonetwork/srv/es/csw','CSW', 'ACCESO A SERVICIOS CSW');
--(18,'http://geoweb.montevideo.gub.uy/geonetwork/srv/es/main.home','', 'PORTAL BÚSQUEDA DE METADATOS'),
--(18,'http://geoweb.montevideo.gub.uy/geoserver/ide/ows','', 'ACCESO A SERVICIOS WMS _ WFS');

INSERT INTO SystemUser (Email, Password, UserGroupID, FirstName, LastName, PhoneNumber, InstitutionID) VALUES 
('ncalle@mail.com', 'ncalle', 1, 'Natalia', 'Calle', '098765432', 1),
('rsanchez@mail.com', 'rsanchez', 1, 'Ramiro', 'Sanchez', '098961259', 1);