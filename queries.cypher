Zadatak 1
RETURN 'Neo4j radi!' AS poruka

Zadatak 2

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

Zadatak 3

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

Zadatak 4