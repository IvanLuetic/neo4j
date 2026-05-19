// Zadatak 1
RETURN 'Neo4j radi!' AS poruka

// Zadatak 2

CREATE (f1:Film {naslov: 'Inception', godina: 2010, ocjena: 8.8, zanr: 'sci-fi'})
CREATE (f2:Film {naslov: 'The Dark Knight', godina: 2008, ocjena: 9.0, zanr: 'akcija'})
CREATE (f3:Film {naslov: 'Interstellar', godina: 2014, ocjena: 8.6, zanr: 'sci-fi'})
CREATE (f4:Film {naslov: 'Parasite', godina: 2019, ocjena: 8.6, zanr: 'triler'})
CREATE (f5:Film {naslov: 'The Godfather', godina: 1972, ocjena: 9.2, zanr: 'drama'})
CREATE (f6:Film {naslov: 'Memento', godina: 2000, ocjena: 8.4, zanr: 'triler'})

CREATE (o1:Osoba {ime: 'Christopher Nolan', dob: 54})
CREATE (o2:Osoba {ime: 'Bong Joon-ho', dob: 55})
CREATE (o3:Osoba {ime: 'Francis Ford Coppola', dob: 85})
CREATE (o4:Osoba {ime: 'Leonardo DiCaprio', dob: 50})
CREATE (o5:Osoba {ime: 'Christian Bale', dob: 50})


CREATE (g1:Grad {naziv: 'Los Angeles'})
CREATE (g2:Grad {naziv: 'London'})
CREATE (g3:Grad {naziv: 'Seoul'})

CREATE (o4:Osoba {ime: 'Extra actor', dob: 50})
CREATE (o5:Osoba {ime: 'Another actor', dob: 50})

CREATE (g3:Grad {naziv: 'New city'})

// Zadatak 3

MATCH (o:Osoba {ime: 'Christopher Nolan'}), (f:Film {naslov: 'Inception'})
CREATE (o)-[:REZIRAO]->(f);

MATCH (o:Osoba {ime: 'Christopher Nolan'}), (f:Film {naslov: 'The Dark Knight'})
CREATE (o)-[:REZIRAO]->(f);

MATCH (o:Osoba {ime: 'Christopher Nolan'}), (f:Film {naslov: 'Interstellar'})
CREATE (o)-[:REZIRAO]->(f);

MATCH (o:Osoba {ime: 'Christopher Nolan'}), (f:Film {naslov: 'Memento'})
CREATE (o)-[:REZIRAO]->(f);

MATCH (o:Osoba {ime: 'Bong Joon-ho'}), (f:Film {naslov: 'Parasite'})
CREATE (o)-[:REZIRAO]->(f);

MATCH (o:Osoba {ime: 'Francis Ford Coppola'}), (f:Film {naslov: 'The Godfather'})
CREATE (o)-[:REZIRAO]->(f);

MATCH (o:Osoba {ime: 'Leonardo DiCaprio'}), (f:Film {naslov: 'Inception'})
CREATE (o)-[:GLUMIO_U]->(f);

MATCH (o:Osoba {ime: 'Christian Bale'}), (f:Film {naslov: 'The Dark Knight'})
CREATE (o)-[:GLUMIO_U]->(f);

MATCH (o:Osoba {ime: 'Christian Bale'}), (f:Film {naslov: 'The Dark Knight'})
MERGE (o)-[:GLUMIO_U]->(f);

MATCH (o:Osoba {ime: 'Christopher Nolan'}), (g:Grad {naziv: 'London'})
CREATE (o)-[:ZIVI_U]->(g);

MATCH (o:Osoba {ime: 'Leonardo DiCaprio'}), (g:Grad {naziv: 'Los Angeles'})
CREATE (o)-[:ZIVI_U]->(g);

MATCH (o:Osoba {ime: 'Bong Joon-ho'}), (g:Grad {naziv: 'Seoul'})
CREATE (o)-[:ZIVI_U]->(g);

MATCH (a:Osoba {ime: 'Christopher Nolan'}), (b:Osoba {ime: 'Christian Bale'})
CREATE (a)-[:PRIJATELJ {od: 2000}]->(b);

MATCH (a:Osoba {ime: 'Leonardo DiCaprio'}), (b:Osoba {ime: 'Christopher Nolan'})
CREATE (a)-[:PRIJATELJ {od: 2010}]->(b);

MATCH (n)-[r]->(m) RETURN n, r, m

MATCH (o:Osoba {ime: 'Extra Actor'}), (f:Film {naslov: 'Inception'})
CREATE (o)-[:GLUMIO_U]->(f);

MATCH (o:Osoba {ime: 'Another actor'}), (f:Film {naslov: 'The Dark Knight'})
CREATE (o)-[:GLUMIO_U]->(f);

