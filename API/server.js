const express = require('express')
const app = express()

const dotenv = require('dotenv')
dotenv.config()
const puerto = process.env.PORT

const cors = require('cors')
const corsOp = {
   inicio : `http://localhost:${puerto}`
}
const asocTablas = require('./app/config/asocTablas')
const { rutear, rutearIni, rutearErr, rutearPelis, rutearActores, rutearGeneros, rutearCateg } = require('./app/rutas/ruteo')
//const { Op } = require('sequelize')

app.use(cors(corsOp)) //dominio + puerto
app.use(express.json()) // content-type - application/json
app.use(express.urlencoded({ extended: true })) // content-type - application/x-www-form-urlencoded
app.use((req, res, next) => {
   res.header("Content-Type", "application/json; charset=utf-8")  
   next()
})
app.use(asocTablas)

app.use('/', rutearIni)

app.use('/trailerflix', rutear)
app.use('/trailerflix/peliculas', rutearPelis)
app.use('/trailerflix/actores', rutearActores)
app.use('/trailerflix/generos', rutearGeneros)
app.use('/trailerflix/categorias', rutearCateg)

app.use('/*', rutearErr)

module.exports = app.listen(puerto, ()=>{
   console.log(`Servidor iniciado en ${puerto}`);
})
