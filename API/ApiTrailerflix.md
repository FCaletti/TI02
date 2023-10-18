# API Trailerflix
El objetivo de la Api Traileflix es brindar información de películas y series contenidas en la plataforma.

Los resultados se entregan en formato _JSON_, y el formato de los datos varia dependiendo de la información que se pida

#### A continuación detallamos los ___endpoints___ y una  explicación del resultado que arroja y como se debe usar correctamente.
***

### Mensaje de Bienvenida

#### ___Método GET :___
* #### _/trailerflix/_

#### ___Resultado :___
Tira un mensaje de bienvenida

#### ___Ejemplo :___

Algunos ejemplos
#### _http://localhost:3000/trailerflix/_

```json
{
  "mensaje": "Bienvenido a Trailerflix"
}
```
***

## Obtener informacion individual de cada pelicula / serie


### Para listar todo el contenido del catálogo :

#### ___Método GET :___
* #### _/trailerflix/peliculas/_
* #### _/trailerflix/peliculas/todo_
* #### _/trailerflix/peliculas/all_

#### ___Parámetros :___

No lleva

#### ___Resultado :___

Un listado con todas las peliculas que existen en el catálogo. 

El contenido del dato "Poster" hace referencia a la URL de nuestro servidor donde esta el archivo con la imagen correspondiente.

#### ___Ejemplo :___

#### _http://localhost:3000//trailerflix/peliculas/todo_

```json
[
  {
    "idPelicula": 1,
    "Titulo": "The Crown",
    "Poster": "http://localhost:3000/recursos/posters/1.jpg",
    "Resumen": "Este drama narra las rivalidades políticas y el romance de la reina Isabel II, así como los sucesos que moldearon la segunda mitad del siglo XX.",
    "Trailer": null,
    "idCategoria": 2
  },
  {
    "idPelicula": 2,
    "Titulo": "Riverdale",
    "Poster": "http://localhost:3000/recursos/posters/2.jpg",
    "Resumen": "El paso a la edad adulta incluye sexo, romance, escuela y familia. Para Archie y sus amigos, también hay misterios oscuros.",
    "Trailer": null,
    "idCategoria": 2
  },
  ...
]
```
### Errores
En el caso que ocurra en error al acceder al servidor, devuelve la siguiente estructura JSON : 


```json
{
  "error": "Error en el servidor al usar tabla <peliculas>",
  "descripcion": "(descripción del error otorgada por el sistema)"
}
```


### Para consultar una pelicula por ID :

#### ___Método GET :___
* #### _/trailerflix/peliculas/ID/(nro ID)_

#### ___Parámetros :___
__nro ID__ : es un dato numérico que representa el ID de la película o serie que se esta solicitando.

#### ___Resultado :___

Va a mostrar la información de solo una película.

El contenido del dato "Poster" hace referencia a la URL de nuestro servidor donde esta el archivo con la imagen correspondiente.

#### ___Ejemplo :___

#### _http://localhost:3000//trailerflix/peliculas/ID/2_

```json
[
  {
    "idPelicula": 2,
    "Titulo": "Riverdale",
    "Poster": "http://localhost:3000/recursos/posters/2.jpg",
    "Resumen": "El paso a la edad adulta incluye sexo, romance, escuela y familia. Para Archie y sus amigos, también hay misterios oscuros.",
    "Trailer": null,
    "idCategoria": 2
  }
]
```
### Errores
* En el caso que ocurra un error al acceder al servidor, devuelve la siguiente estructura JSON : 

```json
{
  "error": "Error en el servidor al usar tabla <peliculas>",
  "descripcion": "(descripción del error otorgada por el sistema)"
}
```

* En el caso que se ingrese un ID inexistente

```json
{
  "error": "Película no encontrada"
}
```

* En el caso que no se ingrese algún ID 

```json
{
  "error": "ID inaccesible"
}

```

* En el caso que se ingrese algún ID alfanumérico o un '0'

```json
{
  "error": "Error al acceder al ID"
}

```
***

### Para buscar una pelicula o varias peliculas por el tìtulo o parte de él

#### ___Método GET :___
* #### _/trailerflix/peliculas/titulo/(texto)_

#### ___Parámetros :___
__texto__ : es una cadena de caracteres que se va a usar como patrón de búsqueda del contenido del catálogo, tomando como referencia el campo _Titulo_.

#### ___Resultado :___

