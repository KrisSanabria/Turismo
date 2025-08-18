
--Mostrar hoteles con menos de 20 reservas--
DELIMITER $$
DROP PROCEDURE sp_HotelesConPocasReservas $$
CREATE PROCEDURE sp_HotelesConPocasReservas()
BEGIN
   SELECT h.nombre, COUNT(r.idReserva) AS cantidad_reservas
   FROM Hotel h
   LEFT JOIN Reserva r ON h.idHotel = r.idHotel
   GROUP BY h.idHotel
   HAVING COUNT(r.idReserva) < 20
   ORDER BY cantidad_reservas ASC;
END $$


--Mostrar clientes que no tengan correo con dominio @gmail.com--
DELIMITER $$
DROP PROCEDURE sp_ClientesSinGmail $$
CREATE PROCEDURE sp_ClientesSinGmail()
BEGIN
   SELECT dni, nombre, apellido, Correo
   FROM Cliente
   WHERE Correo NOT LIKE '%@gmail.com';
END $$


--Mostrar cuántas reservas hay por hotel, con su nombre
DELIMITER $$
DROP PROCEDURE sp_ReservasPorHotel $$
CREATE PROCEDURE sp_ReservasPorHotel()
BEGIN
   SELECT h.nombre, COUNT(r.idReserva) AS total_reservas
   FROM Hotel h
   LEFT JOIN Reserva r ON h.idHotel = r.idHotel
   GROUP BY h.idHotel;
END $$



--Buscar encargados por apellido parcial--

DELIMITER $$
DROP PROCEDURE sp_BuscarEncargado $$
CREATE PROCEDURE sp_BuscarEncargado(IN p_apellido VARCHAR(45))
BEGIN
   SELECT * FROM Encargados
   WHERE apellido LIKE CONCAT('%', p_apellido, '%');
END $$



--Mostrar hoteles sin reservas--
DELIMITER $$
DROP PROCEDURE sp_HotelesSinReservas $$
CREATE PROCEDURE sp_HotelesSinReservas()
BEGIN
   SELECT h.nombre
   FROM Hotel h
   LEFT JOIN Reserva r ON h.idHotel = r.idHotel
   WHERE r.idReserva IS NULL;
END $$
