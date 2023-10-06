const { DataTypes } = require("sequelize");
const sequelize = require("../config/DBconexion");

const Generos = sequelize.define('Generos', {
   idGenero: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
      unique: true,
   },
   Detalle: {
      type: DataTypes.STRING(50),
      allowNull: false,
   },
}, {
   tableName : 'generos',
   timestamps : false,
});

module.exports = Generos
;

/*
CREATE TABLE `Generos` (
	`idGenero` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`Detalle` varchar(50) NOT NULL,
	PRIMARY KEY (`idGenero`)
);
 */