Va a mostrar una lista con información de todas las películas, cuyo tìtulo cumple la condición del patrón de búsqueda.

El contenido del dato "Poster" hace referencia a la URL de nuestro servidor donde esta el archivo con la imagen correspondiente.

#### ___Ejemplo :___

#### _http://localhost:3000/trailerflix/peliculas/titulo/nn_

Va a listar todas las peliculas cuyo título contenga la cadena de caracteres "_nn_".

```json
[
  {
    "idPelicula": 13,
    "Titulo": "Anne with an 'E'",
    "Poster": "http://localhost:3000/recursos/posters/13.jpg",
    "Resumen": "Anne Shirley es una niña huérfana que vive en un pequeño pueblo llamado Avonlea que pertenece a la Isla del Príncipe Eduardo, en el año 1890. Después de una infancia difícil, donde fue pasando de orfanato a hogares de acogida, es enviada por error a vivir con una solterona y su hermano. Cuando cumple 13 años, Anne va a conseguir transformar su vida y el pequeño pueblo donde vive gracias a su fuerte personalidad, intelecto e imaginación. Basada en la inolvidable novela.",
    "Trailer": null,
    "idCategoria": 2
  },
  {
    "idPelicula": 19,
    "Titulo": "Aves de presa y la fantabulosa emancipación de una Harley Quinn",
    "Poster": "http://localhost:3000/recursos/posters/19.jpg",
    "Resumen": "Después de separarse de Joker, Harley Quinn y otras tres heroínas (Canario Negro, Cazadora y Renée Montoya) unen sus fuerzas para salvar a una niña (Cassandra Cain) del malvado rey del crimen Máscara Negra.",
    "Trailer": null,
    "idCategoria": 1
  }
]
```
### Errores
* En el caso que ocurra un error al acceder al servidor, devuelve la siguiente estructura JSON : 

```json
{
  "error": "Error en el servidor al usar tabla <peliculas>",
  "descripcion": "(descripción del error otorgada por el sistema)"
}
```

* En el caso que no encuentre películas / series cuyo título contenga el patrón de búsqueda

```json
{
  "error": "No se encontraron elementos con ese patron de búsqueda"
}
```

* En el caso que no se ingrese algún texto 

```json
{
  "error": "Patrón de búsqueda inaccesible"
}
```
***

## Obtener informacion de los géneros

### Para listar todos los géneros

#### ___Método GET :___
* #### _/trailerflix/generos/_
* #### _/trailerflix/generos/todo_
* #### _/trailerflix/generos/all_

#### ___Parámetros :___

No tiene

#### ___Resultado :___

Un listado de todos los géneros que existen en el catálogo. 

#### ___Ejemplo :___

#### _http://localhost:3000/trailerflix/generos/todo_

```json
[
  {
    "idGenero": 1,
    "Detalle": "Ciencia Ficción"
  },
  {
    "idGenero": 2,
    "Detalle": "Fantasía"
  },
  {
    "idGenero": 3,
    "Detalle": "Drama"
  },
  ...
  ,
  {
    "idGenero": 19,
    "Detalle": "Intriga"
  }
]
```

### Errores
En el caso que ocurra en error al acceder al servidor, devuelve la siguiente estructura JSON : 

```json
{
  "error": "Error en el servidor al usar tabla <generos>",
  "descripcion": "(descripción del error otorgada por el sistema)"
}
```
***

### Para consultar una género por ID :

#### ___Método GET :___
* #### _/trailerflix/generos/ID/(nro ID)_

#### ___Parámetros :___
__nro ID__ : es un dato numérico que corresponde a un dato numerico que representa el ID del género buscado.

#### ___Resultado :___

Muestra los datos del género que corresponde al ID ingresado.

#### ___Ejemplo :___

Va a mostrar la información del género cuyo ID es 4.

#### _http://localhost:3000//trailerflix/generos/ID/4_

```json
{
  "idGenero": 4,
  "Detalle": "Ficción"
}
```
### Errores
* En el caso que ocurra un error al acceder al servidor, devuelve la siguiente estructura JSON : 

```json
{
  "error": "Error en el servidor al usar tabla <generos>",
  "descripcion": "(descripción del error otorgada por el sistema)"
}
```

* En el caso que se ingrese un ID inexistente

```json
{
  "error": "Género no encontrado"
}
```

* En el caso que no se ingrese algún ID 

