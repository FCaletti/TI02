CREATE TABLE `Peliculas` (
	`idPelicula` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`Titulo` varchar(100) NOT NULL,
	`Poster` varchar(200),
	`Resumen` TEXT NOT NULL,
	`Trailer` varchar(200) DEFAULT '1900',
	`idCategoria` INT(6) DEFAULT '0',
	PRIMARY KEY (`idPelicula`)
);

CREATE TABLE `Generos` (
	`idGenero` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`Detalle` varchar(50) NOT NULL,
	PRIMARY KEY (`idGenero`)
);

CREATE TABLE `PeliculasGeneros` (
	`idPelicula` INT NOT NULL,
	`idGenero` INT NOT NULL,
	PRIMARY KEY (`idPelicula`,`idGenero`)
);

CREATE TABLE `Actores` (
	`idActor` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`Nombre` varchar(50) NOT NULL,
	PRIMARY KEY (`idActor`)
);

CREATE TABLE `PeliculasActores` (
	`idPelicula` INT NOT NULL,
	`idActor` INT NOT NULL,
	PRIMARY KEY (`idPelicula`,`idActor`)
);

CREATE TABLE `Paises` (
	`idPais` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`Nombre` varchar(50) NOT NULL,
	PRIMARY KEY (`idPais`)
);

CREATE TABLE `PeliculasPaises` (
	`idPelicula` INT NOT NULL,
	`idPais` INT NOT NULL,
	PRIMARY KEY (`idPelicula`,`idPais`)
);

CREATE TABLE `Categorias` (
	`idCategoria` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`Nombre` varchar(50) NOT NULL,
	PRIMARY KEY (`idCategoria`)
);

ALTER TABLE `Peliculas` ADD CONSTRAINT `Peliculas_fk0` FOREIGN KEY (`idCategoria`) REFERENCES `Categorias`(`idCategoria`);

ALTER TABLE `PeliculasGeneros` ADD CONSTRAINT `PeliculasGeneros_fk0` FOREIGN KEY (`idPelicula`) REFERENCES `Peliculas`(`idPelicula`);

ALTER TABLE `PeliculasGeneros` ADD CONSTRAINT `PeliculasGeneros_fk1` FOREIGN KEY (`idGenero`) REFERENCES `Generos`(`idGenero`);

ALTER TABLE `PeliculasActores` ADD CONSTRAINT `PeliculasActores_fk0` FOREIGN KEY (`idPelicula`) REFERENCES `Peliculas`(`idPelicula`);

ALTER TABLE `PeliculasActores` ADD CONSTRAINT `PeliculasActores_fk1` FOREIGN KEY (`idActor`) REFERENCES `Actores`(`idActor`);

ALTER TABLE `PeliculasPaises` ADD CONSTRAINT `PeliculasPaises_fk0` FOREIGN KEY (`idPelicula`) REFERENCES `Peliculas`(`idPelicula`);

ALTER TABLE `PeliculasPaises` ADD CONSTRAINT `PeliculasPaises_fk1` FOREIGN KEY (`idPais`) REFERENCES `Paises`(`idPais`);









