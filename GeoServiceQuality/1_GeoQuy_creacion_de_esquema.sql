DROP DATABASE IF EXISTS GeoServiceQuality;
CREATE DATABASE GeoServiceQuality;

USE GeoServiceQuality;

-- TODO: VER PORQUE LAS CHECK CONSTRAINT TIPO = '' OR '' NO FUNCIONAN

-- Contiene los distintos grupos de usuarios
CREATE TABLE Grupo
(
	GrupoID TINYINT AUTO_INCREMENT NOT NULL,
    Nombre VARCHAR(40) NOT NULL,
    Descripcion VARCHAR(100) NULL,
    
    PRIMARY KEY (GrupoID),
    UNIQUE KEY (Nombre)
);

-- Contiene una lista de los permisos de uso dentro de la aplicacion
CREATE TABLE Permiso
(
	PermisoID SMALLINT AUTO_INCREMENT NOT NULL,
    Nombre VARCHAR(40) NOT NULL,
    Descripcion VARCHAR(100) NULL,
    
    PRIMARY KEY (PermisoID),
    UNIQUE KEY (Nombre)
);

-- Contiene los permisos habilitados para los grupos de usuarios
CREATE TABLE PermisoGrupo
(
	PermisoID SMALLINT NOT NULL,
    GrupoID TINYINT NOT NULL,
    
    PRIMARY KEY (PermisoID, GrupoID),
    FOREIGN KEY (PermisoID) REFERENCES Permiso(PermisoID),
    FOREIGN KEY (GrupoID) REFERENCES Grupo(GrupoID)
);

-- Usuarios que haran uso de la aplicacion
CREATE TABLE Usuario
(
	UsuarioID INT AUTO_INCREMENT NOT NULL,
    Email VARCHAR(40) NOT NULL,    
    UsuarioPassword VARCHAR(40) NOT NULL,
    GrupoID TINYINT NOT NULL,
    Nombre VARCHAR(40) NULL,
    Apellido VARCHAR(40) NULL,
    Telefono BIGINT NULL,

    PRIMARY KEY (UsuarioID),
    UNIQUE KEY (Email),
    FOREIGN KEY (GrupoID) REFERENCES Grupo(GrupoID)
);

-- Contiene los Ides creadas
CREATE TABLE Ide
(
	IdeID INT AUTO_INCREMENT NOT NULL,
    Nombre VARCHAR(40) NOT NULL,
    Descripcion VARCHAR(100) NULL,

    PRIMARY KEY (IdeID),
    UNIQUE KEY (Nombre)
);

-- Contiene las Instituciones creadas
CREATE TABLE Institucion
(
	InstitucionID INT AUTO_INCREMENT NOT NULL,
    IdeID INT NOT NULL,
    Nombre VARCHAR(40) NOT NULL,
    Descripcion VARCHAR(100) NULL,

    PRIMARY KEY (InstitucionID),
	UNIQUE KEY (Nombre),
    FOREIGN KEY (IdeID) REFERENCES Ide(IdeID)
);

-- Contiene los Nodos creados
CREATE TABLE Nodo
(
	NodoID INT AUTO_INCREMENT NOT NULL,
    InstitucionID INT NOT NULL,
    Nombre VARCHAR(40) NOT NULL,
    Descripcion VARCHAR(100) NULL,

    PRIMARY KEY (NodoID),
	UNIQUE KEY (Nombre)	,
    FOREIGN KEY (InstitucionID) REFERENCES Institucion(InstitucionID)
);

-- Contiene los Servicios Geograficos creados
CREATE TABLE ServicioGeografico
(
	ServicioGeograficoID INT AUTO_INCREMENT NOT NULL,
    NodoID INT NOT NULL,
    Url VARCHAR(1024) NOT NULL,
    Tipo CHAR(3) NOT NULL, -- WMS, WFS, CSW
    -- Metadato XML
    
    PRIMARY KEY (ServicioGeograficoID),
	UNIQUE KEY (Url),
    FOREIGN KEY (NodoID) REFERENCES Nodo(NodoID),
    CONSTRAINT CK_valores_Tipo CHECK (Tipo = 'WMS' OR 'WFS' OR 'CSW')
);

