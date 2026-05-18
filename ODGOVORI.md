1.  7474 i 7687. Prvi služi za Neo4j browser (sučelje), a drugi za Bolt protokol.

2. CREATE kreira novi čvor bez obzira je li već postoji, a MERGE prvo provjerava da li postoji taj čvor, a ako ne, onda ga kreira.

3. MATCH vraća samo one uzorke koji postoje u bazi, OPTIONAL MATCH vraća rezultat i ako dio uzorka ne postoji (vraća null vrijednost)
MATCH (o:Osoba)-[:ŽIVI_U]->(g:Grad) - vraća samo osobe koje imaju poveznicu prema gradu.
OPTIONAL MATCH (o:Osoba)-[:ŽIVI_U]->(g:Grad) - vraća sve osobe, a za one bez poveznice vraća null u g.naziv.

4. Ako ne pronađe put, ne vraća ništa. Vrijednost puta je NULL jer ne postoji povezanost između čvorova

