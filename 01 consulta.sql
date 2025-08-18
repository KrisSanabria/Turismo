--En lista los nombres de los clientes y los destinos de sus reservas, siempre y cuando los clientes tengan de apellido Benítez y su destino sea Cataratas del Iguazú--
SELECT C.nombre,C.apellido,D.nombre AS destino,D.pais
FROM Cliente C
INNER JOIN Reserva R ON C.dni = R.dni
INNER JOIN Destino D ON R.idDestino = D.idDestino
WHERE C.apellido = 'BenÍtez'
AND  D.nombre = 'Cataratas del Iguazú' ;


--Mostrar los nombres de los hoteles en los que haya menos de 2 reservas ordenadas de menor a mayor.
SELECT H.nombre, COUNT(R.idReserva) AS 'TotaldeReservas'
FROM Hotel H
INNER JOIN Reserva R ON H.idHotel = R.idHotel
GROUP BY H.nombre
HAVING  COUNT(idReserva) < 2
ORDER BY H.nombre ASC;


--Lista todas las reservas y sus costos totales--
SELECT idReserva, SUM(costo) AS costo_total
FROM Reserva
GROUP BY idReserva;


--Contar cuántas personas han reservado por cada destino.--

SELECT D.nombre AS destino, SUM(R.cantidapersonas) AS total_personas
FROM Reserva R
INNER JOIN Destino D ON R.idDestino = D.idDestino
GROUP BY D.nombre;


--Nombrar los hoteles con el número total de reservas y solo aquellos cuyo nombre tenga más de 5 caracteres y ordenarlos de mayor a menor--
SELECT H.nombre, COUNT(R.idReserva) AS totalreservas
FROM Hotel H
INNER JOIN Reserva R ON H.idHotel= R.idHotel
WHERE CHAR_LENGTH(H.nombre) > 5
GROUP BY H.nombre
ORDER BY totalreservas DESC;