-- Contiene todos los objetos medibles (Ides o Insituciones) que el usuario puede o no evaluar
CREATE TABLE UsuarioObjeto
(
	UsuarioObjetoID INT AUTO_INCREMENT NOT NULL,
    UsuarioID INT NOT NULL,
    ObjetoID INT NOT NULL, -- IdeID o InstitucionID
    Tipo CHAR(3) NOT NULL, -- 'Ide' = Ide, 'Ins' = Insitucional
    PuedeEvaluarFlag BIT NOT NULL,

    PRIMARY KEY (UsuarioObjetoID),
    UNIQUE (UsuarioID, ObjetoID, Tipo),
    FOREIGN KEY (UsuarioID) REFERENCES Usuario(UsuarioID),
    CONSTRAINT CK_valores_Tipo CHECK (Tipo = 'Ide' OR 'Ins'),
	CONSTRAINT CK_existencia_de_ObjetoID CHECK
		(
			CASE WHEN Tipo = 'Ide' AND EXISTS (SELECT i.IdeID FROM Ide i WHERE i.IdeID = ObjetoID) THEN 1 ELSE 0 END
			+ CASE WHEN Tipo = 'Ins' AND EXISTS (SELECT i.InstitucionID FROM Institucion i WHERE i.InstitucionID = ObjetoID) THEN 1 ELSE 0 END
            = 1
        )
);

-- Contiene los distintos Perfiles que se vayan creando
CREATE TABLE Perfil
(
	PerfilID TINYINT AUTO_INCREMENT NOT NULL,
    Nombre VARCHAR(40) NOT NULL,
    EsPerfilPonderadoFlag BIT NOT NULL,

    PRIMARY KEY (PerfilID),
    UNIQUE KEY (Nombre)
);

-- Contiene las Dimensiones del modelo de calidad
CREATE TABLE Dimension
(
	DimensionID INT AUTO_INCREMENT NOT NULL,
    Nombre VARCHAR(40) NOT NULL,

    PRIMARY KEY (DimensionID),
    UNIQUE KEY (Nombre)
);

-- Contiene los Factores del modelo de calidad
CREATE TABLE Factor
(
	FactorID INT AUTO_INCREMENT NOT NULL,
    DimensionID INT NOT NULL,
    Nombre VARCHAR(40) NOT NULL,

    PRIMARY KEY (FactorID),
    UNIQUE KEY (Nombre),    
    FOREIGN KEY (DimensionID) REFERENCES Dimension(DimensionID)
);

-- Contiene las unidades utilizadas para medir cada una de las metricas de calidad
CREATE TABLE Unidad
(
	UnidadID TINYINT AUTO_INCREMENT NOT NULL,
    Nombre VARCHAR(40) NOT NULL,
    Descripcion VARCHAR(100) NULL,

    PRIMARY KEY (UnidadID),
    UNIQUE KEY (Nombre)
);

-- Contiene las Metricas del modelo de calidad
CREATE TABLE Metrica
(
	MetricaID INT AUTO_INCREMENT NOT NULL,
    FactorID INT NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    UnidadID TINYINT NOT NULL,

    PRIMARY KEY (MetricaID),
	UNIQUE KEY (Nombre),
    FOREIGN KEY (FactorID) REFERENCES Factor(FactorID),
    FOREIGN KEY (UnidadID) REFERENCES Unidad(UnidadID)
);

