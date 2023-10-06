const ViewListadoFull = require("../modelo/viewListadoFull")

const listaFull = async (req, res) =>{
   try {
      const allItems = await ViewListadoFull.findAll()
      const allItemsData = allItems.map(elem => elem.dataValues)
      res.status(200).json(allItemsData)
   } catch (error){
      res.status(500).json({
         error: 'Error en el servidor al usar la vista <ListadoFull>', 
         descripcion: error.message
      })
   }
}

module.exports = listaFull
;