```json
{
  "error": "ID inaccesible"
}

```

* En el caso que se ingrese algún ID alfanumérico o un '0'

```json
{
  "error": "Error al acceder al ID"
}
```
***

### Para buscar uno o varios géneros por su la descripción de su detalle o parte de ella

#### ___Método GET :___
* #### _/trailerflix/generos/nombre/(texto)_

#### ___Parámetros :___
_texto_ es una cadena de caracteres que se va a usar como patrón de búsqueda de los géneros, tomando como referencia el campo _Detalle_.

#### ___Resultado :___

Va a mostrar una lista con información de todas los géneros, cuyo detalle cumple la condición del patrón de búsqueda.

#### ___Ejemplo :___

#### _http://localhost:3000/trailerflix/generos/nombre/cc_

Va a listar todas los géneros cuyo título contenga la cadena de caracteres "_cc_".

```json
[
  {
    "idGenero": 12,
    "Detalle": "Acción"
  },
  {
    "idGenero": 1,
    "Detalle": "Ciencia Ficción"
  },
  {
    "idGenero": 4,
    "Detalle": "Ficción"
  }
]
```
### Errores
* En el caso que ocurra un error al acceder al servidor, devuelve la siguiente estructura JSON : 

```json
{
  "error": "Error en el servidor al usar tabla <generos>",
  "descripcion": "(descripción del error otorgada por el sistema)"
}
```

* En el caso que no encuentre géneros cuyo nombre contenga el patrón de búsqueda

```json
{
  "error": "No se encontraron elementos con ese patron de búsqueda"
}
```

* En el caso que no se ingrese algún texto 

```json
{
  "error": "Patrón de búsqueda inaccesible"
}
```
***

## Obtener informacion de los actores / actrices

### Para listar todos los actores/actrices
#### ___Método GET :___
* #### _/trailerflix/actores/_
* #### _/trailerflix/actores/todo_
* #### _/trailerflix/actores/all_

#### ___Resultado :___
Un listado con todos los actores/actrices relacionados con las películas que existen en el catálogo. 

#### ___Ejemplo :___
#### _http://localhost:3000//trailerflix/actores/todo_

```json
[
  {
    "idActor": 1,
    "Nombre": "Claire Foy"
  },
  {
    "idActor": 2,
    "Nombre": "Olivia Colman"
  },
  {
    "idActor": 3,
    "Nombre": "Matt Smith"
  },
  ...
  ,
  {
    "idActor": 210,
    "Nombre": "Burn Gorman"
  }
]
```
### Errores
En el caso que ocurra en error al acceder al servidor, devuelve la siguiente estructura JSON : 

```json
{
  "error": "Error en el servidor al usar tabla <actores>",
  "descripcion": "(descripción del error otorgada por el sistema)"
}
```
***

### Para consultar una actor/actriz por su ID :

#### ___Método GET :___
* #### _/trailerflix/actores/ID/(nro ID)_

#### ___Parámetros :___
_nro ID_ corresponde a un dato numérico que representa el ID del actor/actriz buscado.

#### ___Resultado :___
Muestra los datos del actor/actriz que corresponde al ID ingresado.

#### ___Ejemplo :___

Va a mostrar la información del género cuyo ID es 40.

#### _http://localhost:3000//trailerflix/actores/ID/40_

```json
{
  "idActor": 40,
  "Nombre": "Brett Cullen"
}
```
### Errores
* En el caso que ocurra un error al acceder al servidor, devuelve la siguiente estructura JSON : 

```json
{
  "error": "Error en el servidor al usar tabla <actores>",
  "descripcion": "(descripción del error otorgada por el sistema)"
}
```

* En el caso que se ingrese un ID inexistente

```json
{
  "error": "Actor / Actriz no encontrado/a"
}
```

* En el caso que no se ingrese algún ID 

```json
{
  "error": "ID inaccesible"
}

```

* En el caso que se ingrese algún ID alfanumérico o un '0'

```json
{
  "error": "Error al acceder al ID"
}
```
***

### Para buscar uno o varios actores/actrices por su nombre o parte de él

#### ___Método GET :___
* #### _/trailerflix/actores/nombre/(texto)_

#### ___Parámetros :___
_texto_ es una cadena de caracteres que se va a usar como patrón de búsqueda de los actores/actrices, tomando como referencia el campo _Nombre_.

#### ___Resultado :___

