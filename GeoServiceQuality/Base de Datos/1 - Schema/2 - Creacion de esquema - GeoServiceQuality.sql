-- Contiene los distintos grupos de usuarios
DROP TABLE IF EXISTS Grupo CASCADE;
CREATE TABLE Grupo
(
    GrupoID SERIAL NOT NULL,
    Nombre VARCHAR(40) NOT NULL,
    Descripcion VARCHAR(100) NULL,
    
    PRIMARY KEY (GrupoID),
    UNIQUE (Nombre)
);

-- Contiene una lista de los permisos de uso dentro de la aplicacion
DROP TABLE IF EXISTS Permiso CASCADE;
CREATE TABLE Permiso
(
    PermisoID SERIAL NOT NULL,
    Nombre VARCHAR(40) NOT NULL,
    Descripcion VARCHAR(100) NULL,
    
    PRIMARY KEY (PermisoID),
    UNIQUE (Nombre)
);

-- Contiene los permisos habilitados para los grupos de usuarios
DROP TABLE IF EXISTS PermisoGrupo CASCADE;
CREATE TABLE PermisoGrupo
(
    PermisoID SMALLINT NOT NULL,
    GrupoID INT NOT NULL,
    
    PRIMARY KEY (PermisoID, GrupoID),
    FOREIGN KEY (PermisoID) REFERENCES Permiso(PermisoID),
    FOREIGN KEY (GrupoID) REFERENCES Grupo(GrupoID)
);

-- Contiene los Ides creadas
DROP TABLE IF EXISTS Ide CASCADE;
CREATE TABLE Ide
(
    IdeID SERIAL NOT NULL,
    Nombre VARCHAR(40) NOT NULL,
    Descripcion VARCHAR(100) NULL,

    PRIMARY KEY (IdeID),
    UNIQUE (Nombre)
);


-- Contiene las Instituciones creadas
DROP TABLE IF EXISTS Institucion CASCADE;
CREATE TABLE Institucion
(
    InstitucionID SERIAL NOT NULL,
    IdeID INT NOT NULL,
    Nombre VARCHAR(40) NOT NULL,
    Descripcion VARCHAR(100) NULL,

    PRIMARY KEY (InstitucionID),
    UNIQUE (Nombre),
    FOREIGN KEY (IdeID) REFERENCES Ide(IdeID)
);

-- Contiene los Nodos creados
DROP TABLE IF EXISTS Nodo CASCADE;
CREATE TABLE Nodo
(
    NodoID SERIAL NOT NULL,
    InstitucionID INT NOT NULL,
    Nombre VARCHAR(40) NOT NULL,
    Descripcion VARCHAR(100) NULL,

    PRIMARY KEY (NodoID),
    UNIQUE (Nombre),
    FOREIGN KEY (InstitucionID) REFERENCES Institucion(InstitucionID)
);

-- Contiene Capas que han sido cargadas por el sistema
DROP TABLE IF EXISTS Capa CASCADE;
CREATE TABLE Capa
(
    CapaID SERIAL NOT NULL,
    NodoID INT NOT NULL,
    Nombre VARCHAR(40) NOT NULL,
    Url VARCHAR(1024) NOT NULL,
    
    PRIMARY KEY (CapaID),
    UNIQUE (Url),
    FOREIGN KEY (NodoID) REFERENCES Nodo(NodoID)
);

-- Contiene los Servicios Geograficos creados
DROP TABLE IF EXISTS ServicioGeografico CASCADE;
CREATE TABLE ServicioGeografico
(
    ServicioGeograficoID SERIAL NOT NULL,
    NodoID INT NOT NULL,
    Url VARCHAR(1024) NOT NULL,
    Tipo CHAR(3) NOT NULL, -- WMS, WFS, CSW
    -- Metadato XML
    
    PRIMARY KEY (ServicioGeograficoID),
    UNIQUE (Url),
    FOREIGN KEY (NodoID) REFERENCES Nodo(NodoID),
    CONSTRAINT CK_valores_Tipo CHECK (Tipo IN ('WMS','WFS','CSW'))
);

-- Usuarios que haran uso de la aplicacion
DROP TABLE IF EXISTS Usuario CASCADE;
CREATE TABLE Usuario
(
    UsuarioID SERIAL NOT NULL,
    Email VARCHAR(40) NOT NULL,
    UsuarioPassword VARCHAR(40) NOT NULL,
    GrupoID INT NOT NULL,
    Nombre VARCHAR(40) NULL,
    Apellido VARCHAR(40) NULL,
    Telefono BIGINT NULL,
    InstitucionID INT NULL, -- Institucion a la cual pertenece el usuario

    PRIMARY KEY (UsuarioID),
    UNIQUE (Email),
    FOREIGN KEY (GrupoID) REFERENCES Grupo(GrupoID),
    FOREIGN KEY (InstitucionID) REFERENCES Institucion(InstitucionID)
);