MATCH ()-[r]->() RETURN type(r) AS tip, count(*) AS broj ORDER BY broj DESC

// Zadatak 4

MATCH (f:Film)
RETURN f.naslov, f.godina, f.ocjena
ORDER BY f.ocjena DESC

MATCH (f:Film)
WHERE f.ocjena > 8.7
RETURN f.naslov, f.ocjena
ORDER BY f.ocjena DESC

MATCH (o:Osoba)-[:REZIRAO]->(f:Film)
WHERE o.ime = 'Christopher Nolan'
RETURN f.naslov, f.godina, f.ocjena
ORDER BY f.godina

MATCH (o:Osoba)-[:GLUMIO_U]->(f:Film)
WHERE f.zanr = 'sci-fi'
RETURN o.ime AS glumac, f.naslov AS film

MATCH (o:Osoba)-[:REZIRAO]->(f:Film)
RETURN o.ime AS redatelj, collect(f.naslov) AS filmovi
ORDER BY redatelj

MATCH (o:Osoba)
OPTIONAL MATCH (o)-[:REZIRAO]->(f:Film)
RETURN o.ime, count(f) AS broj_reziranih_filmova
ORDER BY broj_reziranih_filmova DESC

// Zadatak 4

MATCH (f:Film)
WHERE f.zanr = 'triler'
RETURN f.naslov, f.ocjena
ORDER BY f.ocjena DESC

MATCH (o:Osoba)-[:ZIVI_U]->(g:Grad)
RETURN o.ime AS redatelj, g.naziv AS grad

MATCH (f:Film)
WHERE f.godina >= 2008 AND f.godina <= 2015
RETURN f.naslov, f.godina, f.ocjena
ORDER BY f.godina;

MATCH (o:Osoba)-[:REZIRAO]->(f:Film)
WITH o, count(f) AS broj_filmova
WHERE broj_filmova > 1
RETURN o.ime AS redatelj, broj_filmova
ORDER BY broj_filmova DESC

// Zadatak 5

MATCH p = shortestPath(
  (a:Osoba {ime: 'Christopher Nolan'})
  -[*]-
  (b:Osoba {ime: 'Bong Joon-ho'})
)
RETURN p, length(p) AS duljina_puta

MATCH (a:Osoba {ime: 'Leonardo DiCaprio'})
MATCH (b:Osoba {ime: 'Christopher Nolan'})
RETURN EXISTS {
  MATCH (a)-[:PRIJATELJ|GLUMIO_U|ZIVI_U*1..3]-(b)
} AS povezani

MATCH p = shortestPath(
  (a:Osoba {ime: 'Christopher Nolan'})
  -[*]-
  (b:Osoba {ime: 'Bong Joon-ho'})
)
RETURN p, length(p) AS duljina_puta

MATCH p = (a:Osoba {ime: 'Leonardo DiCaprio'})
          -[*1..4]-
          (b:Osoba {ime: 'Bong Joon-ho'})
RETURN p, length(p) AS duljina
ORDER BY duljina
LIMIT 5

MATCH (london:Grad {naziv: 'London'})
MATCH (london)-[*1..2]-(connected)
RETURN DISTINCT labels(connected), connected, length(shortestPath((london)-[*]-(connected))) AS udaljenost

MATCH (francis:Osoba {ime: 'Francis Ford Coppola'}), (leo:Osoba {ime: 'Leonardo DiCaprio'})
RETURN EXISTS((francis)-[*1..4]-(leo)) AS povezani

// Zadatak 6

MATCH (f:Film)
RETURN f.zanr AS zanr, count(f) AS broj_filmova
ORDER BY broj_filmova DESC

MATCH (f:Film)
WITH f.zanr AS zanr, count(f) AS broj, avg(f.ocjena) AS prosjecna_ocjena
WHERE broj > 1
RETURN zanr, broj, round(prosjecna_ocjena * 10) / 10 AS ocjena
ORDER BY prosjecna_ocjena DESC

MATCH (o:Osoba)-[:REZIRAO]->(f:Film)
WITH o.ime AS redatelj, count(f) AS filmova, collect(f.naslov) AS naslovi
RETURN redatelj, filmova, naslovi
ORDER BY filmova DESC

MATCH (f:Film)
WITH f.zanr AS zanr, collect(f ORDER BY f.ocjena DESC)[0..3] AS top_filmovi
RETURN zanr,
       [film IN top_filmovi | film.naslov + ' (' + toString(film.ocjena) + ')']
       AS top3


MATCH (f:Film)
RETURN count(f) AS broj_filmova,
       avg(f.ocjena) AS prosjecna_ocjena

    
MATCH (f:Film)
WITH f.zanr AS zanr,
     count(f) AS broj_filmova,
     max(f.ocjena) AS max_ocjena

