const { DataTypes } = require("sequelize");
const sequelize = require("../config/DBconexion");

const ViewListadoFull = sequelize.define('ViewListadoFull', {
      ID: {
         type: DataTypes.INTEGER,
         primaryKey: true,
         allowNull: false,
      },
      Poster: {
         type: DataTypes.STRING(200),
      },
      Titulo: {
         type: DataTypes.STRING(100),
      },
      Categoria: {
         type: DataTypes.STRING(50),
      },
      Resumen: {
         type: DataTypes.TEXT,
      },
      Genero: {
        type: DataTypes.STRING, // Esto podría ser una cadena separada por comas
      },
      Temporadas: {
         type: DataTypes.INTEGER,
      },
      Reparto: {
        type: DataTypes.STRING, // Esto podría ser una cadena separada por comas
      },
      Origen: {
        type: DataTypes.STRING, // Esto podría ser una cadena separada por comas
      },
   }, {
   tableName : 'ListadoFull',
   timestamps : false,
});

module.exports = ViewListadoFull;

/*
VIEW `listadofull` AS
select 
	P.idpelicula as ID, 
   P.Poster,
   P.Titulo,
   C.Nombre as Categoria,
   P.Resumen,	
   GROUP_CONCAT(DISTINCT G.Detalle SEPARATOR ', ') as Genero,
	P.Temporadas,
   GROUP_CONCAT(DISTINCT A.Nombre SEPARATOR ', ') as Reparto,
   GROUP_CONCAT(DISTINCT PS.Nombre SEPARATOR ', ') as Origen

FROM peliculas P

INNER JOIN peliculasActores PA
ON PA.idPelicula = P.idPelicula
INNER JOIN actores A
ON A.idActor = PA.idActor

INNER JOIN peliculasGeneros PG
ON PG.idPelicula = P.idPelicula
INNER JOIN generos G
ON G.idGenero = PG.idGenero

INNER JOIN categorias C
ON C.idCategoria = P.idCategoria

INNER JOIN peliculasPaises PP
ON PP.idPelicula = P.idPelicula
INNER JOIN paises PS
ON PS.idPais = PP.idPais

GROUP BY P.idpelicula
;
 */