-- Contiene todos los objetos medibles (Ides o Insituciones) que el usuario puede o no evaluar
DROP TABLE IF EXISTS UsuarioObjeto CASCADE;
CREATE TABLE UsuarioObjeto
(
    UsuarioObjetoID SERIAL NOT NULL,
    UsuarioID INT NOT NULL,
    ObjetoID INT NOT NULL, -- IdeID o InstitucionID
    Tipo VARCHAR(11) NOT NULL, -- 'Ide', 'Institucion', 'Nodo', 'Capa', 'Servicio'
    PuedeEvaluarFlag BOOLEAN NOT NULL,

    PRIMARY KEY (UsuarioObjetoID),
    UNIQUE (UsuarioID, ObjetoID, Tipo),
    FOREIGN KEY (UsuarioID) REFERENCES Usuario(UsuarioID),
    CONSTRAINT CK_valores_Tipo CHECK (Tipo IN ('Ide', 'Institucion', 'Nodo', 'Capa', 'Servicio'))
);

-- Contiene los distintos Perfiles que se vayan creando
DROP TABLE IF EXISTS Perfil CASCADE;
CREATE TABLE Perfil
(
    PerfilID SERIAL NOT NULL,
    Nombre VARCHAR(40) NOT NULL,
    Granuralidad VARCHAR(11) NOT NULL, -- 'Ide', 'Institución', 'Nodo', 'Capa', 'Servicio',
    EsPerfilPonderadoFlag BOOLEAN NOT NULL,

    PRIMARY KEY (PerfilID),
    UNIQUE (Nombre),
    CONSTRAINT CK_valores_Granularidad CHECK (Granuralidad IN ('Ide', 'Institución', 'Nodo', 'Capa', 'Servicio'))
);


-- Contiene los distintos modelo de calidad existentes en el sistema
DROP TABLE IF EXISTS Modelo CASCADE;
CREATE TABLE Modelo
(
    ModeloID SERIAL NOT NULL,
    Nombre VARCHAR(40) NOT NULL,

    PRIMARY KEY (ModeloID),
    UNIQUE (Nombre)
);

-- Contiene las Dimensiones del modelo de calidad
DROP TABLE IF EXISTS Dimension CASCADE;
CREATE TABLE Dimension
(
    DimensionID SERIAL NOT NULL,
    ModeloID INT NOT NULL,
    Nombre VARCHAR(40) NOT NULL,

    PRIMARY KEY (DimensionID),
    UNIQUE (Nombre),
    FOREIGN KEY (ModeloID) REFERENCES Modelo(ModeloID)
);

-- Contiene los Factores del modelo de calidad
DROP TABLE IF EXISTS Factor CASCADE;
CREATE TABLE Factor
(
    FactorID SERIAL NOT NULL,
    DimensionID INT NOT NULL,
    Nombre VARCHAR(40) NOT NULL,

    PRIMARY KEY (FactorID),
    UNIQUE (Nombre),    
    FOREIGN KEY (DimensionID) REFERENCES Dimension(DimensionID)
);

-- Contiene las unidades utilizadas para medir cada una de las metricas de calidad
DROP TABLE IF EXISTS Unidad CASCADE;
CREATE TABLE Unidad
(
    UnidadID SERIAL NOT NULL,
    Nombre VARCHAR(40) NOT NULL,
    Descripcion VARCHAR(100) NULL,

    PRIMARY KEY (UnidadID),
    UNIQUE (Nombre)
);

-- Contiene las Metricas del modelo de calidad
DROP TABLE IF EXISTS Metrica CASCADE;
CREATE TABLE Metrica
(
    MetricaID SERIAL NOT NULL,
    FactorID INT NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    AgregacionFlag BOOLEAN NOT NULL,
    UnidadID INT NOT NULL,
    Granuralidad VARCHAR(11) NOT NULL, -- 'Ide', 'Institución', 'Nodo', 'Capa', 'Servicio', 'Método'
    Descripcion VARCHAR(100) NULL,

    PRIMARY KEY (MetricaID),
    UNIQUE (Nombre),
    FOREIGN KEY (FactorID) REFERENCES Factor(FactorID),
    FOREIGN KEY (UnidadID) REFERENCES Unidad(UnidadID),
    CONSTRAINT CK_valores_Granularidad CHECK (Granuralidad IN ('Ide', 'Institución', 'Nodo', 'Capa', 'Servicio', 'Método'))
);

