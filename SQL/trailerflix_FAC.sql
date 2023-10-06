DROP DATABASE IF EXISTS Trailerflix_FAC;
CREATE DATABASE Trailerflix_FAC
DEFAULT CHARACTER SET utf8mb4;

USE Trailerflix_FAC;

/*----------------------------
CREACIONES DE TABLAS
----------------------------*/ 
-- DROP TABLE IF EXISTS `Peliculas`;
CREATE TABLE `Peliculas` (
	`idPelicula` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`Titulo` varchar(100) NOT NULL,
	`Poster` varchar(200),
	`Resumen` TEXT NOT NULL,
	`Trailer` varchar(200) DEFAULT '1900',
	`idCategoria` INT DEFAULT '0',
	`Temporadas` INT DEFAULT '0',
	PRIMARY KEY (`idPelicula`)
);

-- DROP TABLE IF EXISTS `Categorias`;
CREATE TABLE `Categorias` (
	`idCategoria` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`Nombre` varchar(50) NOT NULL,
	PRIMARY KEY (`idCategoria`)
);

-- DROP TABLE IF EXISTS `Generos`;
CREATE TABLE `Generos` (
	`idGenero` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`Detalle` varchar(50) NOT NULL,
	PRIMARY KEY (`idGenero`)
);


-- DROP TABLE IF EXISTS `Paises`;
CREATE TABLE `Paises` (
	`idPais` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`Nombre` varchar(50) NOT NULL,
	PRIMARY KEY (`idPais`)
);

-- DROP TABLE IF EXISTS `Actores`;
CREATE TABLE `Actores` (
	`idActor` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`Nombre` varchar(50) NOT NULL,
	PRIMARY KEY (`idActor`)
);

-- DROP TABLE IF EXISTS `PeliculasPaises`;
CREATE TABLE `PeliculasPaises` (
	`idPelicula` INT NOT NULL,
	`idPais` INT NOT NULL,
	PRIMARY KEY (`idPelicula`,`idPais`)
);


-- DROP TABLE IF EXISTS `PeliculasGeneros`;
CREATE TABLE `PeliculasGeneros` (
	`idPelicula` INT NOT NULL,
	`idGenero` INT NOT NULL,
	PRIMARY KEY (`idPelicula`,`idGenero`)
);

-- DROP TABLE IF EXISTS `PeliculasActores`;
CREATE TABLE `PeliculasActores` (
	`idPelicula` INT NOT NULL,
	`idActor` INT NOT NULL,
	PRIMARY KEY (`idPelicula`,`idActor`)
);


/*--------------------------------
DEFINICION DE CLAVES FORANEAS
--------------------------------*/

ALTER TABLE `Peliculas` ADD CONSTRAINT `Peliculas_fk0` FOREIGN KEY (`idCategoria`) REFERENCES `Categorias`(`idCategoria`);

ALTER TABLE `PeliculasGeneros` ADD CONSTRAINT `PeliculasGeneros_fk0` FOREIGN KEY (`idPelicula`) REFERENCES `Peliculas`(`idPelicula`);

ALTER TABLE `PeliculasGeneros` ADD CONSTRAINT `PeliculasGeneros_fk1` FOREIGN KEY (`idGenero`) REFERENCES `Generos`(`idGenero`);

ALTER TABLE `PeliculasActores` ADD CONSTRAINT `PeliculasActores_fk0` FOREIGN KEY (`idPelicula`) REFERENCES `Peliculas`(`idPelicula`);

ALTER TABLE `PeliculasActores` ADD CONSTRAINT `PeliculasActores_fk1` FOREIGN KEY (`idActor`) REFERENCES `Actores`(`idActor`);

ALTER TABLE `PeliculasPaises` ADD CONSTRAINT `PeliculasPaises_fk0` FOREIGN KEY (`idPelicula`) REFERENCES `Peliculas`(`idPelicula`);

ALTER TABLE `PeliculasPaises` ADD CONSTRAINT `PeliculasPaises_fk1` FOREIGN KEY (`idPais`) REFERENCES `Paises`(`idPais`);


/*--------------------------------
CREAR VISTAS
--------------------------------*/

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `Fabio`@`%` 
    SQL SECURITY DEFINER
