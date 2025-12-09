CREATE TABLE Especialidades (
    id_especialidad SERIAL PRIMARY KEY,
    nombre VARCHAR(100) UNIQUE NOT NULL,
    descripcion TEXT,
    CHECK (LENGTH(nombre) > 3),
    CHECK (nombre = INITCAP(nombre)),
    CHECK (descripcion IS NOT NULL)
);

CREATE TABLE Doctores (
    id_doctor SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    licencia_medica VARCHAR(20) UNIQUE NOT NULL,
    telefono VARCHAR(15),
    CHECK (LENGTH(licencia_medica) >= 5),
    CHECK (UPPER(licencia_medica) = licencia_medica),
    CHECK (telefono ~ '^[0-9]{8,15}$')
);

CREATE TABLE Doctor_Especialidad (
    id_doctor INT REFERENCES Doctores(id_doctor) ON DELETE CASCADE ON UPDATE CASCADE,
    id_especialidad INT REFERENCES Especialidades(id_especialidad) ON DELETE RESTRICT ON UPDATE CASCADE,
    PRIMARY KEY (id_doctor, id_especialidad)
);

CREATE TABLE Habitaciones (
    id_habitacion SERIAL PRIMARY KEY,
    numero VARCHAR(10) UNIQUE NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    estado VARCHAR(50) DEFAULT 'Disponible',
    CHECK (tipo IN ('Individual', 'Doble', 'Suite')),
    CHECK (estado IN ('Disponible', 'Ocupada', 'Mantenimiento')),
    CHECK (numero ~ '^[0-9]+[A-Z]*$')
);

CREATE TABLE Pacientes (
    id_paciente SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    telefono VARCHAR(15),
    historial_basico TEXT,
    id_habitacion INT REFERENCES Habitaciones(id_habitacion) ON DELETE SET NULL ON UPDATE CASCADE,
    CHECK (fecha_nacimiento < CURRENT_DATE),
    CHECK (telefono ~ '^[0-9]+$'),
    CHECK (LENGTH(nombre) > 1 AND LENGTH(apellido) > 1)
);

CREATE TABLE Citas (
    id_cita SERIAL PRIMARY KEY,
    id_paciente INT REFERENCES Pacientes(id_paciente) ON DELETE RESTRICT ON UPDATE CASCADE,
    id_doctor INT REFERENCES Doctores(id_doctor) ON DELETE RESTRICT ON UPDATE CASCADE,
    fecha_hora TIMESTAMP NOT NULL,
    motivo TEXT NOT NULL,
    estado VARCHAR(50) DEFAULT 'Pendiente', 
    CHECK (estado IN ('Pendiente', 'Realizada', 'Cancelada')),
    CHECK (EXTRACT(HOUR FROM fecha_hora) >= 8 AND EXTRACT(HOUR FROM fecha_hora) <= 18), 
    CHECK (LENGTH(motivo) >= 10) 
);

CREATE TABLE Diagnosticos (
    id_diagnostico SERIAL PRIMARY KEY,
    id_cita INT UNIQUE REFERENCES Citas(id_cita) ON DELETE RESTRICT ON UPDATE CASCADE,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha_diagnostico DATE DEFAULT CURRENT_DATE,
    CHECK (nombre IS NOT NULL),
    CHECK (fecha_diagnostico <= CURRENT_DATE),
    CHECK (LENGTH(descripcion) >= 10)
);

CREATE TABLE Tratamientos (
    id_tratamiento SERIAL PRIMARY KEY,
    id_diagnostico INT REFERENCES Diagnosticos(id_diagnostico) ON DELETE CASCADE ON UPDATE CASCADE,
    nombre VARCHAR(100) NOT NULL,
    duracion_dias INT NOT NULL,
    fecha_inicio DATE DEFAULT CURRENT_DATE,
    CHECK (duracion_dias > 0),
    CHECK (fecha_inicio <= CURRENT_DATE),
    CHECK (nombre IS NOT NULL)
);

CREATE TABLE Medicamentos (
    id_medicamento SERIAL PRIMARY KEY,
    nombre VARCHAR(100) UNIQUE NOT NULL,
    principio_activo VARCHAR(100),
    stock_actual INT DEFAULT 0,
    stock_minimo INT NOT NULL,
    CHECK (stock_actual >= 0),
    CHECK (stock_minimo > 0),
    CHECK (LENGTH(nombre) >= 5)
);

CREATE TABLE Tratamiento_Medicamento (
    id_tratamiento INT REFERENCES Tratamientos(id_tratamiento) ON DELETE CASCADE ON UPDATE CASCADE,
    id_medicamento INT REFERENCES Medicamentos(id_medicamento) ON DELETE RESTRICT ON UPDATE CASCADE,
    dosis VARCHAR(50) NOT NULL,
    frecuencia VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_tratamiento, id_medicamento),
    CHECK (dosis ~ '^[0-9]+(mg|ml|un)$'),
    CHECK (frecuencia IN ('Diaria', 'Cada 8 horas', 'Cada 12 horas', 'Semanal')),
    CHECK (dosis IS NOT NULL)
);