-- Contiene los rangos asignados a las Metricas del modelo de calidad, para cierto perfil
DROP TABLE IF EXISTS Rango CASCADE;
CREATE TABLE Rango
(
    RangoID SERIAL NOT NULL,
    MetricaID INT NOT NULL,
    PerfilID INT NOT NULL,
    BoleanoFlag BOOLEAN NULL,
    ValorAceptacionBoleano BOOLEAN NULL,
    PorcentajeFlag BOOLEAN NULL,
    ValorAceptacionPorcentaje INT NULL,
    EnteroFlag BOOLEAN NULL,
    ValorAceptacionEntero INT NULL,
    EnumeradoFlag BOOLEAN NULL,
    ValorAceptacionEnumerado CHAR(1) NULL, -- 'B' = Basico, 'I' = Intermedio, 'C' = Completo
    
    PRIMARY KEY (RangoID),
    UNIQUE (MetricaID, PerfilID),
    CONSTRAINT CK_valores_ValorAceptacionEnumerado CHECK (ValorAceptacionEnumerado IN ('B', 'I', 'C')),   
    CONSTRAINT CK_Flags_Valor CHECK
        (
            CASE WHEN BoleanoFlag = TRUE AND ValorAceptacionBoleano IS NOT NULL 
                AND PorcentajeFlag = FALSE AND ValorAceptacionPorcentaje IS NULL
                AND EnteroFlag = FALSE AND ValorAceptacionEntero IS NULL
                AND EnumeradoFlag = FALSE AND ValorAceptacionEnumerado IS NULL
                    THEN 1 ELSE 0 END
            + CASE WHEN PorcentajeFlag = TRUE AND ValorAceptacionPorcentaje IS NOT NULL 
                AND BoleanoFlag = FALSE AND ValorAceptacionBoleano IS NULL
                AND EnteroFlag = FALSE AND ValorAceptacionEntero IS NULL
                AND EnumeradoFlag = FALSE AND ValorAceptacionEnumerado IS NULL
                    THEN 1 ELSE 0 END
            + CASE WHEN EnteroFlag = TRUE AND ValorAceptacionEntero IS NOT NULL 
                AND BoleanoFlag = FALSE AND ValorAceptacionBoleano IS NULL
                AND PorcentajeFlag = FALSE AND ValorAceptacionPorcentaje IS NULL
                AND EnumeradoFlag = FALSE AND ValorAceptacionEnumerado IS NULL   
                    THEN 1 ELSE 0 END
            + CASE WHEN EnumeradoFlag = TRUE AND ValorAceptacionEnumerado IS NOT NULL 
                AND BoleanoFlag = FALSE AND ValorAceptacionBoleano IS NULL
                AND PorcentajeFlag = FALSE AND ValorAceptacionPorcentaje IS NULL
                AND EnteroFlag = FALSE AND ValorAceptacionEntero IS NULL 
		    THEN 1 ELSE 0 END
            = 1
        ),
    FOREIGN KEY (MetricaID) REFERENCES Metrica(MetricaID),
    FOREIGN KEY (PerfilID) REFERENCES Perfil(PerfilID)
);

-- Guarda las ponderaciones asignadas al Perfil y a los elementos de la jerarquia del modelo de calidad
DROP TABLE IF EXISTS Ponderacion CASCADE;
CREATE TABLE Ponderacion
(
    PonderacionID SERIAL NOT NULL,
    PerfilID INT NOT NULL,
    ElementoID INT NOT NULL, -- DimensionID, FactorID, MetricaID, RangoID
    Tipo CHAR(1) NOT NULL, -- 'D' = Dimension, 'F' = Factor, 'M' = Metrica, 'R' = Rango
    Valor INT NOT NULL,

    PRIMARY KEY (PonderacionID),
    UNIQUE (PerfilID, ElementoID, Tipo),    
    FOREIGN KEY (PerfilID) REFERENCES Perfil(PerfilID),
    CONSTRAINT CK_valores_Tipo CHECK (Tipo IN ('D', 'F', 'M', 'R'))
);

-- Contiene el resultado de las evaluaciones
DROP TABLE IF EXISTS Evaluacion CASCADE;
CREATE TABLE Evaluacion
(
    EvaluacionID SERIAL NOT NULL,
    UsuarioID INT NOT NULL,
    PerfilID INT NOT NULL,
    FechaDeComienzo DATE NOT NULL,
    FechaDeFin DATE NULL,
    EvaluacionCompletaFlag BOOLEAN NOT NULL,
    ResultadoExitosoFlag BOOLEAN NULL,

    PRIMARY KEY (EvaluacionID),
    FOREIGN KEY (PerfilID) REFERENCES Perfil(PerfilID),
    FOREIGN KEY (UsuarioID) REFERENCES Usuario(UsuarioID),
    CONSTRAINT CK_completa_resultado CHECK
        (
	    CASE WHEN EvaluacionCompletaFlag = TRUE AND ResultadoExitosoFlag IS NOT NULL THEN 1 ELSE 0 END
	    + CASE WHEN EvaluacionCompletaFlag = FALSE AND ResultadoExitosoFlag IS NULL THEN 1 ELSE 0 END
            = 1
        )
);

-- Contiene el resultado parcial de las evaluaciones que aun no han finalizado
DROP TABLE IF EXISTS EvaluacionParcial CASCADE;
CREATE TABLE EvaluacionParcial
(
    EvaluacionParcialID SERIAL NOT NULL,
    EvaluacionID INT NOT NULL,
    FechaDeEjecucion DATE NOT NULL,
    ResultadoParcialExitosoFlag BOOLEAN NULL,

    PRIMARY KEY (EvaluacionParcialID),
    UNIQUE (EvaluacionID, FechaDeEjecucion),
    FOREIGN KEY (EvaluacionID) REFERENCES Evaluacion(EvaluacionID)
);