VIEW `trailerflix_fac`.`listadofull` AS
    SELECT 
        `p`.`idPelicula` AS `ID`,
        `p`.`Poster` AS `Poster`,
        `p`.`Titulo` AS `Titulo`,
        `c`.`Nombre` AS `Categoria`,
        `p`.`Resumen` AS `Resumen`,
        GROUP_CONCAT(DISTINCT `g`.`Detalle`
            SEPARATOR ', ') AS `Genero`,
        `p`.`Temporadas` AS `Temporadas`,
        GROUP_CONCAT(DISTINCT `a`.`Nombre`
            SEPARATOR ', ') AS `Reparto`,
        GROUP_CONCAT(DISTINCT `ps`.`Nombre`
            SEPARATOR ', ') AS `Origen`
    FROM
        (((((((`trailerflix_fac`.`peliculas` `p`
        JOIN `trailerflix_fac`.`peliculasactores` `pa` ON ((`pa`.`idPelicula` = `p`.`idPelicula`)))
        JOIN `trailerflix_fac`.`actores` `a` ON ((`a`.`idActor` = `pa`.`idActor`)))
        JOIN `trailerflix_fac`.`peliculasgeneros` `pg` ON ((`pg`.`idPelicula` = `p`.`idPelicula`)))
        JOIN `trailerflix_fac`.`generos` `g` ON ((`g`.`idGenero` = `pg`.`idGenero`)))
        JOIN `trailerflix_fac`.`categorias` `c` ON ((`c`.`idCategoria` = `p`.`idCategoria`)))
        JOIN `trailerflix_fac`.`peliculaspaises` `pp` ON ((`pp`.`idPelicula` = `p`.`idPelicula`)))
        JOIN `trailerflix_fac`.`paises` `ps` ON ((`ps`.`idPais` = `pp`.`idPais`)))
    GROUP BY `p`.`idPelicula`;
    
    
/*--------------------------------
CARGA DE DATOS
--------------------------------*/

-- delete from Categorias;
INSERT INTO Categorias (Nombre)
VALUES 
  ('Película'),
  ('Serie'),
  ('Miniserie'),
  ('Corto')  
;




-- delete from peliculas;
INSERT INTO Peliculas (idPelicula, Titulo, Poster, Resumen, idCategoria, Trailer, Temporadas)
VALUES
(1, 'The Crown', '/posters/1.jpg', 'Este drama narra las rivalidades políticas y el romance de la reina Isabel II, así como los sucesos que moldearon la segunda mitad del siglo XX.', 2, NULL,4),
(2, 'Riverdale', '/posters/2.jpg', 'El paso a la edad adulta incluye sexo, romance, escuela y familia. Para Archie y sus amigos, también hay misterios oscuros.', 2, NULL,5),
(3, 'The Mandalorian', '/posters/3.jpg', 'Ambientada tras la caída del Imperio y antes de la aparición de la Primera Orden, la serie sigue los pasos de un pistolero solitario en las aventuras que protagoniza en los confines de la galaxia, donde no alcanza la autoridad de la Nueva República.', 2, 'https://www.youtube.com/embed/aOC8E8z_ifw',2),
(4, 'The Umbrella Academy', '/posters/4.jpg', 'La muerte de su padre reúne a unos hermanos distanciados y con extraordinarios poderes que descubren impactantes secretos y una amenaza que se cierne sobre la humanidad.', 2, NULL,1),
(5, 'Gambito de Dama', '/posters/5.jpg', 'En los cincuenta, una joven de un orfanato descubre que tiene un increíble don para el ajedrez y recorre el arduo camino a la fama mientras lucha contra las adicciones.', 2, NULL,1),
(6, 'Enola Holmes', '/posters/6.jpg', 'La hermana menor de Sherlock, descubre que su madre ha desaparecido y se dispone a encontrarla. En su búsqueda, saca a relucir el sabueso que corre por sus venas y se encuentra con una conspiración que gira en torno a un misterioso lord, demostrando que su ilustre hermano no es el único talento en la familia.', 1, NULL,0),
(7, 'Guasón', '/posters/7.jpg', 'Arthur Fleck (Phoenix) es un hombre ignorado por la sociedad, cuya motivación en la vida es hacer reír. Pero una serie de trágicos acontecimientos le llevarán a ver el mundo de otra forma. Película basada en el popular personaje de DC Comics Joker, conocido como archivillano de Batman, pero que en este film tomará un cariz más realista y oscuro.', 1, 'https://www.youtube.com/embed/zAGVQLHvwOY',0),
(8, 'Avengers: End Game', '/posters/8.jpg', 'Después de los devastadores eventos de los Vengadores: Infinity War (2018), el universo está en ruinas. Con la ayuda de los aliados restantes, los Vengadores se reúnen una vez más para revertir las acciones de Thanos y restaurar el equilibrio del universo.', 1, NULL,0),
(9, 'Juego de tronos', '/posters/9.jpg', 'En un mundo fantástico y en un contexto medieval varias familias, relativas a la nobleza, se disputan el poder para dominar el territorio ficticio de Poniente (Westeros) y tomar el control de los Siete Reinos desde el Trono de Hierro, lugar donde el rey ejerce el poder.', 2, NULL,8);

