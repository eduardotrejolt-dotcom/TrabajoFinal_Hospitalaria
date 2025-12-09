-- 1ra Consulta: Total de Ingresos por Categoría de Productos (Solo Comandas Pagadas)
SELECT
    C.nombre AS categoria,
    SUM(DC.cantidad * DC.precio_unidad) AS ingresos_totales
FROM
    Detalle_Comanda DC
JOIN
    Productos P ON DC.id_producto = P.id_producto
JOIN
    Categorias C ON P.id_categoria = C.id_categoria
JOIN
    Comandas CO ON DC.id_comanda = CO.id_comanda
WHERE
    CO.estado = 'Pagada'
GROUP BY
    C.nombre
ORDER BY
    ingresos_totales DESC;


-- 2da Consulta: Mesero con el Mejor Desempeño en Propinas
SELECT
    M.nombre || ' ' || M.apellido AS nombre_completo_mesero,
    SUM(PA.propina) AS propina_total_generada,
    COUNT(CO.id_comanda) AS total_comandas_cobradas
FROM
    Pagos PA
JOIN
    Comandas CO ON PA.id_comanda = CO.id_comanda
JOIN
    Meseros M ON CO.id_mesero = M.id_mesero
GROUP BY
    M.id_mesero, nombre_completo_mesero
ORDER BY
    propina_total_generada DESC;


-- 3ra Consulta: Costo Total de Ingredientes para un Producto Específico ('Hamburguesa Clásica')
SELECT
    P.nombre AS producto,
    SUM(R.cantidad_necesaria * I.costo_unidad) AS costo_total_ingredientes
FROM
    Productos P
JOIN
    Recetas R ON P.id_producto = R.id_producto
JOIN
    Ingredientes I ON R.id_ingrediente = I.id_ingrediente
WHERE
    P.nombre = 'Hamburguesa Clásica'
GROUP BY
    P.nombre;


-- 4ta Consulta: Productos más Vendidos por Cantidad
SELECT
    P.nombre AS producto,
    C.nombre AS categoria,
    SUM(DC.cantidad) AS total_vendido_unidades
FROM
    Detalle_Comanda DC
JOIN
    Productos P ON DC.id_producto = P.id_producto
JOIN
    Categorias C ON P.id_categoria = C.id_categoria
GROUP BY
    P.id_producto, P.nombre, C.nombre
ORDER BY
    total_vendido_unidades DESC
LIMIT 5;


-- 5ta Consulta: Estado de Ocupación de Mesas con Comandas Abiertas
SELECT
    M.numero AS numero_mesa,
    M.estado AS estado_mesa,
    CO.id_comanda,
    CO.fecha_hora_apertura,
    CO.estado AS estado_comanda
FROM
    Mesas M
JOIN
    Comandas CO ON M.id_mesa = CO.id_mesa
WHERE
    CO.estado IN ('Abierta', 'En Preparacion', 'Lista')
    AND M.estado = 'Ocupada'
ORDER BY
    CO.fecha_hora_apertura ASC;