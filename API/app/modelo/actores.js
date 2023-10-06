const { DataTypes } = require("sequelize");
const sequelize = require("../config/DBconexion");

const Actores = sequelize.define('Actores', {
   idActor: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
      unique: true,
   },
      Nombre: {
      type: DataTypes.STRING(50),
      allowNull: false,
   },
}, {
   tableName : 'actores',
   timestamps : false,
});

module.exports = Actores;

/*
CREATE TABLE `Actores` (
	`idActor` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`Nombre` varchar(50) NOT NULL,
	PRIMARY KEY (`idActor`)
);
 */