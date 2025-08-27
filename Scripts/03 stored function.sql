   
--Devuelve la cantidad total de reservas realizadas en un hotel determinado.


CREATE FUNCTION totalReservas(unIdHotel TINYINT)
RETURNS INT
READS SQL DATA
BEGIN
   DECLARE resultado INT;
   SELECT COUNT(*) INTO resultado
   FROM Reserva
   WHERE idHotel = unIdHotel;
   RETURN resultado;
END;




--Devuelve 1 (TRUE) si hay algún transporte que sale en esa fecha, o 0 (FALSE) si no hay ninguno.


CREATE FUNCTION hayTransporteDisponible(fecha DATETIME)
RETURNS BOOLEAN
READS SQL DATA
BEGIN
   DECLARE cantidad INT;
   SELECT COUNT(*) INTO cantidad
   FROM Trasporte
   WHERE DATE(salida) = DATE(fecha);
   RETURN cantidad > 0;
END;



