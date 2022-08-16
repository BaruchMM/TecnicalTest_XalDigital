-- Mayor numero de movimientos por aeropuerto
CREATE TABLE `MovPorAeropuerto` (
	`ID_AEROPUERTO` int NOT NULL,
	`NOMBRE_AEROPUERTO` varchar(100) NOT NULL,
    `DIA` date NOT NULL,
    `movimientos` int NOT NULL
);

INSERT INTO movporaeropuerto
SELECT u.ID_AEROPUERTO, u.NOMBRE_AEROPUERTO, p.DIA, COUNT(u.ID_AEROPUERTO) AS movimientos 
FROM aeropuerto u left join VUELOS p on u.ID_AEROPUERTO = p.ID_AEROPUERTO
GROUP BY 1 HAVING COUNT(u.ID_AEROPUERTO) > 0
ORDER BY movimientos DESC;

SELECT NOMBRE_AEROPUERTO FROM movporaeropuerto
WHERE movimientos = (SELECT MAX(movimientos) FROM movporaeropuerto);

-- Aerolínea que ha realizado mayor número de vuelos durante el año
CREATE TABLE `MovPorAerolinea` (
	`ID_AEROLINEA` int NOT NULL,
	`NOMBRE_AEROLINEA` varchar(100) NOT NULL,
    `DIA` date NOT NULL,
    `movimientos` int NOT NULL
);

INSERT INTO movporaerolinea
SELECT u.ID_AEROLINEA, u.NOMBRE_AEROLINEA, p.DIA, COUNT(u.ID_AEROLINEA) AS movimientos 
FROM AEROLINEA u left join VUELOS p on u.ID_AEROLINEA = p.ID_AEROLINEA
GROUP BY 1 HAVING COUNT(u.ID_AEROLINEA) > 0
ORDER BY movimientos DESC;

SELECT NOMBRE_AEROLINEA FROM movporaerolinea
WHERE movimientos = (SELECT MAX(movimientos) FROM movporaeropuerto);

-- Día se han tenido mayor número de vuelos
CREATE TABLE `MovPorDia` (
    `DIA` date NOT NULL,
    `movimientos` int NOT NULL
);
INSERT INTO MovPorDia
SELECT DIA, COUNT(DIA) AS movimientos 
FROM VUELOS
GROUP BY 1 HAVING COUNT(DIA) > 0
ORDER BY movimientos DESC;

SELECT DIA, MAX(movimientos) AS MAX_movimientos
FROM MovPorDia;

-- Aerolíneas que tienen mas de 2 vuelos por día
CREATE TABLE `MovPorDiaYId` (
    `DIA` date NOT NULL,
    `NOMBRE_AEROLINEA` VARCHAR(100) NOT NULL,
    `movimientos` INT NOT NULL
);
INSERT INTO MovPorDiaYId
SELECT p.DIA, u.NOMBRE_AEROLINEA, COUNT(u.NOMBRE_AEROLINEA) AS movimientos 
FROM AEROLINEA u left join VUELOS p on u.ID_AEROLINEA = p.ID_AEROLINEA
GROUP BY p.DIA, u.NOMBRE_AEROLINEA, 1 HAVING COUNT(p.DIA) > 2
ORDER BY p.DIA DESC;

SELECT * FROM second_challenge.movpordiayid;
