DROP SCHEMA IF EXISTS RENTAUTO;
CREATE SCHEMA RENTAUTO; USE RENTAUTO;

CREATE TABLE `RENTAUTO`.`Usuario`( 
`NOMBRE` VARCHAR(255)  NOT NULL,
`APELLIDO` VARCHAR(255)  NOT NULL,
`IDNOMBRE` VARCHAR(255)  NOT NULL,  
`PASSWORD` VARCHAR(255) NOT NULL,  
`FECHADENACIMIENTO` DATE,
`EMAIL` VARCHAR(255)  NOT NULL,
`CODIGODEVALIDACION` VARCHAR(255) ,
`ESTADODEVALIDACION` BOOLEAN NOT NULL,
 PRIMARY KEY (`IDNOMBRE`)
);

ENGINE = InnoDB;