Va a mostrar una lista con información de todas los actores/actrices, cuyo detalle cumple la condición del patrón de búsqueda.

#### ___Ejemplo :___

#### _http://localhost:3000/trailerflix/actores/nombre/Matt_

Va a listar todas los actores/actrices cuyo nombre contenga la cadena de caracteres "_Matt_".
```json
[
  {
    "idActor": 146,
    "Nombre": "Matt Damon"
  },
  {
    "idActor": 72,
    "Nombre": "Matt LeBlanc"
  },
  {
    "idActor": 3,
    "Nombre": "Matt Smith"
  },
  {
    "idActor": 71,
    "Nombre": "Matthew Perry"
  }
]
```
### Errores
* En el caso que ocurra un error al acceder al servidor, devuelve la siguiente estructura JSON : 

```json
{
  "error": "Error en el servidor al usar tabla <actores>",
  "descripcion": "(descripción del error otorgada por el sistema)"
}
```

* En el caso que no encuentre actores/actrices cuyo nombre contenga el patrón de búsqueda

```json
{
  "error": "No se encontraron elementos con ese patron de búsqueda"
}
```

* En el caso que no se ingrese algún texto 

```json
{
  "error": "Patrón de búsqueda inaccesible"
}
```
***

## Obtener informacion de las categorías

### Para listar todas las categorías
#### ___Método GET :___
* #### _/trailerflix/categorias/_
* #### _/trailerflix/categorias/todo_
* #### _/trailerflix/categorias/all_

#### ___Resultado :___
Un listado con todos las categorías relacionados con las películas que existen en el catálogo. 

#### ___Ejemplo :___
#### _http://localhost:3000//trailerflix/categorias/todo_

```json
[
  {
    "idCategoria": 1,
    "Nombre": "Película"
  },
  {
    "idCategoria": 2,
    "Nombre": "Serie"
  },
  {
    "idCategoria": 3,
    "Nombre": "Miniserie"
  },
  {
    "idCategoria": 4,
    "Nombre": "Corto"
  }
]
```
### Errores
En el caso que ocurra en error al acceder al servidor, devuelve la siguiente estructura JSON : 

```json
{
  "error": "Error en el servidor al usar tabla <categorias>",
  "descripcion": "(descripción del error otorgada por el sistema)"
}
```
***

## Obtener informacion de las películas / series vinculadas a datos de otras tablas

### Para buscar una pelicula o varias peliculas por el nombre del género o parte de él

#### ___Método GET :___
* #### _/trailerflix/peliculas/genero/(texto)_

#### ___Parámetros :___
_texto_ es una cadena de caracteres que se va a usar como patrón de búsqueda del contenido del catálogo, tomando como referencia el campo _Genero_.

#### ___Resultado :___
UNa lista de pelìculas del género buscado

#### ___Ejemplo :___

Listar todas las peliculas cuyo género contenga la cadena de caracteres "_terror_".

#### _http://localhost:3000/trailerflix/peliculas/genero/terror_

```json
[
  {
    "Género": "Terror",
    "ID": 23,
    "Poster": "http://localhost:3000/recursos/posters/23.jpg",
    "Titulo": "IT - Capítulo 2",
    "Categoria": "Película",
    "Temporadas": 0,
    "Resumen": "En este segundo capitulo Han pasado 27 años desde que el 'Club de los Perdedores', formado por Bill, Berverly, Richie, Ben, Eddie, Mike y Stanley, se enfrentaran al macabro y despiadado Pennywise (Bill Skarsgård). En cuanto tuvieron oportunidad, abandonaron el pueblo de Derry, en el estado de Maine, que tantos problemas les había ocasionado. Sin embargo, ahora, siendo adultos, parece que no pueden escapar de su pasado. Todos deberán enfrentarse de nuevo al temible payaso para descubrir si de verdad están preparados para superar sus traumas de la infancia.",
    "Trailer": "https://www.youtube.com/embed/hZeFeYSmBcg"
  },
  {
    "Género": "Terror",
    "ID": 27,
    "Poster": "http://localhost:3000/recursos/posters/27.jpg",
    "Titulo": "DOOM: Aniquilación",
    "Categoria": "Película",
    "Temporadas": 0,
    "Resumen": "Doom: Aniquilación sigue a un grupo de marines espaciales que han respondido a una llamada de alerta de una base en la luna marciana, solo para descubrir que ha sido tomada por criaturas demoníacas que amenazan con desatar el infierno en la tierra.",
    "Trailer": "https://www.youtube.com/embed/nat3u3gAVLE"
  },
  {
    "Género": "Terror",
    "ID": 33,
    "Poster": "http://localhost:3000/recursos/posters/33.jpg",
    "Titulo": "Soy leyenda",
    "Categoria": "Película",
    "Temporadas": 0,
    "Resumen": "Años después de que una plaga mate a la mayoría de la humanidad y transforme al resto en monstruos, el único superviviente en la ciudad de Nueva York lucha valientemente para encontrar una cura.",
    "Trailer": "https://www.youtube.com/embed/dtKMEAXyPkg"
  }
]
```
### Errores
* En el caso que ocurra un error al acceder al servidor, devuelve la siguiente estructura JSON : 