INSERT INTO Peliculas (idPelicula, Titulo, Poster, Resumen, idCategoria, Trailer, Temporadas)
VALUES
(10, 'The Flash', '/posters/10.jpg', 'Sigue las veloces aventuras de Barry Allen, un joven común y corriente con el deseo latente de ayudar a los demás. Cuando una inesperada partícula aceleradora golpea por accidente a Barry, de pronto se encuentra cargado de un increíble poder para moverse a increíbles velocidades. Mientras Barry siempre ha tenido el alma de un héroe, sus nuevos poderes le han dado la capacidad de actuar como tal.', 2, NULL,6),
(11, 'The Big Bang Theory', '/posters/11.jpg', 'Leonard y Sheldon son dos cerebros privilegiados que comparten piso. Aunque los dos, doctores en física, son capaces de calcular las probabilidades de existencia de otros mundos, no saben cómo relacionarse con los demás, especialmente con las chicas. Penny, una vecina recién llegada, que además es aspirante a actriz, aparece en la puerta de al lado para sorpresa de Leonard y Sheldon.', 2, NULL,12),
(12, 'Friends', '/posters/12.jpg', "'Friends' narra las aventuras y desventuras de seis jóvenes de Nueva York: Rachel, Monica, Phoebe, Ross, Chandler y Joey. Ellos forman una unida pandilla de amigos que viven en Manhattan y que suelen reunirse en sus apartamentos o en su bar habitual cafetería, el Central Perk. A pesar de los numerosos cambios que se producen en sus vidas, su amistad es inquebrantable en la dura batalla por salir adelante en sus periplos profesionales y personales.", 2, NULL,10),
(13, 'Anne with an ''E''', '/posters/13.jpg', "Anne Shirley es una niña huérfana que vive en un pequeño pueblo llamado Avonlea que pertenece a la Isla del Príncipe Eduardo, en el año 1890. Después de una infancia difícil, donde fue pasando de orfanato a hogares de acogida, es enviada por error a vivir con una solterona y su hermano. Cuando cumple 13 años, Anne va a conseguir transformar su vida y el pequeño pueblo donde vive gracias a su fuerte personalidad, intelecto e imaginación. Basada en la inolvidable novela.", 2, NULL,2),
(14, 'Expedientes Secretos ''X''', '/posters/14.jpg', "Fox Mulder y Dana Scully son dos investigadores del FBI que investigan casos sin resolución ni explicación, ya sea por razones paranormales (espíritus, criaturas extrañas, aliens...) ya porque el gobierno se ha encargado de ocultar todo tipo de pruebas. Cuando Mulder tenía doce años, su hermana pequeña fue secuestrada por unos desconocidos, aunque él cree que, en realidad, fue abducida por extraterrestres. Tras acabar sus estudios en la universidad de Oxford, ingresó en la Academia de Quantico, donde se ganó el apodo de 'siniestro'", 2, 'https://www.youtube.com/embed/KKziOmsJxzE',11),
(15, 'Chernobyl', '/posters/15.jpg', "Sigue «la verdadera historia de una de las peores catástrofes provocadas por el hombre y habla de los valientes hombres y mujeres que se sacrificaron para salvar a Europa de un desastre inimaginable. La miniserie se centra en el desgarrador alcance del desastre de la planta nuclear que ocurrió en Ucrania en abril de 1986, revelando cómo y por qué ocurrió, además contando las sorprendentes y notables historias de los héroes que lucharon y cayeron.", 2, 'https://www.youtube.com/embed/s9APLXM9Ei8',1),
(16, 'Westworld', '/posters/16.jpg', "'Westworld' es una oscura odisea acerca del amanecer de la conciencia artificial y la evolución del pecado. Situada en la intersección del futuro cercano y el pasado reimaginado, explora un mundo donde cada apetito humano, sin importar cuán noble o depravado, puede ser saciado. Está ambientada en un parque temático futurista dirigido por el Dr. Robert Ford (Anthony Hopkins). Las instalaciones cuentan con androides caracterizados del western americano, y gracias a ellos los visitantes pueden introducirse en cualquier tipo de fantasía por muy oscura que sea.", 2, 'https://www.youtube.com/embed/qLFBcdd6Qw0',3),
(17, 'Halt and Catch Fire', '/posters/17.jpg', "Situada en los inicios de la década de 1980, un visionario ficticio, un ingeniero electrónico y una prodigiosa ingeniera, se alían a una programadora de software para confrontar con las corporaciones informáticas dominantes de la época. El Personal de la firma y sus socios de negocio, comenzarán una carrera que cambiará la cultura en el Estado de Texas, cuna de las empresas de tecnología, casi de la misma forma que lo es hoy Silicon Valey. \n Esta historia ficticia emula el trabajo realizado, en su momento, por la firma Compaq, cuando clonó el BIOS de las Computadoras Personales IBM, dando vida así al económico mercado de los clones. Mostrando también, a lo largo de sus 4 temporadas, el nacimiento de la arquitectura abierta de hardware, los videojuegos online, las salas de chat y de trueque de productos físicos, los BBS, y las primeras nubes computacionales, hasta la llegada de Internet (sin dejar afuera la guerra de los web browsers).", 2, 'https://www.youtube.com/embed/pWrioRji60A',4);

