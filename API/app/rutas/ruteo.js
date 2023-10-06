const listaFull = require('../controlador/ControladorListadoFull')
const {listaActores, unActor, ActorNombre} = require('../controlador/controladorActores')
const listaCateg = require('../controlador/controladorCategorias')
const {errorMalURL, bienvenida} = require('../controlador/controladorGeneral')
const {listaGeneros, unGenero, generoNombre} = require('../controlador/controladorGeneros')
const {listaPeliculas, unaPelicula, PeliculaTitulo, PeliculaGenero, PeliculaCateg, PeliculaActor} = require('../controlador/controladorPeliculas')

let rutear = require('express').Router()
let rutearIni = require('express').Router()
let rutearErr = require('express').Router()
let rutearPelis = require('express').Router()
let rutearActores = require('express').Router()
let rutearGeneros = require('express').Router()
let rutearCateg = require('express').Router()

rutearIni.get('/', bienvenida)
rutear.get('/', bienvenida)

rutearPelis.get('/', listaPeliculas)
rutearPelis.get('/todo', listaPeliculas)
rutearPelis.get('/all', listaPeliculas)
rutearPelis.get('/full', listaFull)
rutearPelis.get('/id/:peliculaID', unaPelicula)
rutearPelis.get('/titulo/:peliculaText', PeliculaTitulo)
rutearPelis.get('/genero/:generoText', PeliculaGenero)
rutearPelis.get('/categoria/:categText', PeliculaCateg)
rutearPelis.get('/actor/:actorText', PeliculaActor)

rutearActores.get('/', listaActores)
rutearActores.get('/todo', listaActores)
rutearActores.get('/all', listaActores)
rutearActores.get('/id/:actorID', unActor)
rutearActores.get('/nombre/:actorText', ActorNombre)

rutearGeneros.get('/', listaGeneros)
rutearGeneros.get('/todo', listaGeneros)
rutearGeneros.get('/all', listaGeneros)
rutearGeneros.get('/id/:generoID', unGenero)
rutearGeneros.get('/nombre/:generoText', generoNombre)

rutearCateg.get('/', listaCateg)
rutearCateg.get('/todo', listaCateg)
rutearCateg.get('/all', listaCateg)

rutearErr.all('/*', errorMalURL)

module.exports = {rutearIni, rutear, rutearErr, rutearPelis, rutearActores, rutearGeneros, rutearCateg}
