const Actores = require("../modelo/actores")
const { Op } = require('sequelize')


const listaActores = async (req, res) =>{
   try {
      const allActors = await Actores.findAll()
      const allActorsData = allActors.map(elem => elem.dataValues)
      res.status(200).json(allActorsData)
   } catch (error){
      res.status(500).json({
         error: 'Error en el servidor al usar tabla <actores>', 
         descripcion: error.message
      })
   }
}

const unActor = async (req, res) =>{
   try {
      const { actorID } = req.params
      const actor = await Actores.findByPk(parseInt(actorID))
      !(actor)
         ? res.status(404).json({error:'Actor / Actriz no encontrado/a'})
         : res.status(200).json(actor)
   } catch (error){
      res.status(500).json({error: 'Error en el servidor', descripcion: error.message})
   }
}

const ActorNombre = async (req, res) =>{
   try {
      const { actorText } = req.params
      const actores = await Actores.findAll({
         where : { Nombre : {
               [Op.like]: `%${actorText}%`,
            } 
         },
         order : [['Nombre', 'ASC']]
      })
      const allActorsData = actores.map(elem => elem.dataValues)
      actores.length == 0
         ? res.status(404).json({error:'No se encontraron actores con ese patron de búsqueda'})
         : res.status(200).json(allActorsData)
   } catch (error){
      res.status(500).json({error: 'Error en el servidor', descripcion: error.message})
   }
}

module.exports = {listaActores, unActor, ActorNombre}
;