```json
{
  "error": "Error en el servidor al usar tabla <peliculas>",
  "descripcion": "(descripción del error otorgada por el sistema)"
}
```

* En el caso que no encuentre películas / series donde alguno de los géneros asociados contenga el patrón de búsqueda

```json
{
  "error": "No se encontraron elementos con ese patron de búsqueda"
}
```

* En el caso que no se ingrese algún texto 

```json
{
  "error": "Patrón de búsqueda inaccesible"
}
```
***

### Para buscar una pelicula o varias peliculas por el nombre del actor/actriz o parte de él

#### ___Método GET :___
* #### _/trailerflix/peliculas/actor/(texto)_

#### ___Parámetros :___
_texto_ es una cadena de caracteres que se va a usar como patrón de búsqueda del contenido del catálogo, tomando como referencia el nombre de algun actor relacionado con esa película / serie.

#### ___Resultado :___
UNa lista de pelìculas del género buscado

#### ___Ejemplo :___

Listar todas las peliculas donde el nombre de algunos de los actores vinculados contenga la cadena de caracteres "_matt damon_".

#### _http://localhost:3000/trailerflix/peliculas/peliculas/actor/matt damon_

```json
[
  {
    "Integrante(s) del elenco": "Matt Damon",
    "ID": 25,
    "Poster": "http://localhost:3000/recursos/posters/25.jpg",
    "Titulo": "Contra lo imposible (Ford versus Ferrari)",
    "Categoria": "Película",
    "Temporadas": 0,
    "Resumen": "Los ganadores del Premio de la Academia® Matt Damon y Christian Bale protagonizan CONTRA LO IMPOSIBLE, basada en la historia real del visionario diseñador americano de automóviles Carroll Shelby (Damon) y el intrépido piloto británico Ken Miles (Bale). Juntos construyen un nuevo coche de carreras para Ford Motor Company y así enfrentar a Enzo Ferrari en las 24 Horas de Le Mans en Francia en 1966.",
    "Trailer": "https://www.youtube.com/embed/SOVb0-2g1Q0"
  },
  {
    "Integrante(s) del elenco": "Matt Damon",
    "ID": 28,
    "Poster": "http://localhost:3000/recursos/posters/28.jpg",
    "Titulo": "Contagio",
    "Categoria": "Película",
    "Temporadas": 0,
    "Resumen": "De repente, sin saber cuál es su origen, aunque todo hace sospechar que comienza con el viaje de una norteamericana a un casino de Hong Kong, un virus mortal comienza a propagarse por todo el mundo. En pocos días, la enfermedad empieza a diezmar a la población. El contagio se produce por mero contacto entre los seres humanos. Un thriller realista y sin efectos especiales sobre los efectos de una epidemia.",
    "Trailer": "https://www.youtube.com/embed/4sYSyuuLk5g"
  },
  {
    "Integrante(s) del elenco": "Matt Damon",
    "ID": 30,
    "Poster": "http://localhost:3000/recursos/posters/30.jpg",
    "Titulo": "The Martian",
    "Categoria": "Película",
    "Temporadas": 0,
    "Resumen": "Durante una misión a Marte de la nave tripulada Ares III, una fuerte tormenta se desata dando por desaparecido y muerto al astronauta Mark Watney (Matt Damon), sus compañeros toman la decisión de irse pero él ha sobrevivido. Está solo y sin apenas recursos en el planeta. Con muy pocos medios deberá recurrir a sus conocimientos, su sentido del humor y un gran instinto de supervivencia para lograr sobrevivir y comunicar a la Tierra que todavía está vivo esperando que acudan en su rescate.",
    "Trailer": "https://www.youtube.com/embed/XvB58bCVfng"
  }
]
```
### Errores
* En el caso que ocurra un error al acceder al servidor, devuelve la siguiente estructura JSON : 

