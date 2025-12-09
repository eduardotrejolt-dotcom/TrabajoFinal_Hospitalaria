-- 1ra Consulta: Pacientes con más de 3 citas en el último mes.

SELECT
    P.nombre,
    P.apellido,
    COUNT(C.id_cita) AS total_citas_mes
FROM
    Pacientes P
JOIN
    Citas C ON P.id_paciente = C.id_paciente
WHERE
    C.fecha_hora >= NOW() - INTERVAL '1 month'
    AND C.estado = 'Realizada' -- Opcional, pero lógico solo contar citas atendidas
GROUP BY
    P.id_paciente, P.nombre, P.apellido
HAVING
    COUNT(C.id_cita) > 3
ORDER BY
    total_citas_mes DESC;

-- 2da Consulta: Doctores y su cantidad de citas por especialidad (solo citas realizadas).
SELECT
    D.nombre AS doctor_nombre,
    D.apellido AS doctor_apellido,
    E.nombre AS especialidad_nombre,
    COUNT(C.id_cita) AS total_citas_realizadas
FROM
    Doctores D
JOIN
    Citas C ON D.id_doctor = C.id_doctor
JOIN
    Doctor_Especialidad DE ON D.id_doctor = DE.id_doctor
JOIN
    Especialidades E ON DE.id_especialidad = E.id_especialidad
WHERE
    C.estado = 'Realizada'
GROUP BY
    D.id_doctor, E.id_especialidad, D.nombre, D.apellido, E.nombre
ORDER BY
    E.nombre, total_citas_realizadas DESC;

-- 3ra Consulta: Medicamentos con stock menor al mínimo requerido.
SELECT
    nombre,
    stock_actual,
    stock_minimo,
    (stock_minimo - stock_actual) AS diferencia_necesaria
FROM
    Medicamentos
WHERE
    stock_actual < stock_minimo
ORDER BY
    diferencia_necesaria DESC;

-- 4ta Consulta: Habitaciones disponibles por tipo (individual, doble, suite).
SELECT
    tipo,
    COUNT(id_habitacion) AS habitaciones_disponibles
FROM
    Habitaciones
WHERE
    estado = 'Disponible'
GROUP BY
    tipo
ORDER BY
    tipo;

-- 5ta Consulta: Historial médico completo de un paciente específico.

SELECT
    P.nombre AS paciente_nombre,
    P.apellido AS paciente_apellido,
    C.fecha_hora AS fecha_cita,
    D.nombre AS diagnostico,
    T.nombre AS tratamiento_prescrito,
    M.nombre AS medicamento_recetado,
    TM.dosis,
    TM.frecuencia
FROM
    Pacientes P
JOIN
    Citas C ON P.id_paciente = C.id_paciente
LEFT JOIN 
    Diagnosticos D ON C.id_cita = D.id_cita
LEFT JOIN
    Tratamientos T ON D.id_diagnostico = T.id_diagnostico
LEFT JOIN
    Tratamiento_Medicamento TM ON T.id_tratamiento = TM.id_tratamiento
LEFT JOIN
    Medicamentos M ON TM.id_medicamento = M.id_medicamento
WHERE
    P.id_paciente = 1 
ORDER BY
    C.fecha_hora DESC;