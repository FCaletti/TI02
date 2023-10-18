const sequelize = require("../config/DBconexion")
const Peliculas = require("../modelo/peliculas")
const { Op } = require('sequelize')

const dotenv = require('dotenv')
dotenv.config()
const puerto = process.env.PORT

const listaPeliculas = async (req, res) =>{
   try {
      const peliculas = await Peliculas.findAll()
      const allPelisData = peliculas.map((elem) => {
         elem.dataValues.Poster = req.protocol+'://'+req.hostname+":"+puerto + '/recursos' + elem.dataValues.Poster
         return elem.dataValues
      })
      res.status(200).json(allPelisData)
   } catch (error){
      res.status(500).json({
         error: 'Error en el servidor al usar tabla <peliculas>', 
         descripcion: error.message
      })
   }
}

const unaPelicula = async (req, res) =>{
   try {
      const { peliculaID } = req.params
      if(isNaN(peliculaID) || parseInt(peliculaID) == 0){
         res.status(400)
            .json({error : 'Error al acceder al ID'})
         return;
      }      
      const pelicula = await Peliculas.findByPk(parseInt(peliculaID))
      if (pelicula){
         pelicula.dataValues.Poster = req.protocol+'://'+req.hostname+":"+puerto + '/recursos' + pelicula.dataValues.Poster
      }
      !(pelicula)
         ? res.status(404).json({error:'Película no encontrada'})
         : res.status(200).json(pelicula)
   } catch (error){
      res.status(500).json({error: 'Error en el servidor', descripcion: error.message})
   }
}

const PeliculaTitulo = async (req, res) =>{
   try {
      const { peliculaText } = req.params
      const peliculas = await Peliculas.findAll({
         where : { Titulo : {
               [Op.like]: `%${peliculaText}%`,
            } 
         },
         order : [['Titulo', 'ASC']]
      })
      const allPelisData = peliculas.map((elem) => {
         elem.dataValues.Poster = req.protocol+'://'+req.hostname+":"+puerto + '/recursos' + elem.dataValues.Poster
         return elem.dataValues
      })
      peliculas.length == 0
         ? res.status(404).json({error:'No se encontraron elementos con ese patron de búsqueda'})
         : res.status(200).json(allPelisData)
   } catch (error){
      res.status(500).json({error: 'Error en el servidor', descripcion: error.message})
   }
}

const PeliculaGenero = async (req, res) =>{
   try {
      const { generoText } = req.params
      const URL = req.protocol+'://'+req.hostname+":"+puerto + '/recursos'
      const txtQuery = `
         SELECT 
            G.Detalle AS Género,
            P.idPelicula AS ID, 
            concat('${URL}', P.Poster) as Poster, 
            P.Titulo as Titulo, 
            CA.Nombre as Categoria,
            P.Temporadas as Temporadas,
            P.Resumen as Resumen, 
            P.Trailer as Trailer
         FROM peliculas P 
         LEFT JOIN categorias CA
            ON CA.idCategoria = P.idCategoria
         LEFT JOIN peliculasgeneros PG 
            ON PG.idPelicula = P.idPelicula
         LEFT JOIN generos G
            ON G.idGenero = PG.idGenero
         WHERE G.Detalle like '%${generoText}%'
      `
      const [peliculas, metadata] = await sequelize.query(txtQuery)
      peliculas.length == 0
         ? res.status(404).json({error:'No se encontraron elementos con ese patron de búsqueda'})
         : res.status(200).json(peliculas)
   } catch (error){
      res.status(500).json({error: 'Error en el servidor', descripcion: error.message})
   }
}

const PeliculaCateg = async (req, res) =>{
   try {
      const { categText } = req.params
      const URL = req.protocol+'://'+req.hostname+":"+puerto + '/recursos'
      const txtQuery = `
         SELECT 
            C.Nombre as Categoria,
            P.idPelicula AS ID, 
            concat('${URL}', P.Poster) as Poster, 
            P.Titulo as Titulo, 
            P.Temporadas as Temporadas,
            P.Resumen as Resumen, 
            P.Trailer as Trailer
         FROM peliculas P 
         LEFT JOIN categorias C
            ON C.idCategoria = P.idCategoria
         WHERE C.Nombre like '%${categText}%'
      `
      const [peliculas, metadata] = await sequelize.query(txtQuery)
      peliculas.length == 0
         ? res.status(404).json({error:'No se encontraron elementos con ese patron de búsqueda'})
         : res.status(200).json(peliculas)
   } catch (error){
      res.status(500).json({error: 'Error en el servidor', descripcion: error.message})
   }
}

const PeliculaActor = async (req, res) =>{
   try {
      const { actorText } = req.params
      const URL = req.protocol+'://'+req.hostname+":"+puerto + '/recursos'
      const txtQuery = `
         SELECT 
            GROUP_CONCAT(DISTINCT A.Nombre SEPARATOR ', ') AS 'Integrante(s) del elenco',
            P.idPelicula AS ID, 
            concat('${URL}', P.Poster) as Poster, 
            P.Titulo as Titulo, 
            CA.Nombre as Categoria,
            P.Temporadas as Temporadas,
            P.Resumen as Resumen, 
            P.Trailer as Trailer
         FROM  peliculas P 
         LEFT JOIN categorias CA
            ON CA.idCategoria = P.idCategoria
         LEFT JOIN peliculasactores PA
            ON PA.idPelicula = P.idPelicula
         LEFT JOIN actores A
            ON A.idActor = PA.idActor
         WHERE A.Nombre like '%${actorText}%'
         group by P.idPelicula
      `
      const [peliculas, metadata] = await sequelize.query(txtQuery)
      peliculas.length == 0
         ? res.status(404).json({error:'No se encontraron elementos con ese patron de búsqueda'})
         : res.status(200).json(peliculas)
   } catch (error){
      res.status(500).json({error: 'Error en el servidor', descripcion: error.message})
   }
}


module.exports = {listaPeliculas, unaPelicula, PeliculaTitulo, PeliculaGenero, PeliculaCateg, PeliculaActor}
;
