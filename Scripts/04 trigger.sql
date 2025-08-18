    
--Trigger que registra cada vez que se crea una reserva--
--Primero creamos la tabla LogReserva:

CREATE TABLE LogReserva (
   id INT AUTO_INCREMENT PRIMARY KEY,
   idReserva INT,
   fechaLog DATETIME
);

DELIMITER $$
CREATE TRIGGER trg_RegistrarReserva
AFTER INSERT ON Reserva
FOR EACH ROW
BEGIN
   INSERT INTO LogReserva (idReserva, fechaLog)
   VALUES (NEW.idReserva, NOW());
END $$


--No permitir reservas para fechas anteriores a hoy--
DELIMITER $$
CREATE TRIGGER trg_VerificarFechaReserva
BEFORE INSERT ON Reserva
FOR EACH ROW
BEGIN
   IF NEW.fecha < CURDATE() THEN
       SIGNAL SQLSTATE '45000'
       SET MESSAGE_TEXT = 'No se puede hacer una reserva para una fecha pasada.';
   END IF;
END $$



--Trigger que avisa si un hotel fue eliminado (log)--

CREATE TABLE LogEliminacionHotel (
   id INT AUTO_INCREMENT PRIMARY KEY,
   nombreHotel VARCHAR(45),
   fecha DATETIME
);


DELIMITER $$
CREATE TRIGGER trg_EliminarHotelLog
AFTER DELETE ON Hotel
FOR EACH ROW
BEGIN
   INSERT INTO LogEliminacionHotel(nombreHotel, fecha)
   VALUES (OLD.nombre, NOW());
END $$


--Validar que teléfono de cliente tenga al menos 8 dígitos--

DELIMITER $$
CREATE TRIGGER befInstrg_TelefonoValidoCliente BEFORE INSERT ON Cliente
FOR EACH ROW
BEGIN
   IF LENGTH(NEW.telefono) < 8 THEN
       SIGNAL SQLSTATE '45000'
       SET MESSAGE_TEXT = 'El teléfono debe tener al menos 8 dígitos.';
   END IF;
END $$


--Al actualizar una reserva, guardar cambio en tabla log--
CREATE TABLE LogCambiosReserva (
   id INT AUTO_INCREMENT PRIMARY KEY,
   idReserva INT,
   fechaCambio DATETIME
);


DELIMITER $$
CREATE TRIGGER trg_LogUpdateReserva
AFTER UPDATE ON Reserva
FOR EACH ROW
BEGIN
   INSERT INTO LogCambiosReserva(idReserva, fechaCambio)
   VALUES (NEW.idReserva, NOW());
END $$







