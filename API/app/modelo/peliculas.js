const { DataTypes } = require("sequelize");
const sequelize = require("../config/DBconexion");

const Peliculas = sequelize.define('Peliculas', {
   idPelicula: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
      unique: true,
   },
   Titulo: {
      type: DataTypes.STRING(100),
      allowNull: false,
   },
   Poster: {
      type: DataTypes.STRING(200),
   },
   Resumen: {
      type: DataTypes.TEXT,
      allowNull: false,
   },
   Trailer: {
      type: DataTypes.STRING(200),
      defaultValue: '1900',
   },
   idCategoria: {
      type: DataTypes.INTEGER,
      defaultValue: 0,
   },
}, {
   tableName : 'peliculas',
   timestamps : false,
});

module.exports = Peliculas;

/*
CREATE TABLE `Peliculas` (
	`idPelicula` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`Titulo` varchar(100) NOT NULL,
	`Poster` varchar(200),
	`Resumen` TEXT NOT NULL,
	`Trailer` varchar(200) DEFAULT '1900',
	`idCategoria` INT DEFAULT '0',
	PRIMARY KEY (`idPelicula`)
);
 */