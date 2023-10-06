const Actores = require("../modelo/actores")
const Generos = require("../modelo/generos")
const Peliculas = require("../modelo/peliculas")
const sequelize = require("./DBconexion")


const asocTablas = async (req, res, next) =>{
   try {
      await sequelize.authenticate()
      await Peliculas.sync()
      await Actores.sync()
      await Generos.sync()
      next()
   } catch (error){
      res.status(500).json({
         error:'Error en el servidor',
         description:error.message
      })
   }
}

module.exports = asocTablas
;
