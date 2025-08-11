
create database laboratorio;
go

use laboratorio;
go

-- tabla aerolineas
create table aerolineas (
    codaerolinea varchar(10) primary key not null,
    nombre nvarchar(100) not null
);

insert into aerolineas (codaerolinea, nombre)
values
    ('la', 'latam airlines'),
    ('aa', 'american airlines'),
    ('ib', 'iberia'),
    ('av', 'aerolíneas argentinas');

	drop table ciudades 
-- tabla ciudades
create table ciudades (
    id_ciudad int primary key,
    nombre varchar(100) not null,
    pais varchar(100) not null,
    codaeropuerto varchar(10) not null unique
);

insert into ciudades (id_ciudad, nombre, pais, codaeropuerto)
values 
    (1,'buenos aires', 'argentina', 'eze'),
    (2,'santiago', 'chile', 'scl'),
    (3,'miami', 'estados unidos', 'mia'),
    (4,'madrid', 'españa', 'mad'),
    (5,'lima', 'perú', 'lim');

-- tabla aviones
create table aviones (
    id_avion int primary key,
    modelo varchar(100) not null,
    capacidad int not null,
    codaerolinea varchar(10) not null,
    foreign key (codaerolinea) references aerolineas(codaerolinea)
);

insert into aviones (id_avion, modelo, capacidad, codaerolinea)
values 
    (1,'boeing 737-800', 186, 'av'),
    (2,'airbus a320', 180, 'la'),
    (3,'boeing 787 dreamliner', 290, 'aa'),
    (4,'airbus a350', 348, 'ib'),
    (5,'embraer 190', 100, 'av');



-- tabla vuelos
create table vuelos (
    id_vuelo int primary key,
    num_vuelo varchar(20) not null,
    origen varchar(100) not null,
    destino varchar(100) not null,
    fecha date not null,
    avion int not null,
    foreign key (avion) references aviones(id_avion)
);

insert into vuelos (id_vuelo, num_vuelo, origen, destino, fecha, avion)
values 
    (1,'av123', 'buenos aires', 'méxico df', '2023-11-15', 1),
    (2,'la456', 'santiago', 'lima', '2023-11-16', 2),
    (3,'aa789', 'miami', 'madrid', '2023-11-17', 3);

	--consultas en proceso de creacion de la bd 
select Max (id_vuelo) as id
from vuelos

select * from vuelos

update vuelos
set num_vuelo = 'AV234',
origen = 'San Jose',
destino = 'México DF',
fecha = '2005-08-08',
avion = 1
where id_vuelo = 1


-- tabla pasajeros
create table pasajeros (
    id_pasajero int primary key,
    nombre varchar(100) not null,
    apellido varchar(100) not null,
    pasaporte varchar(50) not null unique,
    email varchar(100),
    telefono varchar(20)
);

insert into pasajeros (id_pasajero, nombre, apellido, pasaporte, email, telefono)
values
    (1,'juan', 'pérez', 'ab123456', 'juan.perez@gmail.com', '+541112345678'),
    (2,'maría', 'gómez', 'cd789012', 'maria.gomez@gmail.com', '+50689312894');

-- tabla tarifas
create table tarifas (
    id_tarifa int primary key,
    id_vuelo int not null,
    clase varchar(50) not null,
    precio decimal(10,2) not null,
    foreign key (id_vuelo) references vuelos(id_vuelo)
);

insert into tarifas (id_tarifa, id_vuelo, clase, precio)
values
    (1, 1, 'turista', 500.00),
    (2, 1, 'ejecutiva', 1200.00),
    (3, 2, 'turista', 350.00);

-- tabla reservas
create table reservas (
    id_reserva int primary key,
    id_vuelo int not null,
    id_pasajero int not null,
    num_asiento varchar(10) not null,
    estado varchar(20) not null,
    foreign key (id_vuelo) references vuelos(id_vuelo),
    foreign key (id_pasajero) references pasajeros(id_pasajero)
);

insert into reservas (id_reserva, id_vuelo, id_pasajero, num_asiento, estado)
values 
    (1, 1, 1, 'a12', 'confirmado'),
    (2, 1, 2, 'b05', 'pendiente'),
    (3, 2, 1, 'c08', 'confirmado');

	--consultas en proceso de creacion de la bd 
select max(id_reserva) as id 
from reservas;

select * from reservas;

update reservas
set id_vuelo = 1,
    id_pasajero = 1,
    num_asiento = 'a14',
    estado = 'pendiente'