INSERT INTO Peliculas (idPelicula, Titulo, Poster, Resumen, idCategoria, Trailer, Temporadas)
VALUES
  (18, 'Ava', '/posters/18.jpg', 'Ava es una mortífera asesina a sueldo que trabaja para una organización de operaciones encubiertas, que viaja por todo el mundo acabando con aquellos objetivos que nadie más puede derribar. Cuando uno de sus encargos sale mal, Ava tendrá que luchar por una vida.', 1, NULL,0),
  (19, 'Aves de presa y la fantabulosa emancipación de una Harley Quinn', '/posters/19.jpg', 'Después de separarse de Joker, Harley Quinn y otras tres heroínas (Canario Negro, Cazadora y Renée Montoya) unen sus fuerzas para salvar a una niña (Cassandra Cain) del malvado rey del crimen Máscara Negra.', 1, NULL,0),
  (20, 'Archivo', '/posters/20.jpg', '2038: George Almore está trabajando en una verdadera IA equivalente a la humana. Su último prototipo está casi listo. Esta fase sensible también es la más arriesgada. Especialmente porque tiene un objetivo que debe ocultarse a toda costa: reunirse con su esposa muerta.', 1, 'https://www.youtube.com/embed/VHSoCnDioAo',0),
  (21, 'Jumanji - The next level', '/posters/21.jpg', 'Las aventuras continúan en el fantástico mundo del video juego Jumanji, donde nada es lo que parece. En esta ocasión, los jugadores vuelven al juego, pero sus personajes se han intercambiado entre sí, lo que ofrece un curioso plantel: los mismos héroes con distinta apariencia y habilidades. Pero, ¿dónde está el resto de la gente?', 1, 'https://www.youtube.com/embed/rBxcF-r9Ibs',0),
  (22, '3022', '/posters/22.jpg', 'La película está ambientada en una estación espacial en el futuro. La tripulación sufre un estrés traumático y considera abandonar su misión después de observar lo que creen que es la destrucción de la Tierra. La película se muestra como una serie de flashbacks y flash-forward.', 1, 'https://www.youtube.com/embed/AGQ7OkmIx4Q',0),
  (23, 'IT - Capítulo 2', '/posters/23.jpg', 'En este segundo capitulo Han pasado 27 años desde que el \'Club de los Perdedores\', formado por Bill, Berverly, Richie, Ben, Eddie, Mike y Stanley, se enfrentaran al macabro y despiadado Pennywise (Bill Skarsgård). En cuanto tuvieron oportunidad, abandonaron el pueblo de Derry, en el estado de Maine, que tantos problemas les había ocasionado. Sin embargo, ahora, siendo adultos, parece que no pueden escapar de su pasado. Todos deberán enfrentarse de nuevo al temible payaso para descubrir si de verdad están preparados para superar sus traumas de la infancia.', 1, 'https://www.youtube.com/embed/hZeFeYSmBcg',0),
  (24, 'Pantera Negra', '/posters/24.jpg', 'T’Challa (Chadwick Boseman) regresa a su hogar en la apartada nación africana de Wakanda para servir como líder de su país. Tras suceder a su padre en el trono, pasa a convertirse en Pantera Negra, una sigilosa criatura de la noche, con agudos sentidos felinos y otras habilidades como súper fuerza e inteligencia, agilidad, estrategia o maestro del combate sin armas. Es bajo el liderazgo de T’Challa como Wakanda consigue convertirse en una de las naciones más ricas y tecnológicamente avanzadas del planeta.', 1, 'https://www.youtube.com/embed/BE6inv8Xh4A',0),
  (25, 'Contra lo imposible (Ford versus Ferrari)', '/posters/25.jpg', 'Los ganadores del Premio de la Academia® Matt Damon y Christian Bale protagonizan CONTRA LO IMPOSIBLE, basada en la historia real del visionario diseñador americano de automóviles Carroll Shelby (Damon) y el intrépido piloto británico Ken Miles (Bale). Juntos construyen un nuevo coche de carreras para Ford Motor Company y así enfrentar a Enzo Ferrari en las 24 Horas de Le Mans en Francia en 1966.', 1, 'https://www.youtube.com/embed/SOVb0-2g1Q0',0),
  (26, 'Centígrados', '/posters/26.jpg', 'Una joven pareja estadounidense viaja a las montañas árticas de Noruega. Después de detenerse durante una tormenta de nieve, se despiertan atrapados en su SUV, enterrados bajo capas de nieve y hielo.', 1, NULL,0);

