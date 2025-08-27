--Saber qué países son los más elegidos nos permite planificar promociones, alianzas con hoteles o guías en esos destinos, o ajustar precios --
DELIMITER $$
CREATE PROCEDURE paisesMasVisitados()
BEGIN
 SELECT D.pais, COUNT(*) AS cantidadReservas
 FROM Reserva R
 JOIN Destino D ON R.idDestino = D.idDestino
 GROUP BY D.pais
 ORDER BY cantidadReservas DESC;
END $$
--Listar todas las reservas que tienen estado 'Pendiente  para saber qué clientes aún no confirmaron su viaje o no completaron el pago --
DELIMITER $$
CREATE PROCEDURE reservasPendientes()
BEGIN
   SELECT R.idReserva, C.nombre, C.apellido, D.nombre AS destino, R.fechaHora
   FROM Reserva R
   JOIN Clientes C ON R.dni = C.dni
   JOIN Destino D ON R.idDestino = D.idDestino
   WHERE R.Estado = 'Pendiente';
END $$




--Hacer un procedimiento que muestre los destinos más reservados por los clientes y ordenarlo de mayor a menor.
DELIMITER $$
CREATE PROCEDURE destinosMasReservados()
BEGIN
   SELECT D.nombre, D.pais, COUNT(*) AS cantidadReservas
   FROM Reserva R
   JOIN Destino D ON R.idDestino = D.idDestino
   GROUP BY D.idDestino, D.nombre, D.pais
   ORDER BY cantidadReservas DESC;
END $$