RETURN zanr, broj_filmova, max_ocjena
ORDER BY broj_filmova DESC

MATCH (o:Osoba)-[:ZIVI_U]->(g:Grad)
WITH g, count(o) AS broj_osoba
ORDER BY broj_osoba DESC
LIMIT 1
MATCH (o:Osoba)-[:ZIVI_U]->(g)
RETURN o.ime AS osoba, g.naziv AS grad;

MATCH (o:Osoba)-[:GLUMIO_U]->(f:Film)

RETURN f.naslov AS film,
       collect(o.ime) AS glumci
ORDER BY film


// Zadatak 7

CREATE INDEX film_ocjena FOR (f:Film) ON (f.ocjena);
CREATE INDEX film_naslov FOR (f:Film) ON (f.naslov);
CREATE INDEX osoba_ime FOR (o:Osoba) ON (o.ime);

CREATE CONSTRAINT film_naslov_unique
FOR (f:Film) REQUIRE f.naslov IS UNIQUE;

CREATE CONSTRAINT film_naslov_nn
FOR (f:Film) REQUIRE f.naslov IS NOT NULL;

SHOW INDEXES;
SHOW CONSTRAINTS;

// Ovo ce baciti gresku jer Inception vec postoji (UNIQUE constraint)
CREATE (f:Film {naslov: 'Inception', godina: 2025, ocjena: 5.0})

// MERGE ce pronaci postojeci film umjesto kreiranja duplikata:
MERGE (f:Film {naslov: 'Inception'})
ON MATCH SET f.opis = 'Klasik Christophera Nolana'
ON CREATE SET f.godina = 2010, f.ocjena = 8.8
RETURN f

// Zavrsni Zadatak

CREATE (:Zanr {naziv: 'Noise Rock'});
CREATE (:Zanr {naziv: 'Drone'});
CREATE (:Zanr {naziv: 'Folk'});
CREATE (:Zanr {naziv: 'Post-Punk'});
CREATE (:Zanr {naziv: 'Electronic'});

CREATE (:Izvodac {ime: 'Swans', drzava: 'SAD', godina_osnivanja: 1982});
CREATE (:Izvodac {ime: 'Natural Snow Buildings', drzava: 'Francuska', godina_osnivanja: 1997});
CREATE (:Izvodac {ime: 'Joy Division', drzava: 'Velika Britanija', godina_osnivanja: 1976});
CREATE (:Izvodac {ime: 'Coil', drzava: 'Velika Britanija', godina_osnivanja: 1982});
CREATE (:Izvodac {ime: 'TwinSisterMoon', drzava: 'SAD', godina_osnivanja: 2001});

CREATE (:Album {naziv: 'Soundtracks for the Blind', godina: 1996, ocjena: 8.9});
CREATE (:Album {naziv: 'The Glowing Man', godina: 2016, ocjena: 9.4});
CREATE (:Album {naziv: 'To Be Kind', godina: 2014, ocjena: 9.2});
CREATE (:Album {naziv: 'The Dance of the Moon and the Sun', godina: 2006, ocjena: 8.7});
CREATE (:Album {naziv: 'The Winter Ray', godina: 2004, ocjena: 8.2});
CREATE (:Album {naziv: 'Unknown Pleasures', godina: 1979, ocjena: 7.9});
CREATE (:Album {naziv: 'Closer', godina: 1980, ocjena: 8.3});
CREATE (:Album {naziv: 'The Ape of Naples', godina: 2005, ocjena: 8.8});
CREATE (:Album {naziv: 'Love\'s Secret Domain', godina: 1991, ocjena: 7.5});
CREATE (:Album {naziv: 'When Stars Glide Through Solid', godina: 2008, ocjena: 7.9});

MATCH (i:Izvodac {ime: 'Swans'}), (a:Album {naziv: 'To Be Kind'}) CREATE (i)-[:OBJAVIO]->(a);
MATCH (i:Izvodac {ime: 'Swans'}), (a:Album {naziv: 'Soundtracks for the Blind'}) CREATE (i)-[:OBJAVIO]->(a);
MATCH (i:Izvodac {ime: 'Swans'}), (a:Album {naziv: 'The Glowing Man'}) CREATE (i)-[:OBJAVIO]->(a);
MATCH (i:Izvodac {ime: 'Natural Snow Buildings'}), (a:Album {naziv: 'The Dance of the Moon and the Sun'}) CREATE (i)-[:OBJAVIO]->(a);
MATCH (i:Izvodac {ime: 'Natural Snow Buildings'}), (a:Album {naziv: 'The Winter Ray'}) CREATE (i)-[:OBJAVIO]->(a);
MATCH (i:Izvodac {ime: 'Joy Division'}), (a:Album {naziv: 'Unknown Pleasures'}) CREATE (i)-[:OBJAVIO]->(a);
MATCH (i:Izvodac {ime: 'Joy Division'}), (a:Album {naziv: 'Closer'}) CREATE (i)-[:OBJAVIO]->(a);
MATCH (i:Izvodac {ime: 'Coil'}), (a:Album {naziv: 'The Ape of Naples'}) CREATE (i)-[:OBJAVIO]->(a);
MATCH (i:Izvodac {ime: 'Coil'}), (a:Album {naziv: 'Love\'s Secret Domain'}) CREATE (i)-[:OBJAVIO]->(a);
MATCH (i:Izvodac {ime: 'TwinSisterMoon'}), (a:Album {naziv: 'When Stars Glide Through Solid'}) CREATE (i)-[:OBJAVIO]->(a);

