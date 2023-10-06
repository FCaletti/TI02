const Generos = require("../modelo/generos")
const { Op } = require('sequelize')

const listaGeneros = async (req, res) =>{
   try {
      const allGeneros = await Generos.findAll()
      const allGenerosData = allGeneros.map(elem => elem.dataValues)
      res.status(200).json(allGenerosData)
   } catch (error){
      res.status(500).json({
         error: 'Error en el servidor al usar tabla <generos>', 
         descripcion: error.message
      })
   }
}

const unGenero = async (req, res) =>{
   try {
      const { generoID } = req.params
      const genero = await Generos.findByPk(parseInt(generoID))
      !(genero)
         ? res.status(404).json({error:'Género no encontrado/a'})
         : res.status(200).json(genero)
   } catch (error){
      res.status(500).json({error: 'Error en el servidor', descripcion: error.message})
   }
}

const generoNombre = async (req, res) =>{
   try {
      const { generoText } = req.params
      const generos = await Generos.findAll({
         where : { Detalle : {
               [Op.like]: `%${generoText}%`,
            } 
         },
         order : [['Detalle', 'ASC']]
      })
      const allGenrsData = generos.map(elem => elem.dataValues)
      generos.length == 0
         ? res.status(404).json({error:'No se encontraron géneros con ese patron de búsqueda'})
         : res.status(200).json(allGenrsData)
   } catch (error){
      res.status(500).json({error: 'Error en el servidor', descripcion: error.message})
   }
}


module.exports = {listaGeneros, unGenero, generoNombre}
;