```json
{
  "error": "Error en el servidor al usar tabla <peliculas>",
  "descripcion": "(descripción del error otorgada por el sistema)"
}
```

* En el caso que no encuentre películas / series donde alguno de los actores/actrices asociados contenga el patrón de búsqueda

```json
{
  "error": "No se encontraron elementos con ese patron de búsqueda"
}
```

* En el caso que no se ingrese algún texto 

```json
{
  "error": "Patrón de búsqueda inaccesible"
}
```
***


### Obtener información completa de cada película/serie que existe en el catálogo

#### ___Método GET :___
* #### _/trailerflix/peliculas/full_

#### ___Parámetros :___
No tiene.

#### ___Resultado :___
Una lista de todas las películas / series detallando el género, la categoría, los actores relacinados y el o los paises de origen

#### ___Ejemplo :___

#### _http://localhost:3000/trailerflix/peliculas/full_

```json
[
  {
    "ID": 1,
    "Poster": "/posters/1.jpg",
    "Titulo": "The Crown",
    "Categoria": "Serie",
    "Resumen": "Este drama narra las rivalidades políticas y el romance de la reina Isabel II, así como los sucesos que moldearon la segunda mitad del siglo XX.",
    "Genero": "Drama, Hechos verídicos",
    "Temporadas": 4,
    "Reparto": "Claire Foy, Helena Bonham Carter, Matt Smith, Olivia Colman, Tobias Menzies, Vanesa Kirby",
    "Origen": "Reino Unido"
  },
  {
    "ID": 2,
    "Poster": "/posters/2.jpg",
    "Titulo": "Riverdale",
    "Categoria": "Serie",
    "Resumen": "El paso a la edad adulta incluye sexo, romance, escuela y familia. Para Archie y sus amigos, también hay misterios oscuros.",
    "Genero": "Drama, Ficción, Misterio",
    "Temporadas": 5,
    "Reparto": "Camila Mendes, Casey Cott, Lili Reinhart, Mädchen Amick, Madelaine Petsch, Marisol Nichols",
    "Origen": "Estados Unidos"
  },
  ...
  {
    "ID": 35,
    "Poster": "/posters/35.jpg",
    "Titulo": "Titanes del pacífico - La insurrección",
    "Categoria": "Película",
    "Resumen": "Han pasado 10 años tras la primera invasión que sufrió la humanidad, pero la lucha aún no ha terminado. El planeta vuelve a ser asediado por los Kaiju, una raza de alienígenas colosales, que emergen desde un portal interdimensional con el objetivo de destruir a la raza humana. Ante esta nueva amenaza, los Jaegers, robots gigantes de guerra pilotados por dos personas para sobrellevar la inmensa carga neuronal que conlleva manipularlos, ya no están a la altura de lo que se les viene encima. Será entonces cuando los supervivientes de la primera invasión, además de nuevos personajes como el hijo de Pentecost, tendrán que idear la manera de sorprender al enorme enemigo, apostando por nuevas estrategias defensivas y de ataque. Con la Tierra en ruinas e intentando reconstruirse, esta nueva batalla puede ser decisiva para el futuro.",
    "Genero": "Acción, Fantasía, Sci-Fi",
    "Temporadas": 0,
    "Reparto": "Burn Gorman, Cailee Spaeny, Jing Tian, John Boyega, Rinko Kikuchi, Scott Eastwood",
    "Origen": "China, Estados Unidos"
  }
]
```
### Errores
* En el caso que ocurra un error al acceder al servidor, devuelve la siguiente estructura JSON : 

```json
{
  "error": "Error en el servidor al usar la vista <ListadoFull>",
  "descripcion": "(descripción del error otorgada por el sistema)"
}
```
***

### Ingreso de metodo GET con una URL diferente a las expuestas anteriormente

#### ___Resultado :___
Tira un mensaje de error

#### ___Ejemplo :___

Algunos ejemplos
#### _http://localhost:3000/trailerflix/peliculas/nada_
#### _http://localhost:3000/trailerflix/pelis/todo_
#### _http://localhost:3000/trailerflix/peliculas/actrices/todo_

```json
{
  "msjEstado": "URL no identificada"
}
```










