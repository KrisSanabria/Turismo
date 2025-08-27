--trigger BEFORE INSERT en la tabla ReservaActividad. Este trigger verificará la cantidad total de personas en las reservas
--existentes para una actividad específica y comparará esa suma con el límite permitido. Si la suma supera el límite,
--se generará un error y no se permitirá la inserción.


DELIMITER $$
CREATE TRIGGER check_limite_cantidad_personas
BEFORE INSERT ON Reserva
FOR EACH ROW
BEGIN
   DECLARE total_personas INT;
  
 SELECT SUM(r.cantidapersonas)
 INTO total_personas
 FROM Reserva r
 JOIN ReservaActividad ra ON r.idReserva = ra.idReserva
 WHERE ra.idTipo = NEW.idTipo;


 IF total_personas + (SELECT cantidapersonas FROM Reserva WHERE idReserva = NEW.idReserva) > 50 THEN
   SIGNAL SQLSTATE '45000'
   SET MESSAGE_TEXT = 'Límite de personas para esta actividad excedido';
 END IF;
END $$


2)--Antes de hacer un Insert en Reserva, si el guía ya tiene 3 reservas para las actividades ese mismo día,
--no se debe permitir el Insert y debe mostrarse el mensaje "El guía ya tiene 3 reservas para esta actividad en este día".


DELIMITER $$
CREATE TRIGGER check_limite_reservas_actividad
BEFORE INSERT ON Reserva
FOR EACH ROW
BEGIN
 DECLARE count_reservas INT;


 -- Contar las reservas existentes para la actividad y el guía en el mismo día
 SELECT COUNT(*) INTO count_reservas
 FROM Reserva r
 JOIN ReservaActividad ra ON r.idReserva = ra.idReserva
 WHERE r.idGuia = NEW.idGuia
   AND ra.idTipo = NEW.idTipo
   AND DATE(r.fechaHora) = DATE(NEW.fechaHora);


 -- Verificar si el número de reservas es mayor o igual al límite (3 o 4)
 IF count_reservas >= 3 THEN
   SIGNAL SQLSTATE '45000'
   SET MESSAGE_TEXT = 'El guía ya tiene 3 reservas para esta actividad en este día';
 END IF;
END $$


3)--Se requiere crear un trigger que se ejecute antes de insertar un nuevo registro en la tabla Pago.
--El objetivo es verificar que el idMetodoPago ingresado exista previamente en la tabla MetodosDePago.


--Si el método de pago no existe,
--el trigger debe cancelar la operación e informar al usuario con un mensaje de error.


DELIMITER $$
CREATE TRIGGER verificar_metodo_pago
BEFORE INSERT ON Pago
FOR EACH ROW
BEGIN
   DECLARE existeMetodo INT;


   SELECT COUNT(*) INTO existeMetodo
   FROM MetodosDePago
   WHERE idMetodoPago = NEW.idMetodoPago;


   IF existeMetodo = 0 THEN
       SIGNAL SQLSTATE '45000'
       SET MESSAGE_TEXT = 'Error: El método de pago especificado no existe.';
   END IF;
END $$