INSERT INTO Peliculas (idPelicula, Titulo, Poster, Resumen, idCategoria, Trailer, Temporadas)
VALUES
  (27, 'DOOM: Aniquilación', '/posters/27.jpg', 'Doom: Aniquilación sigue a un grupo de marines espaciales que han respondido a una llamada de alerta de una base en la luna marciana, solo para descubrir que ha sido tomada por criaturas demoníacas que amenazan con desatar el infierno en la tierra.', 1, 'https://www.youtube.com/embed/nat3u3gAVLE',0),
  (28, 'Contagio', '/posters/28.jpg', 'De repente, sin saber cuál es su origen, aunque todo hace sospechar que comienza con el viaje de una norteamericana a un casino de Hong Kong, un virus mortal comienza a propagarse por todo el mundo. En pocos días, la enfermedad empieza a diezmar a la población. El contagio se produce por mero contacto entre los seres humanos. Un thriller realista y sin efectos especiales sobre los efectos de una epidemia.', 1, 'https://www.youtube.com/embed/4sYSyuuLk5g',0),
  (29, 'Viuda Negra', '/posters/29.jpg', 'Primera pelicula individual de la Viuda Negra en el universo cinematografico de Marvel, contando su historia desde que se inició como doble agente rusa, su niñez, sus misiones, y su actualidad, después de Avengers.', 1, 'https://www.youtube.com/embed/BIn8iANwEog',0),
  (30, 'The Martian', '/posters/30.jpg', 'Durante una misión a Marte de la nave tripulada Ares III, una fuerte tormenta se desata dando por desaparecido y muerto al astronauta Mark Watney (Matt Damon), sus compañeros toman la decisión de irse pero él ha sobrevivido. Está solo y sin apenas recursos en el planeta. Con muy pocos medios deberá recurrir a sus conocimientos, su sentido del humor y un gran instinto de supervivencia para lograr sobrevivir y comunicar a la Tierra que todavía está vivo esperando que acudan en su rescate.', 1, 'https://www.youtube.com/embed/XvB58bCVfng',0),
  (31, 'Ex-Machina', '/posters/31.jpg', 'Un programador multimillonario selecciona a Caleb, un joven empleado de su empresa, para que pase una semana en un lugar remoto con el objetivo de que participe en un test en el que estará involucrada su última creación: un robot-mujer en el que inteligencia artificial lo es todo.', 1, 'https://www.youtube.com/embed/XRYL5spvEcI',0),
  (32, 'Jurassic World', '/posters/32.jpg', 'Veintidós años después de lo ocurrido en Jurassic Park, la isla Nublar ha sido transformada en un enorme parque temático, Jurassic Wold, con versiones «domesticadas» de algunos de los dinosaurios más conocidos. Cuando todo parece ir sobre ruedas y ser el negocio del siglo, un nuevo dinosaurio de especie desconocida, pues ha sido creado manipulando genéticamente su ADN, y que resulta ser mucho más inteligente de lo que se pensaba, se escapa de su recinto y comienza a causar estragos entre los visitantes del Parque.', 1, NULL,0),
  (33, 'Soy leyenda', '/posters/33.jpg', 'Años después de que una plaga mate a la mayoría de la humanidad y transforme al resto en monstruos, el único superviviente en la ciudad de Nueva York lucha valientemente para encontrar una cura.', 1, 'https://www.youtube.com/embed/dtKMEAXyPkg',0),
  (34, 'El primer hombre en la luna', '/posters/34.jpg', 'Cuenta la historia de la misión de la NASA que llevó al primer hombre a la luna, centrada en Neil Armstrong (interpretado por Ryan Gosling) y el periodo comprendido entre los años 1961 y 1969. Un relato en primera persona, basado en la novela de James R. Hansen, que explora el sacrificio y el precio que representó, tanto para Armstrong como para Estados Unidos, una de las misiones más peligrosas de la historia.', 1, NULL,0),
  (35, 'Titanes del pacífico - La insurrección', '/posters/35.jpg', 'Han pasado 10 años tras la primera invasión que sufrió la humanidad, pero la lucha aún no ha terminado. El planeta vuelve a ser asediado por los Kaiju, una raza de alienígenas colosales, que emergen desde un portal interdimensional con el objetivo de destruir a la raza humana. Ante esta nueva amenaza, los Jaegers, robots gigantes de guerra pilotados por dos personas para sobrellevar la inmensa carga neuronal que conlleva manipularlos, ya no están a la altura de lo que se les viene encima. Será entonces cuando los supervivientes de la primera invasión, además de nuevos personajes como el hijo de Pentecost, tendrán que idear la manera de sorprender al enorme enemigo, apostando por nuevas estrategias defensivas y de ataque. Con la Tierra en ruinas e intentando reconstruirse, esta nueva batalla puede ser decisiva para el futuro.', 1, NULL,0);