MATCH (a:Album {naziv: 'To Be Kind'}), (z:Zanr {naziv: 'Noise Rock'}) CREATE (a)-[:PRIPADA_ZANRU]->(z);
MATCH (a:Album {naziv: 'Soundtracks for the Blind'}), (z:Zanr {naziv: 'Drone'}) CREATE (a)-[:PRIPADA_ZANRU]->(z);
MATCH (a:Album {naziv: 'The Glowing Man'}), (z:Zanr {naziv: 'Noise Rock'}) CREATE (a)-[:PRIPADA_ZANRU]->(z);
MATCH (a:Album {naziv: 'The Dance of the Moon and the Sun'}), (z:Zanr {naziv: 'Folk'}) CREATE (a)-[:PRIPADA_ZANRU]->(z);
MATCH (a:Album {naziv: 'The Winter Ray'}), (z:Zanr {naziv: 'Drone'}) CREATE (a)-[:PRIPADA_ZANRU]->(z);
MATCH (a:Album {naziv: 'Unknown Pleasures'}), (z:Zanr {naziv: 'Post-Punk'}) CREATE (a)-[:PRIPADA_ZANRU]->(z);
MATCH (a:Album {naziv: 'Closer'}), (z:Zanr {naziv: 'Post-Punk'}) CREATE (a)-[:PRIPADA_ZANRU]->(z);
MATCH (a:Album {naziv: 'The Ape of Naples'}), (z:Zanr {naziv: 'Electronic'}) CREATE (a)-[:PRIPADA_ZANRU]->(z);
MATCH (a:Album {naziv: 'Love\'s Secret Domain'}), (z:Zanr {naziv: 'Electronic'}) CREATE (a)-[:PRIPADA_ZANRU]->(z);
MATCH (a:Album {naziv: 'When Stars Glide Through Solid'}), (z:Zanr {naziv: 'Folk'}) CREATE (a)-[:PRIPADA_ZANRU]->(z);

MATCH (a:Izvodac {ime: 'Natural Snow Buildings'}), (b:Izvodac {ime: 'TwinSisterMoon'}) CREATE (a)-[:SURADIVAO_S]->(b);
MATCH (a:Izvodac {ime: 'Swans'}), (b:Izvodac {ime: 'Coil'}) CREATE (a)-[:SURADIVAO_S]->(b);

MATCH (i:Izvodac {ime: 'Swans'})-[:OBJAVIO]->(a:Album)
RETURN a.naziv AS album, a.godina AS godina
ORDER BY a.godina ASC

MATCH (i:Izvodac {ime: 'Swans'})-[:OBJAVIO]->(a:Album)
RETURN a.naziv AS album, a.godina AS godina
ORDER BY a.godina ASC;

MATCH (a:Album)
WHERE a.ocjena > 8.0
RETURN a.naziv AS album, a.ocjena AS ocjena
ORDER BY a.ocjena DESC;

MATCH (i:Izvodac)
OPTIONAL MATCH (i)-[:OBJAVIO]->(a:Album)
RETURN i.ime AS izvodac, COUNT(a) AS broj_albuma
ORDER BY broj_albuma DESC;

MATCH (start:Izvodac {ime: 'Swans'}), (end:Izvodac {ime: 'TwinSisterMoon'})
MATCH p = shortestPath((start)-[:SLICAN|SURADIVAO_S*]-(end))
RETURN p;

MATCH (a:Album)-[:PRIPADA_ZANRU]->(z:Zanr)
WITH z.naziv AS zanr, AVG(a.ocjena) AS prosjek, COUNT(a) AS broj_albuma
WHERE prosjek > 7.5
RETURN zanr, broj_albuma, prosjek
ORDER BY prosjek DESC;

DROP INDEX izvodac_ime IF EXISTS;
CREATE CONSTRAINT izvodac_ime_unique FOR (i:Izvodac) REQUIRE i.ime IS UNIQUE;
CREATE INDEX album_ocjena FOR (a:Album) ON (a.ocjena);