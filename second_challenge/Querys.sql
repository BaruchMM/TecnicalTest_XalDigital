-- Mayor numero de movimientos por aeropuerto
create table `MovPorAeropuerto` (
	`ID_AEROPUERTO` int NOT NULL,
	`NOMBRE_AEROPUERTO` varchar(100) NOT NULL,
    `DIA` date NOT NULL,
    `movimientos` int NOT NULL
);

insert into movporaeropuerto
select u.ID_AEROPUERTO, u.NOMBRE_AEROPUERTO, p.DIA, COUNT(u.ID_AEROPUERTO) AS movimientos 
from aeropuerto u left join VUELOS p on u.ID_AEROPUERTO = p.ID_AEROPUERTO
GROUP BY 1 HAVING COUNT(u.ID_AEROPUERTO) > 0
ORDER BY movimientos DESC;

SELECT NOMBRE_AEROPUERTO FROM movporaeropuerto
WHERE movimientos = (SELECT max(movimientos) FROM movporaeropuerto);

-- Aerolínea que ha realizado mayor número de vuelos durante el año
create table `MovPorAerolinea` (
	`ID_AEROLINEA` int NOT NULL,
	`NOMBRE_AEROLINEA` varchar(100) NOT NULL,
    `DIA` date NOT NULL,
    `movimientos` int NOT NULL
);

insert into movporaerolinea
select u.ID_AEROLINEA, u.NOMBRE_AEROLINEA, p.DIA, COUNT(u.ID_AEROLINEA) AS movimientos 
from AEROLINEA u left join VUELOS p on u.ID_AEROLINEA = p.ID_AEROLINEA
GROUP BY 1 HAVING COUNT(u.ID_AEROLINEA) > 0
ORDER BY movimientos DESC;

SELECT NOMBRE_AEROLINEA FROM movporaerolinea
WHERE movimientos = (SELECT max(movimientos) FROM movporaeropuerto);

-- Día se han tenido mayor número de vuelos
create table `MovPorDia` (
    `DIA` date NOT NULL,
    `movimientos` int NOT NULL
);
insert into MovPorDia
select DIA, COUNT(DIA) AS movimientos 
from VUELOS
GROUP BY 1 HAVING COUNT(DIA) > 0
ORDER BY movimientos DESC;

SELECT DIA, MAX(movimientos) AS max_movimientos
FROM MovPorDia;

-- Aerolíneas que tienen mas de 2 vuelos por día
create table `MovPorDiaYId` (
    `DIA` date NOT NULL,
    `NOMBRE_AEROLINEA` VARCHAR(100) NOT NULL,
    `movimientos` INT NOT NULL
);
insert into MovPorDiaYId
select p.DIA, u.NOMBRE_AEROLINEA, COUNT(u.NOMBRE_AEROLINEA) AS movimientos 
from AEROLINEA u left join VUELOS p on u.ID_AEROLINEA = p.ID_AEROLINEA
GROUP BY p.DIA, u.NOMBRE_AEROLINEA, 1 HAVING COUNT(u.NOMBRE_AEROLINEA) > 1
ORDER BY p.DIA DESC;

SELECT * FROM second_challenge.movpordiayid;