-- delete from Generos;
INSERT INTO Generos (Detalle) 
VALUES 
	('Ciencia Ficción'), ('Fantasía'), ('Drama'), ('Ficción'), 
	('Sucesos'), ('Misterio'), ('Hechos verídicos'), ('Crimen'), ('Suspenso'), ('Aventura'), ('Sci-Fi'), 
	('Acción'), ('Comedia'), ('Familia'), ('Western'), ('Tecnología'), ('Terror'), ('Historia'), ('Intriga')
;


-- delete from paises;
INSERT INTO Paises (Nombre)
VALUES
('Estados Unidos'),
('Hungría'),
('Reino Unido'),
('Emiratos Árabes Unidos'),
('Canadá'),
('China');


-- DELETE FROM actores;
INSERT INTO Actores (Nombre) VALUES
('Claire Foy'), ('Olivia Colman'), ('Matt Smith'), ('Tobias Menzies'), ('Vanesa Kirby'), ('Helena Bonham Carter'),
('Lili Reinhart'), ('Casey Cott'), ('Camila Mendes'), ('Marisol Nichols'), ('Madelaine Petsch'), ('Mädchen Amick'),
('Pedro Pascal'), ('Carl Weathers'), ('Misty Rosas'), ('Chris Bartlett'), ('Rio Hackford'), ('Giancarlo Esposito'),
('Tom Hopper'), ('David Castañeda'), ('Emmy Raver-Lampman'), ('Robert Sheehan'), ('Aidan Gallagher'), ('Elliot Page'),
('Anya Taylor-Joy'), ('Thomas Brodie-Sangster'), ('Harry Melling'), ('Moses Ingram'), ('Chloe Pirrie'), ('Janina Elkin'),
('Millie Bobby Brown'), ('Henry Cavill'), ('Sam Claflin'), ('Louis Partridge'), ('Adeel Akhtar'),
('Joaquin Phoenix'), ('Robert De Niro'), ('Zazie Beetz'), ('Frances Conroy'), ('Brett Cullen'), ('Shea Whigham'),
('Robert Downey Jr.'), ('Chris Evans'), ('Mark Ruffalo'), ('Chris Hemsworth'), ('Scarlett Johansson'), ('Jeremy Renner'),
('Emilia Clarke'), ('Lena Headey'), ('Sophie Turner'), ('Kit Harington'), ('Peter Dinklage'), ('Nikolaj Coster-Waldau'),
('Grant Gustin'), ('Carlos Valdes'), ('Danielle Panabaker'), ('Candice Patton'), ('Jesse L. Martin'), ('Tom Cavanagh'),
('Jim Parsons'), ('Johnny Galecki'), ('Kaley Cuoco'), ('Simon Helberg'), ('Kunal Nayyar'), ('Melissa Rauch'), ('Mayim Bialik'),
('Jennifer Aniston'), ('Courteney Cox'), ('Lisa Kudrow'), ('David Schwimmer'), ('Matthew Perry'), ('Matt LeBlanc'), 
('Amybeth McNulty'), ('Geraldine James'), ('R. H. Thomson'), ('Corrine Koslo'), ('Dalila Bela'), ('Lucas Jade Zumann'),
('Gillian Anderson'), ('David Duchovny'), ('Mitch Pileggi'), ('Robert Patrick'), ('Tom Braidwood'), ('Bruce Harwood'),
('Jared Harris'), ('Stellan Skarsgård'), ('Emily Watson'), ('Paul Ritter'), ('Jessie Buckley'), ('Adam Nagaitis'),
('Evan Rachel Wood'), ('Thandie Newton'), ('Jeffrey Wright'), ('Tessa Thompson'), ('Ed Harris'), ('Luke Hemsworth'),
('Lee Pace'), ('Scoot McNairy'), ('Mackenzie Davis'), ('Kerry Bishé'), ('Toby Huss'), ('Alana Cavanaugh'), 
('Jessica Chastain'), ('John Malkovich'), ('Colin Farrell'), ('Common'), ('Geena Davis'), ('Ioan Gruffudd'),
('Margot Robbie'), ('Ewan McGregor'), ('Mary Elizabeth Winstead'), ('Jurnee Smollett'), ('Rosie Perez'), ('Chris Messina'),
('Stacy Martin'), ('Rhona Mitra'), ('Theo James'), ('Peter Ferdinando'), ('Lia Williams'), ('Toby Jones'),
('Dwayne Johnson'), ('Kevin Hart'), ('Jack Black'), ('Karen Gillan'), ('Awkwafina'), ('Nick Jonas'),
('Miranda Cosgrove'), ('Kate Walsh'), ('Omar Epps'), ('Angus Macfadyen'), ('Jorja Fox'), ('Enver Gjokaj'),
('Bill Skarsgård'), ('Jessica Chastain'), ('Bill Hader'), ('James McAvoy'), ('Isaiah Mustafa'), ('Jay Ryan'),
('Chadwick Boseman'), ('Michael B. Jordan'), ('Lupita Nyong o'), ('Danai Gurira'), ('Martin Freeman'), ('Daniel Kaluuya'),
('Christian Bale'), ('Matt Damon'), ('Caitriona Balfe'), ('Josh Lucas'), ('Noah Jupe'), ('Jon Bernthal'),
('Génesis Rodríguez'), ('Vincent Piazza'), ('Benjamin Sokolow'), ('Emily Bayiokos'), 
('Amy Manson'), ('Luke Allen-Gale'), ('Nina Bergman'), ('Dominic Mafham'), ('James Weber Brown'), ('Lorina Kamburova'),
('Marion Cotillard'), ('Laurence Fishburne'), ('Jude Law'), ('Kate Winslet'), ('Jennifer Ehle'), ('Gwyneth Paltrow'), 
('Florence Pugh'), ('David Harbour'), ('O.T. Fagbenle'), ('Rachel Weisz'), ('William Hurt'), ('Ray Winstone'), 
('Kristen Wiig'), ('Jeff Daniels'), ('Michael Peña'), ('Sean Bean'), ('Kate Mara'),
('Alicia Vikander'), ('Domhnall Gleeson'), ('Oscar Isaac'), ('Sonoya Mizuno'), ('Corey Johnson'), ('Claire Selby');
INSERT INTO Actores (Nombre) VALUES
('Gana Bayarsaihan'),('Gana Bayarsaikhan'), 
('Bryce Dallas Howard'), ('Chris Pratt'), ('Irrfan Khan'), ('Vincent D Onofrio'), ('Omar Sy'), ('Nick Robinson'), ('Judy Greer'),
('Will Smith'), ('Alice Braga'), ('Charlie Tahan'), ('Dash Mihok'), ('Salli Richardson-Whitfield'), ('Willow Smith'), ('Emma Thompson'),
('Ryan Gosling'), ('Jason Clarke'), ('Kyle Chandler'), ('Corey Stoll'), ('Patrick Fugit'),
('John Boyega'), ('Scott Eastwood'), ('Cailee Spaeny'), ('Jing Tian'), ('Rinko Kikuchi'), ('Burn Gorman');


