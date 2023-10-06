const { DataTypes } = require("sequelize");
const sequelize = require("../config/DBconexion");

const Categoria = sequelize.define('Categoria', {
   idCategoria: {
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
   tableName : 'categorias',
   timestamps : false,
});

module.exports = Categoria;


/*
CREATE TABLE `Categorias` (
	`idCategoria` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`Nombre` varchar(50) NOT NULL,
	PRIMARY KEY (`idCategoria`)
);
 */