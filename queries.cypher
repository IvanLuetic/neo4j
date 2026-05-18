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

Zadatak 4

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

MATCH (o:Osoba)-[:ŽIVI_U]->(g:Grad) → vraća samo osobe koje imaju poveznicu prema gradu.

OPTIONAL MATCH (o:Osoba)-[:ŽIVI_U]->(g:Grad) → vraća sve osobe, a za one bez grada vraća null u stupcu g.naziv.

MATCH p = shortestPath(
  (a:Osoba {ime: 'Christopher Nolan'})
  -[*]-
  (b:Osoba {ime: 'Bong Joon-ho'})
)
RETURN p, length(p) AS duljina_puta


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