-- Contiene los rangos asignados a las Metricas del modelo de calidad, para cierto perfil
CREATE TABLE Rango
(
	RangoID INT AUTO_INCREMENT NOT NULL,
    MetricaID INT NOT NULL,
    PerfilID TINYINT NOT NULL,
	BoleanoFlag BIT NULL,
    ValorAcepatcionBoleano BIT NULL,
    PorcentajeFlag BIT NULL,
    ValorAceptacionPorcentaje INT NULL,
    EnteroFlag BIT NULL,
    ValorAceptacionEntero INT NULL,
    EnumeradoFlag BIT NULL,
    ValorAceptacionEnumerado CHAR(1) NULL, -- 'B' = Basico, 'I' = Intermedio, 'C' = Completo
    
    PRIMARY KEY (RangoID),
    UNIQUE KEY (MetricaID, PerfilID),
	CONSTRAINT CK_valores_ValorAceptacionEnumerado CHECK (ValorAceptacionEnumerado = 'B' OR 'I' OR 'C'),
    CONSTRAINT CK_Flags_Valor CHECK
		(
			CASE WHEN BoleanoFlag = 1 AND ValorAceptacionBoleano IS NOT NULL 
				AND PorcentajeFlag = 0 AND ValorAceptacionPorcentaje IS NULL
                AND EnteroFlag = 0 AND ValorAceptacionEntero IS NULL
                AND EnumeradoFlag = 0 AND ValorAceptacionEnumerado IS NULL
				THEN 1 ELSE 0 END
            + CASE WHEN PorcentajeFlag = 1 AND ValorAceptacionPorcentaje IS NOT NULL 
				AND BoleanoFlag = 0 AND ValorAceptacionBoleano IS NULL
                AND EnteroFlag = 0 AND ValorAceptacionEntero IS NULL
                AND EnumeradoFlag = 0 AND ValorAceptacionEnumerado IS NULL            
				THEN 1 ELSE 0 END
            + CASE WHEN EnteroFlag = 1 AND ValorAceptacionEntero IS NOT NULL 
				AND BoleanoFlag = 0 AND ValorAceptacionBoleano IS NULL
                AND PorcentajeFlag = 0 AND ValorAceptacionPorcentaje IS NULL
                AND EnumeradoFlag = 0 AND ValorAceptacionEnumerado IS NULL   
				THEN 1 ELSE 0 END
            + CASE WHEN EnumeradoFlag = 1 AND ValorAceptacionEnumerado IS NOT NULL 
				AND BoleanoFlag = 0 AND ValorAceptacionBoleano IS NULL
                AND PorcentajeFlag = 0 AND ValorAceptacionPorcentaje IS NULL
                AND EnteroFlag = 0 AND ValorAceptacionEntero IS NULL 
				THEN 1 ELSE 0 END
            = 1
        ),
	FOREIGN KEY (MetricaID) REFERENCES Metrica(MetricaID),
    FOREIGN KEY (PerfilID) REFERENCES Perfil(PerfilID)
);

-- Guarda las ponderaciones asignadas al Perfil y a los elementos de la jerarquia del modelo de calidad
CREATE TABLE Ponderacion
(
	PonderacionID INT AUTO_INCREMENT NOT NULL,
    PerfilID TINYINT NOT NULL,
    ElementoID INT NOT NULL, -- DimensionID, FactorID, MetricaID, RangoID
    Tipo CHAR(1) NOT NULL, -- 'D' = Dimension, 'F' = Factor, 'M' = Metrica, 'R' = Rango
    Valor INT NOT NULL,

    PRIMARY KEY (PonderacionID),
    UNIQUE KEY (PerfilID, ElementoID, Tipo),    
    FOREIGN KEY (PerfilID) REFERENCES Perfil(PerfilID),
    CONSTRAINT CK_valores_Tipo CHECK (Tipo = 'D' OR 'F' OR 'M' OR 'R'),
    CONSTRAINT CK_existencia_de_ElementoID CHECK
		(
			CASE WHEN Tipo = 'D' AND EXISTS (SELECT d.DimensionID FROM Dimension d WHERE d.DimensionID = ElementoID) THEN 1 ELSE 0 END
			+ CASE WHEN Tipo = 'F' AND EXISTS (SELECT f.FactorID FROM Factor f WHERE f.FactorID = ElementoID) THEN 1 ELSE 0 END
			+ CASE WHEN Tipo = 'M' AND EXISTS (SELECT m.MetricaID FROM Metrica m WHERE m.MetricaID = ElementoID) THEN 1 ELSE 0 END
            + CASE WHEN Tipo = 'R' AND EXISTS (SELECT r.RangoID FROM Rango r WHERE r.RangoID = ElementoID) THEN 1 ELSE 0 END
            = 1
        )
);

