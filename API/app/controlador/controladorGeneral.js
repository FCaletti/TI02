const sequelize = require("../config/DBconexion")


const bienvenida = (req,res)=>{     // peticion raiz
   res.status(200).json({mensaje : 'Bienvenido a Trailerflix'})
}

const errorMalURL = (req, res)=>{
   res.status(400).json({msjEstado : `URL no identificada`})
}

module.exports = {errorMalURL, bienvenida}
;

