1.  7474 i 7687. Prvi služi za Neo4j browser (sučelje), a drugi za Bolt protokol.

2. CREATE kreira novi čvor bez obzira je li već postoji, a MERGE prvo provjerava da li postoji taj čvor, a ako ne, onda ga kreira.

4. MATCH vraća samo one uzorke koji postoje u bazi, OPTIONAL MATCH vraća rezultat i ako dio uzorka ne postoji (vraća null vrijednost)
MATCH (o:Osoba)-[:ŽIVI_U]->(g:Grad) - vraća samo osobe koje imaju poveznicu prema gradu.
OPTIONAL MATCH (o:Osoba)-[:ŽIVI_U]->(g:Grad) - vraća sve osobe, a za one bez poveznice vraća null u g.naziv.

5. Ako shortestPath ne pronađe put, ne vraća ništa. Vrijednost puta je NULL jer ne postoji povezanost između čvorova

Zavrsni.
Neo4j bi bolje odgovarao u bazi sa vrlo povezanim podacima i kada imamo puno upita fokusiranih na veze između podataka, a ne same podatke. U primjeru ovog projekta, to puno olakšava stvari poput sličnosti između izvođača, što se može koristiti za preporuke itd. 
U relacijskoj bazi bi bilo puno teže raditi upite koji rade istu stvar kao shortestPath, jer bi zahtijevalo komplicirane i manje efikasne upite. Sa neo4j možemo raditi kompleksne sisteme preporuka sa jednostavnim čvorovima između entiteta.