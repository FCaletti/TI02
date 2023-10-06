const Categoria = require("../modelo/categorias")

const listaCateg = async (req, res) =>{
   try {
      const allCateg = await Categoria.findAll()
      const allCategData = allCateg.map(elem => elem.dataValues)
      res.status(200).json(allCategData)
   } catch (error){
      res.status(500).json({
         error: 'Error en el servidor al usar tabla <categorias>', 
         descripcion: error.message
      })
   }
}

module.exports = listaCateg
;
