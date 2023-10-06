use trailerflix_fac;
select 
	P.idpelicula as ID, 
    P.Poster,
    P.Titulo,
    C.Nombre as Categoria,
    P.Resumen,	
GROUP_CONCAT(DISTINCT G.Detalle SEPARATOR ', ') as Genero,
	P.Temporadas,
GROUP_CONCAT(DISTINCT A.Nombre SEPARATOR ', ') as Reparto,
GROUP_CONCAT(DISTINCT PS.Nombre SEPARATOR ', ') as Origen

FROM peliculas P

INNER JOIN peliculasActores PA
ON PA.idPelicula = P.idPelicula
INNER JOIN actores A
ON A.idActor = PA.idActor

INNER JOIN peliculasGeneros PG
ON PG.idPelicula = P.idPelicula
INNER JOIN generos G
ON G.idGenero = PG.idGenero

INNER JOIN categorias C
ON C.idCategoria = P.idCategoria

INNER JOIN peliculasPaises PP
ON PP.idPelicula = P.idPelicula
INNER JOIN paises PS
ON PS.idPais = PP.idPais


GROUP BY P.idpelicula