-- Contiene el resultado de las evaluaciones
CREATE TABLE Evaluacion
(
	EvaluacionID INT AUTO_INCREMENT NOT NULL,
	UsuarioID INT NOT NULL,
    PerfilID TINYINT NOT NULL,
    FechaDeComienzo DATETIME NOT NULL,
    FechaDeFin DATETIME NULL,
    EvaluaionCompletaFlag BIT NOT NULL,
    ResultadoExitosoFlag BIT NULL,

    PRIMARY KEY (EvaluacionID),
    FOREIGN KEY (PerfilID) REFERENCES Perfil(PerfilID),
    FOREIGN KEY (UsuarioID) REFERENCES Usuario(UsuarioID),
    CONSTRAINT CK_completa_resultado CHECK
		(
			CASE WHEN EvaluacionCompletaFlag = 1 AND ResultadoExitosoFlag IS NOT NULL THEN 1 ELSE 0 END
			+ CASE WHEN EvaluacionCompletaFlag = 0 AND ResultadoExitosoFlag IS NULL THEN 1 ELSE 0 END
            = 1
        )
);

-- Contiene el resultado parcial de las evaluaciones que aun no han finalizado
CREATE TABLE EvaluacionParcial
(
	EvaluacionParcialID BIGINT AUTO_INCREMENT NOT NULL,
    EvaluacionID INT NOT NULL,
    FechaDeEjecucion DATETIME NOT NULL,
    ResultadoParcialExitosoFlag BIT NULL,

    PRIMARY KEY (EvaluacionParcialID),
    UNIQUE KEY (EvaluacionID, FechaDeEjecucion),
    FOREIGN KEY (EvaluacionID) REFERENCES Evaluacion(EvaluacionID)
);

/*
-- Guarda las Metricas seleccionadas en cada uno de los Perfiles creados
CREATE TABLE PerfilMetrica -- YA NO ES NECESARIA YA QUE EL RANGO GUARDA RELACION ENTRE LA METRICA Y EL PERFIL
(
	PerfilMetricaID INT AUTO_INCREMENT NOT NULL,
	PerfilID INT NOT NULL,
    MetricaID INT NOT NULL,

    PRIMARY KEY (PerfilMetricaID),
    UNIQUE KEY (PerfilID, MetricaID),
    FOREIGN KEY (PerfilID) REFERENCES Perfil(PerfilID),
    FOREIGN KEY (MetricaID) REFERENCES Metrica(MetricaID)
);
*/

/*
CREATE TABLE UnidadValoresPosibles
(
	UnidadValoresPosiblesID INT AUTO_INCREMENT NOT NULL,
    UnidadID INT NOT NULL,
    ValorPosible VARCHAR(40) NOT NULL,
    PRIMARY KEY (UnidadValoresPosiblesID),
    FOREIGN KEY (UnidadID) REFERENCES Unidad(UnidadID)
);
*/

/*
CREATE TABLE PerfilUsuario
(
	PerfilUsuarioID INT AUTO_INCREMENT NOT NULL,
	PerfilID INT NOT NULL,
    UsuarioID INT NOT NULL,
    PRIMARY KEY (PerfilUsuarioID),
    UNIQUE KEY (PerfilID, UsuarioID),
    FOREIGN KEY (PerfilID) REFERENCES Perfil(PerfilID),
    FOREIGN KEY (UsuarioID) REFERENCES Usuario(UsuarioID)
);
*/
