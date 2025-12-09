SET TIMEZONE TO 'UTC';

INSERT INTO Especialidades (nombre, descripcion) VALUES
('Cardiología', 'Diagnóstico y tratamiento de enfermedades del corazón y vasos sanguíneos.'),
('Pediatría', 'Atención médica de bebés, niños y adolescentes.'),
('Dermatología', 'Estudio y tratamiento de la piel, pelo y uñas.'),
('Emergencias', 'Atención inmediata de situaciones críticas.');

INSERT INTO Habitaciones (numero, tipo, estado) VALUES
('101', 'Individual', 'Ocupada'),
('102A', 'Doble', 'Disponible'),
('205', 'Suite', 'Disponible'),
('206', 'Individual', 'Mantenimiento');

INSERT INTO Doctores (nombre, apellido, licencia_medica, telefono) VALUES
('Juan', 'Pérez', 'MP10025', '555123456'),
('María', 'García', 'MP20345', '555987654'),
('Carlos', 'López', 'MP30010', '555112233');

INSERT INTO Doctor_Especialidad (id_doctor, id_especialidad) VALUES
(1, 1),
(1, 4),
(2, 2),
(3, 3);

INSERT INTO Medicamentos (nombre, principio_activo, stock_actual, stock_minimo) VALUES
('Aspirina', 'Ácido Acetilsalicílico', 500, 100),
('Paracetamol 500mg', 'Acetaminofeno', 10, 100),
('Amoxicilina', 'Amoxicilina trihidrato', 80, 50),
('Inmunoglobulina', 'Gammaglobulina', 0, 5);

INSERT INTO Pacientes (nombre, apellido, fecha_nacimiento, telefono, historial_basico, id_habitacion) VALUES
('Ana', 'Rodríguez', '1985-06-20', '555101010', 'Alergia a la Penicilina', 1),
('Luis', 'Gómez', '2010-01-15', '555202020', 'Ninguno', NULL),
('Marta', 'Sánchez', '1960-11-05', '555303030', 'Hipertensión Crónica', NULL);

INSERT INTO Citas (id_paciente, id_doctor, fecha_hora, motivo, estado) VALUES
(1, 1, NOW() + INTERVAL '1 hour', 'Control Cardiológico post-alta', 'Pendiente'),
(1, 1, NOW() - INTERVAL '5 days', 'Dolor en el pecho', 'Realizada'),
(1, 1, NOW() - INTERVAL '10 days', 'Revisión por alta', 'Realizada'),
(1, 1, NOW() - INTERVAL '15 days', 'Chequeo de presión', 'Realizada'),
(1, 1, NOW() - INTERVAL '20 days', 'Seguimiento', 'Realizada'),
(2, 2, NOW() - INTERVAL '2 months', 'Control de crecimiento', 'Realizada'),
(3, 3, NOW() + INTERVAL '2 days', 'Revisión lunar', 'Pendiente');

INSERT INTO Diagnosticos (id_cita, nombre, descripcion) VALUES
(5, 'Taquicardia Leve', 'Se recomienda reposo absoluto y evitar el consumo de cafeína por dos semanas.'),
(6, 'Gripe Estacional', 'El paciente presenta síntomas típicos de gripe, se le receta paracetamol y reposo.');

INSERT INTO Tratamientos (id_diagnostico, nombre, duracion_dias) VALUES
(1, 'Reposo y Monitoreo', 14),
(2, 'Tratamiento Sintomático', 7);

INSERT INTO Tratamiento_Medicamento (id_tratamiento, id_medicamento, dosis, frecuencia) VALUES
(2, 2, '500mg', 'Cada 8 horas'),
(1, 1, '1un', 'Diaria');