-- delete from PeliculasPaises;
INSERT INTO PeliculasPaises (idPelicula,idPais)
values
(1, 3),
(2, 1),
(3, 1),
(4, 1), (4, 5),
(5, 1),
(6, 1), (6, 3),
(7, 1),
(8, 1),
(9, 1), (9, 3),
(10, 1),
(11, 1),
(12, 1),
(13, 5),
(14, 1),
(15, 1), (15, 3),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1), (20, 2),
(21, 1), (21, 5),
(22, 1),
(23, 1), (23, 5),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(28, 1), (28, 4),
(29, 1),
(30, 1), (30, 3),
(31, 3),
(32, 1),
(33, 1),
(34, 1),
(35, 1),
(35, 6);



-- DELETE FROM PeliculasGeneros
INSERT INTO PeliculasGeneros (idPelicula, idGenero)
VALUES
(1, 3),
(1, 7),
(2, 3),
(2, 6),
(2, 4),
(3, 1),
(3, 2),
(4, 1),
(4, 2),
(5, 3),
(5, 4),
(5, 5),
(6, 4),
(6, 3),
(6, 6),
(7, 8),
(7, 9),
(7, 3),
(8, 10),
(8, 11),
(8, 12),
(9, 10),
(9, 2),
(9, 3),
(10, 1),
(10, 2),
(11, 13),
(11, 2),
(11, 4),
(12, 13),
(12, 14),
(12, 3),
(13, 3),
(13, 14),
(13, 15),
(14, 3),
(14, 1),
(15, 3),
(15, 7),
(16, 15),
(16, 1),
(17, 4),
(17, 3),
(17, 16),
(18, 12),
(18, 3),
(18, 9),
(19, 12),
(19, 4),
(19, 13),
(20, 12),
(20, 11),
(20, 9),
(21, 13),
(20, 4),
(20, 10),
(22, 1),
(22, 9),
(23, 17),
(23, 9),
(23, 2),
(24, 12),
(24, 10),
(24, 2),
(25, 3),
(25, 18),
(25, 10),
(26, 3),
(26, 9),
(26, 19),
(27, 12),
(27, 11),
(27, 17),
(28, 3),
(28, 9),
(28, 4),
(29, 3),
(29, 12),
(29, 10),
(30, 3),
(30, 11),
(30, 10),
(31, 3),
(31, 11),
(31, 9),
(32, 9),
(32, 10),
(32, 4),
(33, 3),
(33, 17),
(33, 4),
(34, 3),
(34, 7),
(35, 12),
(35, 2),
(35, 11);


