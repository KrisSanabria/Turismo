   
--Contar cuántas reservas tiene un hotel--
DELIMITER $$
CREATE FUNCTION sf_ReservasPorHotel(p_idHotel TINYINT)
RETURNS INT
DETERMINISTIC
BEGIN
   DECLARE total INT;
   SELECT COUNT(*) INTO total
   FROM Reserva
   WHERE idHotel = p_idHotel;
   RETURN total;
END $$


--Obtener nombre completo del cliente--
DELIMITER $$
CREATE FUNCTION sf_NombreCompletoCliente(p_dni INT)
RETURNS VARCHAR(90)
DETERMINISTIC
BEGIN
   DECLARE nombreCompleto VARCHAR(90);
   SELECT CONCAT(nombre, ' ', apellido)
   INTO nombreCompleto
   FROM Cliente
   WHERE dni = p_dni;
   RETURN nombreCompleto;
END $$



--Verificar si un hotel tiene más de 5 reservas--
DELIMITER $$
CREATE FUNCTION sf_HotelTieneMuchasReservas(p_idHotel TINYINT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
   DECLARE cantidad INT;
   SELECT COUNT(*) INTO cantidad
   FROM Reserva
   WHERE idHotel = p_idHotel;
   RETURN cantidad > 5;
END $$


--Obtener cantidad total de los clientes--
DELIMITER $$
CREATE FUNCTION sf_TotalClientes()
RETURNS INT
DETERMINISTIC
BEGIN
   DECLARE total INT;
   SELECT COUNT(*) INTO total FROM Cliente;
   RETURN total;
END $$


--Saber si un cliente existe por DNI--

DELIMITER $$
CREATE FUNCTION sf_ExisteCliente(p_dni INT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
   RETURN EXISTS (
       SELECT 1 FROM Cliente WHERE dni = p_dni
   );
END $$