where id_reserva = 1;

   --creacion de roles y usuarios (admin, operador, consulta, seguridad

-- 1. Crear roles a nivel base de datos
CREATE ROLE rol_admin;
CREATE ROLE rol_operador;
CREATE ROLE rol_consulta;
CREATE ROLE rol_seguridad;

-- 2. Crear logins y usuarios
CREATE LOGIN usr_admin_vuelos WITH PASSWORD = 'AdminAerolinea2025';
CREATE USER usr_admin_vuelos FOR LOGIN usr_admin_vuelos;

CREATE LOGIN usr_operador_vuelos WITH PASSWORD = 'OperadorAerolinea2025';
CREATE USER usr_operador_vuelos FOR LOGIN usr_operador_vuelos;

CREATE LOGIN usr_consulta_vuelos WITH PASSWORD = 'ConsultaAerolinea2025';
CREATE USER usr_consulta_vuelos FOR LOGIN usr_consulta_vuelos;

CREATE LOGIN usr_seguridad_vuelos WITH PASSWORD = 'SeguridadAerolinea2025';
CREATE USER usr_seguridad_vuelos FOR LOGIN usr_seguridad_vuelos;

-- 3. Asignacion de usuarios a los respectivos roles 
ALTER ROLE rol_admin ADD MEMBER usr_admin_vuelos;
ALTER ROLE rol_operador ADD MEMBER usr_operador_vuelos;
ALTER ROLE rol_consulta ADD MEMBER usr_consulta_vuelos;
ALTER ROLE rol_seguridad ADD MEMBER usr_seguridad_vuelos;

-- 4. Otorgar permisos a sus respectivos roles por ende a los usuarios 
GRANT CONTROL ON DATABASE::laboratorio TO rol_admin; --acceso total

GRANT SELECT, INSERT, UPDATE, DELETE ON aerolineas TO rol_operador;
GRANT SELECT, INSERT, UPDATE, DELETE ON aviones TO rol_operador;
GRANT SELECT, INSERT, UPDATE, DELETE ON vuelos TO rol_operador;
GRANT SELECT, INSERT, UPDATE, DELETE ON tarifas TO rol_operador;
GRANT SELECT, INSERT, UPDATE, DELETE ON reservas TO rol_operador;
GRANT SELECT, INSERT, UPDATE, DELETE ON pasajeros TO rol_operador;

GRANT SELECT ON SCHEMA::dbo TO rol_consulta;

GRANT SELECT ON aerolineas TO rol_consulta;
GRANT SELECT ON aviones TO rol_consulta;
GRANT SELECT ON vuelos TO rol_consulta;
GRANT SELECT ON tarifas TO rol_consulta;
GRANT SELECT ON reservas TO rol_consulta;
GRANT SELECT ON pasajeros TO rol_consulta;

GRANT SELECT ON aerolineas TO rol_seguridad;
GRANT SELECT ON aviones TO rol_seguridad;
GRANT SELECT ON vuelos TO rol_seguridad;
GRANT SELECT ON tarifas TO rol_seguridad;
GRANT SELECT ON reservas TO rol_seguridad;
GRANT SELECT ON pasajeros TO rol_seguridad;

--asignacion granular de privilegios 
-- Quitar permisos generales sobre esa table de pasajeros
REVOKE SELECT ON pasajeros FROM rol_consulta;

-- Otorgar SELECT solo a columnas específicas
GRANT SELECT (id_pasajero, nombre, apellido, pasaporte)
ON pasajeros
TO rol_consulta;

  --asignacion #2
  -- Quitar permiso general del update
REVOKE UPDATE ON reservas FROM rol_operador;

  -- Permitir solo UPDATE en la columna de 'estado'
GRANT UPDATE (estado)
ON reservas
TO rol_operador;

  --asignacion#3
-- 1. Función que define el filtro
CREATE FUNCTION fn_vuelos_futuros(@id_vuelo INT)
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN SELECT 1 AS acceso
WHERE EXISTS (
    SELECT 1
    FROM dbo.vuelos
    WHERE id_vuelo = @id_vuelo
      AND fecha >= CAST(GETDATE() AS DATE)
);

-- 2. Política de seguridad  fuente : https://www.sqlshack.com/row-level-security-in-sql-server-2016
CREATE SECURITY POLICY vuelos_policy
ADD FILTER PREDICATE dbo.fn_vuelos_futuros(id_vuelo)
ON dbo.vuelos
WITH (STATE = ON);
--cualquier select o update que hagan con ese rol solo va a devolver vuelos futuros, vuelos a partir de la fecha de la consulta por ejemplo, sin importar si estan dispo o no


--Políticas de seguridad y encriptación de campos sensibles
use master;
-- Clave simetrica
CREATE SYMMETRIC KEY ClavePasajeros
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE CertificadoPasajeros;

-- Abrir clave y se cifran los datos
OPEN SYMMETRIC KEY ClavePasajeros
DECRYPTION BY CERTIFICATE CertificadoPasajeros;

UPDATE pasajeros
SET pasaporte = EncryptByKey(Key_GUID('ClavePasajeros'), CONVERT(VARCHAR(50), pasaporte));


CLOSE SYMMETRIC KEY ClavePasajeros;


-- Triggers y funciones para reglas de negocio.CREATE TABLE auditoria_pasajeros (
    id_auditoria INT IDENTITY PRIMARY KEY,
    id_pasajero INT,
    accion VARCHAR(50),
    fecha DATETIME,
    usuario VARCHAR(100)
);--se guarda en la tabla la accion, fecha y usuario que ejecito el comandoCREATE TRIGGER trg_auditar_pasajero
ON pasajeros
AFTER INSERT
AS
BEGIN
INSERT INTO auditoria_pasajeros (id_pasajero, accion, fecha, usuario)
SELECT id_pasajero, 'INSERT', GETDATE(), SUSER_SNAME()
FROM inserted;
END;--funcion que se usa para calcular la edad de los pasajerosCREATE FUNCTION dbo.fn_calcular_edad (@fecha_nac DATE)
RETURNS INT
AS
BEGIN
DECLARE @edad INT;
SET @edad = DATEDIFF(YEAR, @fecha_nac, GETDATE());

    -- Ajuste si aún no ha cumplido años en el año
IF (MONTH(@fecha_nac) > MONTH(GETDATE())) 
OR (MONTH(@fecha_nac) = MONTH(GETDATE()) AND DAY(@fecha_nac) > DAY(GETDATE()))
SET @edad = @edad - 1;

RETURN @edad;
END;
GO

--Vistas, consultas con funciones de ventana y múltiples JOIN’s.
CREATE OR ALTER VIEW vw_AvionesAerolineas AS
SELECT 
a.id_avion,
a.modelo,
a.capacidad,
ae.nombre AS aerolinea
FROM aviones a
JOIN aerolineas ae 
ON a.codaerolinea = ae.codaerolinea;

--manera de verificar la consulta 
SELECT * FROM vw_AvionesAerolineas;

--funciones de ventana (selecciona los aviones segun su capacidad, de mayor a menor)
SELECT 
a.id_avion,
a.modelo,
a.capacidad,
al.nombre AS aerolinea,
 ROW_NUMBER() OVER (ORDER BY a.capacidad DESC) AS ranking_capacidad
FROM aviones a
JOIN aerolineas al ON a.codaerolinea = al.codaerolinea;

--la capacidad acumulada segun cada aerolinea
SELECT 
al.nombre AS aerolinea,
a.modelo,
a.capacidad,
SUM(a.capacidad) OVER (PARTITION BY al.codaerolinea) AS capacidad_total_aerolinea
FROM aviones a
JOIN aerolineas al ON a.codaerolinea = al.codaerolinea;

--multiples joins
SELECT 
v.id_vuelo,
v.num_vuelo,
v.origen,
v.destino,
v.fecha,
a.id_avion,
a.modelo,
a.capacidad,
al.codaerolinea,
al.nombre AS aerolinea
FROM aerolineas al
JOIN aviones a 
ON al.codaerolinea = a.codaerolinea
LEFT JOIN vuelos v 
ON v.avion = a.id_avion;


--Plan de backup's y estrategias de recuperación.
-- Backup completo
BACKUP DATABASE AerolineasDB
TO DISK = 'C:\Backups\Aerolineas_Full.bak'
WITH INIT, COMPRESSION;

-- Backup diferencial
BACKUP DATABASE AerolineasDB
TO DISK = 'C:\Backups\Aerolineas_Diff.bak'
WITH DIFFERENTIAL, COMPRESSION;

-- Backup de log de transacciones
BACKUP LOG AerolineasDB
TO DISK = 'C:\Backups\Aerolineas_Log.trn'
WITH COMPRESSION;