-- DELETE FROM peliculasActores;
INSERT INTO peliculasActores (idPelicula, idActor)
VALUES
(1, 2),
(1, 1),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(2, 7),
(2, 8),
(2, 9),
(2, 10),
(2, 11),
(2, 12),
(3, 13),
(3, 14),
(3, 15),
(3, 16),
(3, 17),
(3, 18),
(4, 19),
(4, 20),
(4, 21),
(4, 22),
(4, 23),
(4, 24),
(5, 25),
(5, 26),
(5, 27),
(5, 28),
(5, 29),
(5, 30),
(6, 31),
(6, 32),
(6, 33),
(6, 6),
(6, 34),
(6, 35),
(7, 36),
(7, 37),
(7, 38),
(7, 39),
(7, 40),
(7, 41),
(8, 42),
(8, 43),
(8, 44),
(8, 45),
(8, 46),
(8, 47),
(9, 48),
(9, 49),
(9, 50),
(9, 51),
(9, 52),
(9, 53),
(10, 54),
(10, 55),
(10, 56),
(10, 57),
(10, 58),
(10, 59),
(11, 60),
(11, 61),
(11, 62),
(11, 63),
(11, 64),
(11, 65),
(11, 66),
(12, 67),
(12, 68),
(12, 69),
(12, 70),
(12, 71),
(12, 72),
(13, 73),
(13, 74),
(13, 75),
(13, 76),
(13, 77),
(13, 78),
(14, 79),
(14, 80),
(14, 81),
(14, 82),
(14, 83),
(14, 84),
(15, 85),
(15, 86),
(15, 87),
(15, 88),
(15, 89),
(15, 90),
(16, 91),
(16, 92),
(16, 93),
(16, 94),
(16, 95),
(16, 96),
(17, 97),
(17, 98),
(17, 99),
(17, 100),
(17, 101),
(17, 102),
(18, 103),
(18, 104),
(18, 105),
(18, 106),
(18, 107),
(18, 108),
(19, 109),
(19, 110),
(19, 111),
(19, 112),
(19, 113),
(19, 114),
(20, 115),
(20, 116),
(20, 117),
(20, 118),
(20, 119),
(20, 120),
(21, 121),
(21, 122),
(21, 123),
(21, 124),
(21, 125),
(21, 126),
(22, 127),
(22, 128),
(22, 129),
(22, 130),
(22, 131),
(22, 132),
(23, 133),
(23, 134),
(23, 135),
(23, 136),
(23, 137),
(23, 138),
(24, 139),
(24, 140),
(24, 141),
(24, 142),
(24, 143),
(24, 144),
(25, 145),
(25, 146),
(25, 147),
(25, 148),
(25, 149),
(25, 150),
(26, 151),
(26, 152),
(26, 153),
(26, 154),
(27, 155),
(27, 156),
(27, 157),
(27, 158),
(27, 159),
(27, 160),
(28, 161),
(28, 146),
(28, 162),
(28, 163),
(28, 164),
(28, 165),
(28, 166),
(29, 46),
(29, 167),
(29, 168),
(29, 169),
(29, 170),
(29, 171),
(29, 172),
(30, 146),
(30, 134),
(30, 173),
(30, 174),
(30, 175),
(30, 176),
(30, 177),
(31, 178),
(31, 179),
(31, 180),
(31, 181),
(31, 182),
(31, 183),
(31, 184),
(32, 185),
(32, 186),
(32, 187),
(32, 188),
(32, 189),
(32, 190),
(32, 191),
(33, 193),
(33, 194),
(33, 195),
(33, 196),
(33, 197),
(33, 198),
(33, 199),
(34, 200),
(34, 1),
(34, 201),
(34, 202),
(34, 203),
(34, 204),
(35, 205),
(35, 206),
(35, 207),
(35, 208),
(35, 209),
(35, 210)
;
