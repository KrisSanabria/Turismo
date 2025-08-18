

-- -----------------------------------------------------
-- Schema bd_Turismo
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `bd_Turismo` ;

-- -----------------------------------------------------
-- Schema bd_Turismo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bd_Turismo` DEFAULT CHARACTER SET utf8 ;
USE `bd_Turismo` ;


-- -----------------------------------------------------
-- Table `Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cliente` (
 `dni` INT UNSIGNED NOT NULL,
 `nombre` VARCHAR(45) NOT NULL,
 `apellido` VARCHAR(45) NOT NULL,
 `Correo` VARCHAR(45) NOT NULL,
 `telefono` INT UNSIGNED NOT NULL,
 PRIMARY KEY (`dni`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hotel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hotel` (
 `nombre` VARCHAR(45) NOT NULL,
 `dirección` VARCHAR(45) NOT NULL,
 `telefono` INT NOT NULL,
 `idHotel` TINYINT NOT NULL,
 PRIMARY KEY (`idHotel`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TipoActividad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TipoActividad` (
 `tipo` VARCHAR(45) NOT NULL,
 `idTipo` TINYINT NOT NULL,
 PRIMARY KEY (`idTipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Encargados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Encargados` (
 `nombre` VARCHAR(45) NOT NULL,
 `apellido` VARCHAR(45) NOT NULL,
 `dni` INT NOT NULL,
 PRIMARY KEY (`dni`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Guia_Turistica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Guia_Turistica` (
 `idGuia` TINYINT NOT NULL,
 `horario` TIME NOT NULL,
 `duracion` TIME NOT NULL,
 `idTipo` TINYINT NOT NULL,
 `dni` INT NOT NULL,
 `idServicio` TINYINT NOT NULL,
 PRIMARY KEY (`idGuia`),
 INDEX `fk_Guia_Turistica_TipoActividad1_idx` (`idTipo` ASC) VISIBLE,
 INDEX `fk_Guia_Turistica_Encargados1_idx` (`dni` ASC) VISIBLE,
 CONSTRAINT `fk_Guia_Turistica_TipoActividad1`
   FOREIGN KEY (`idTipo`)
   REFERENCES `TipoActividad` (`idTipo`)
   ON DELETE NO ACTION
   ON UPDATE NO ACTION,
 CONSTRAINT `fk_Guia_Turistica_Encargados1`
   FOREIGN KEY (`dni`)
   REFERENCES `Encargados` (`dni`)
   ON DELETE NO ACTION
   ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Destino`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Destino` (
 `idDestino` TINYINT NOT NULL,
 `nombre` VARCHAR(45) NOT NULL,
 `pais` VARCHAR(45) NOT NULL,
 PRIMARY KEY (`idDestino`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Reserva` (
 `idReserva` TINYINT NOT NULL,
 `fechaHora` DATETIME NOT NULL,
 `costo` FLOAT NOT NULL,
 `idHotel` TINYINT NOT NULL,
 `idGuia` TINYINT NOT NULL,
 `cantidapersonas` TINYINT UNSIGNED NOT NULL,
 `dni` INT UNSIGNED NOT NULL,
 `idDestino` TINYINT NOT NULL,
 PRIMARY KEY (`idReserva`),
 INDEX `fk_Reserva_Cliente1_idx` (`dni` ASC) VISIBLE,
 INDEX `fk_Reserva_Hotel1_idx` (`idHotel` ASC) VISIBLE,
 INDEX `fk_Reserva_Guia Turistica1_idx` (`idGuia` ASC) VISIBLE,
 INDEX `fk_Reserva_Destino1_idx` (`idDestino` ASC) VISIBLE,
 CONSTRAINT `fk_Reserva_Cliente1`
   FOREIGN KEY (`dni`)
   REFERENCES `Cliente` (`dni`)
   ON DELETE NO ACTION
   ON UPDATE NO ACTION,
 CONSTRAINT `fk_Reserva_Hotel1`
   FOREIGN KEY (`idHotel`)
   REFERENCES `Hotel` (`idHotel`)
   ON DELETE NO ACTION
   ON UPDATE NO ACTION,
 CONSTRAINT `fk_Reserva_Guia Turistica1`
   FOREIGN KEY (`idGuia`)
   REFERENCES `Guia_Turistica` (`idGuia`)
   ON DELETE NO ACTION
   ON UPDATE NO ACTION,
 CONSTRAINT `fk_Reserva_Destino1`
   FOREIGN KEY (`idDestino`)
   REFERENCES `Destino` (`idDestino`)
   ON DELETE NO ACTION
   ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Transporte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Transporte` (
 `patente` VARCHAR(6) NOT NULL,
 `idDestino` TINYINT NOT NULL,
 PRIMARY KEY (`patente`),
 INDEX `fk_Transporte_Destino1_idx` (`idDestino` ASC) VISIBLE,
 CONSTRAINT `fk_Transporte_Destino1`
   FOREIGN KEY (`idDestino`)
   REFERENCES `Destino` (`idDestino`)
   ON DELETE NO ACTION
   ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GuiaTuristica_Servicioalcliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GuiaTuristica_Servicioalcliente` (
 `idServicio` TINYINT NOT NULL,
 `idGuia` TINYINT NOT NULL,
 PRIMARY KEY (`idServicio`, `idGuia`),
 INDEX `fk_GuiaTuristica_Servicioalcliente_Guia Turistica1_idx` (`idGuia` ASC) VISIBLE,
 CONSTRAINT `fk_GuiaTuristica_Servicioalcliente_Guia Turistica1`
   FOREIGN KEY (`idGuia`)
   REFERENCES `Guia_Turistica` (`idGuia`)
   ON DELETE NO ACTION
   ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Servicioalcliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Servicioalcliente` (
 `idServicio` TINYINT NOT NULL,
 `tipodeservicio` VARCHAR(45) NOT NULL,
 PRIMARY KEY (`idServicio`),
 CONSTRAINT `fk_Servicioalcliente_GuiaTuristica_Servicioalcliente1`
   FOREIGN KEY (`idServicio`)
   REFERENCES `GuiaTuristica_Servicioalcliente` (`idServicio`)
   ON DELETE NO ACTION
   ON UPDATE NO ACTION)
ENGINE = InnoDB;



INSERT INTO Cliente (dni, nombre, apellido, correo, telefono)
VALUES (47431364, 'Laura', 'benitez', 'laurabenitez@gmail.com', 1109362456) ,
     (34567890, 'Liam', 'jimenez', 'liamjimenez@gmail.com', 1145784367) , 
     (36543210,'Ruby','Villalobos','rubyvillalobos@gmail.com',1178235629),
     (27873254,'Robert','Pattinson','ellobo@gmail.com',23658997);








    INSERT INTO Hotel (nombre, dirección, telefono, idHotel)
VALUES ('Hotel Realeza', 'Angel dimaria 5678', 1145678942, 15) ,
     ('Queen Hotel', 'Tucuman 541', 1156673256, 16) ,
     ('Hotel Transylvania','Flor de Otoño, 1134687156',17),
     ('Sherathon',' San Martín 1225', 1143189000,18);


  
    INSERT INTO TipoActividad (idTipo, tipo)
VALUES ( 6, 'KAYAK') ,
     ( 7, 'Tirolesa') ,
     (8,'Senderismo'),
     (9,'Ciclismo');
  
INSERT INTO Encargados (dni, nombre, apellido)
VALUES (24675346, 'Joaquin', 'britez') ,
     (83156823, 'Kristen', 'Dicaprio') ,
     (28189919, 'Jorge', 'Queseyo'),
     (21451216, 'Marcos','Duran');
  
  
INSERT INTO Guia_Turistica (idGuia, horario, duracion, idTipo, dni, idServicio)
VALUES (10, '16:00','2:00' , 6,24675346, 8 ) ,
     (11, '17:00', '1:00', 7, 83156823, 9 ) ,
     (12,'11:00','5:00',8,28189919,10),
     (13,'13:00','3:00',9,21451216,11);
  
INSERT INTO Destino (idDestino, nombre, pais)
VALUES (4, 'cataratas del iguazu', 'Argentina') ,
     (5, 'Misiones', 'Argentina' ),
     (6,'Transylvania','Rumanía'),
     (7,'Retiro','Argentina');
 
INSERT INTO Reserva (idReserva, fechaHora, costo, idDestino, idHotel, idGuia, cantidapersonas, dni)
VALUES ( 2, '2026-05-19',30000, 4, 15, 10, 5 ,47431364) ,
     ( 3, '2025-12-09', 50000, 5,  16, 11, 3 ,34567890),
     (4,'2025-11-06',200000,6,17,12,4,36543210),
     (5,'2026-02-04',60000,7,18,13,4,27873254);


INSERT INTO Transporte (patente, idDestino)
VALUES ('NVZ087', 4) ,
     ('DDM957', 5) ,
     ('FRYDJ7',6),
     ('KJSTI94',7);
INSERT INTO GuiaTuristica_Servicioalcliente (idServicio, idGuia)
VALUES (8, 10) ,
     (9, 11) ,
     (10,12),
     (11,13);

     
INSERT INTO Servicioalcliente (idServicio, tipodeservicio)
VALUES ( 8, 'Fotos') ,
     ( 9, 'Souvenir') ,
     (10, 'Asistencia de planificación'),
     (11,'Estacionamiento');