--zobrazeni data a casu--
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';



--vlozeni udaju do tabulek--
INSERT INTO Pracovnik VALUES(DEFAULT,'Jan','Novák','xnovak01@knihovna.cz');
INSERT INTO Pracovnik VALUES(DEFAULT,'Andrej','Bureš','xbures00@knihovna.cz');
INSERT INTO Pracovnik VALUES(DEFAULT,'Gregor','Johann Mendel','xmendel03@knihovna.cz');
INSERT INTO Pracovnik VALUES(DEFAULT,'František','Palacký','xpalacky00@knihovna.cz');
INSERT INTO Pracovnik VALUES(DEFAULT,'Karel','IV.','xkarel04@knihovna.cz');

INSERT INTO Ctenar VALUES(DEFAULT,TO_DATE('2022-06-05', 'YYYY-MM-DD'),'Franta','Vomáčka','vomac@email.cz','606909007','Jugoslávská',29,'Brno',61300,'CZE');
INSERT INTO Ctenar VALUES(DEFAULT,TO_DATE('2022-06-30', 'YYYY-MM-DD'),'Miloš','Pudding','mipad@gmail.com','723658965','Vídeňská',49,'Brno',63900,'CZE');
INSERT INTO Ctenar VALUES(DEFAULT,TO_DATE('2022-07-15', 'YYYY-MM-DD'),'Milan','Rastislav Štefánik','genstef@tatry.sk','456987321','Brněnská',7,'Bratislava',11300,'SVK');
INSERT INTO Ctenar VALUES(DEFAULT,TO_DATE('2022-02-01', 'YYYY-MM-DD'),'Edvard','Beneš','benes84@gov.csr','32546','Exilová',13,'Praha',00700,'CZE');
INSERT INTO Ctenar VALUES(DEFAULT,TO_DATE('2022-10-12', 'YYYY-MM-DD'),'Dennis','MacAlistair Ritchie','cdennis@comps.com','11332489963','Harvard',69,'Berkeley',10110,'USA');

INSERT INTO Tema VALUES(DEFAULT,'Hobby');
INSERT INTO Tema VALUES(DEFAULT,'Zahrada');
INSERT INTO Tema VALUES(DEFAULT,'Sport');
INSERT INTO Tema VALUES(DEFAULT,'Domov');
INSERT INTO Tema VALUES(DEFAULT,'Technika');

INSERT INTO Zanr VALUES(DEFAULT,'Drama');
INSERT INTO Zanr VALUES(DEFAULT,'Science fiction');
INSERT INTO Zanr VALUES(DEFAULT,'Novela');
INSERT INTO Zanr VALUES(DEFAULT,'Fantasy');
INSERT INTO Zanr VALUES(DEFAULT,'Horor');

INSERT INTO Autor VALUES(DEFAULT,'John Ronald','Reuel Tolkien',1892,1973,'ENG');
INSERT INTO Autor VALUES(DEFAULT,'Ladislav','Fuks',1923,1994,'CZE');
INSERT INTO Autor VALUES(DEFAULT,'Božena','Němcová',1820,1862,'CZE');
INSERT INTO Autor VALUES(DEFAULT,'Václav','Havel',1936,2011,'CZE');
INSERT INTO Autor VALUES(DEFAULT,'Karel','Čapek',1887,1945,'CZE');

INSERT INTO Titul VALUES(DEFAULT,'Spalovač mrtvol',NULL,NULL); -- Novela,Fuks
INSERT INTO Titul VALUES(DEFAULT,'Audience',NULL,NULL); -- Drama,Havel
INSERT INTO Titul VALUES(DEFAULT,'Babička','Obrazy venkovského života',NULL); -- Novela,Němcová
INSERT INTO Titul VALUES(DEFAULT,'R.U.R.',NULL,NULL); -- Science fiction,Čapek
INSERT INTO Titul VALUES(DEFAULT,'Válka s Mloky',NULL,NULL); -- Science fiction,Čapek
INSERT INTO Titul VALUES(DEFAULT,'Můj bylinkový diář',NULL,'Poznání'); -- Můj bylinkový diář



INSERT INTO Titul_zanr SELECT (SELECT max(id_titulu) FROM Titul WHERE nazev='Spalovač mrtvol') as id_titulu, id_zanru FROM Zanr WHERE nazev='Novela' FETCH FIRST 1 ROWS ONLY;
INSERT INTO Titul_zanr SELECT (SELECT max(id_titulu) FROM Titul WHERE nazev='Audience') as id_titulu, id_zanru FROM Zanr WHERE nazev='Drama' FETCH FIRST 1 ROWS ONLY;
INSERT INTO Titul_zanr SELECT (SELECT max(id_titulu) FROM Titul WHERE nazev='Babička') as id_titulu, id_zanru FROM Zanr WHERE nazev='Novela' FETCH FIRST 1 ROWS ONLY;
INSERT INTO Titul_zanr SELECT (SELECT max(id_titulu) FROM Titul WHERE nazev='R.U.R.') as id_titulu, id_zanru FROM Zanr WHERE nazev='Science fiction' FETCH FIRST 1 ROWS ONLY;
INSERT INTO Titul_zanr SELECT (SELECT max(id_titulu) FROM Titul WHERE nazev='Válka s Mloky') as id_titulu, id_zanru FROM Zanr WHERE nazev='Science fiction' FETCH FIRST 1 ROWS ONLY;

INSERT INTO Titul_autor SELECT (SELECT max(id_titulu) FROM Titul WHERE nazev='Spalovač mrtvol') as id_titulu, id_autora FROM Autor WHERE jmeno='Ladislav' AND prijmeni='Fuks' FETCH FIRST 1 ROWS ONLY;
INSERT INTO Titul_autor SELECT (SELECT max(id_titulu) FROM Titul WHERE nazev='Audience') as id_titulu, id_autora FROM Autor WHERE jmeno='Václav' AND prijmeni='Havel' FETCH FIRST 1 ROWS ONLY;
INSERT INTO Titul_autor SELECT (SELECT max(id_titulu) FROM Titul WHERE nazev='Babička') as id_titulu, id_autora FROM Autor WHERE jmeno='Božena' AND prijmeni='Němcová' FETCH FIRST 1 ROWS ONLY;
INSERT INTO Titul_autor SELECT (SELECT max(id_titulu) FROM Titul WHERE nazev='R.U.R.') as id_titulu, id_autora FROM Autor WHERE jmeno='Karel' AND prijmeni='Čapek' FETCH FIRST 1 ROWS ONLY;
INSERT INTO Titul_autor SELECT (SELECT max(id_titulu) FROM Titul WHERE nazev='Válka s Mloky') as id_titulu, id_autora FROM Autor WHERE jmeno='Karel' AND prijmeni='Čapek' FETCH FIRST 1 ROWS ONLY;

INSERT INTO Zanr_autor
    SELECT DISTINCT Titul_zanr.id_zanru, Titul_autor.id_autora
    FROM Titul_autor
    LEFT JOIN Titul_zanr
    ON Titul_autor.id_titulu = Titul_zanr.id_titulu;



INSERT INTO Vydani_knihy SELECT '456-25-951-7853-6',1967,1,'Československý spisovatel',max(id_titulu) FROM Titul WHERE nazev='Spalovač mrtvol' AND vydavatel IS NULL FETCH FIRST 1 ROWS ONLY; -- Spalovac mrtvol
INSERT INTO Vydani_knihy SELECT '448-55-456-2589-3',2003,3,'Odeon',max(id_titulu) FROM Titul WHERE nazev='Spalovač mrtvol' AND vydavatel IS NULL FETCH FIRST 1 ROWS ONLY; -- Spalovac mrtvol
INSERT INTO Vydani_knihy SELECT '978-80-7483-080-8',1975,1,'Šafrán',max(id_titulu) FROM Titul WHERE nazev='Audience' AND vydavatel IS NULL FETCH FIRST 1 ROWS ONLY; -- Audience
INSERT INTO Vydani_knihy SELECT '698-96-637-2469-4',1940,1,'L. Mazáč',max(id_titulu) FROM Titul WHERE nazev='Babička' AND vydavatel IS NULL FETCH FIRST 1 ROWS ONLY; -- Babička
INSERT INTO Vydani_knihy SELECT '9598-56-657-0154-2',1940,2,'František Strnad',max(id_titulu) FROM Titul WHERE nazev='Babička' AND vydavatel IS NULL FETCH FIRST 1 ROWS ONLY; -- Babička
INSERT INTO Vydani_knihy SELECT '369-66-823-1456-4',2010,6,'Argo',max(id_titulu) FROM Titul WHERE nazev='R.U.R.' AND vydavatel IS NULL FETCH FIRST 1 ROWS ONLY; -- R.U.R.
INSERT INTO Vydani_knihy SELECT '978-80-7033-157-6',1900,3,'Odeon',max(id_titulu) FROM Titul WHERE nazev='R.U.R.' AND vydavatel IS NULL FETCH FIRST 1 ROWS ONLY; -- R.U.R.
INSERT INTO Vydani_knihy SELECT '7886-364-53-366',1958,10,'Československý spisovatel',max(id_titulu) FROM Titul WHERE nazev='Válka s Mloky' AND vydavatel IS NULL FETCH FIRST 1 ROWS ONLY; -- Válka s Mloky

INSERT INTO Cislo_casopisu SELECT '2307-7301',2018,5,max(id_titulu) FROM Titul WHERE nazev='Můj bylinkový diář' AND vydavatel='Poznání' FETCH FIRST 1 ROWS ONLY; -- Můj bylinkový diář



INSERT INTO Vytisk (stav,datum_pridani,datum_vyrazeni,casopis_ISSN,kniha_ISBN) SELECT 'vypůjčen',TO_DATE('2010-06-07', 'YYYY-MM-DD'),NULL,NULL,max(ISBN) FROM Vydani_knihy WHERE id_titulu=(SELECT max(id_titulu) FROM Titul WHERE nazev='Spalovač mrtvol' FETCH FIRST 1 ROWS ONLY) AND cislo_vydani=1;
INSERT INTO Vytisk (stav,datum_pridani,datum_vyrazeni,casopis_ISSN,kniha_ISBN) SELECT 'skladem',TO_DATE('2011-03-02', 'YYYY-MM-DD'),NULL,NULL,max(ISBN) FROM Vydani_knihy WHERE id_titulu=(SELECT max(id_titulu) FROM Titul WHERE nazev='Spalovač mrtvol' FETCH FIRST 1 ROWS ONLY) AND cislo_vydani=3;
INSERT INTO Vytisk (stav,datum_pridani,datum_vyrazeni,casopis_ISSN,kniha_ISBN) SELECT 'skladem',TO_DATE('2009-05-04', 'YYYY-MM-DD'),NULL,NULL,max(ISBN) FROM Vydani_knihy WHERE id_titulu=(SELECT max(id_titulu) FROM Titul WHERE nazev='Spalovač mrtvol' FETCH FIRST 1 ROWS ONLY) AND cislo_vydani=3;
INSERT INTO Vytisk (stav,datum_pridani,datum_vyrazeni,casopis_ISSN,kniha_ISBN) SELECT 'rezervován',NULL,NULL,NULL,max(ISBN) FROM Vydani_knihy WHERE id_titulu=(SELECT max(id_titulu) FROM Titul WHERE nazev='Audience' FETCH FIRST 1 ROWS ONLY) AND cislo_vydani=1;
INSERT INTO Vytisk (stav,datum_pridani,datum_vyrazeni,casopis_ISSN,kniha_ISBN) SELECT 'vyřazen',NULL,NULL,NULL,max(ISBN) FROM Vydani_knihy WHERE id_titulu=(SELECT max(id_titulu) FROM Titul WHERE nazev='Babička' FETCH FIRST 1 ROWS ONLY) AND cislo_vydani=1;
INSERT INTO Vytisk (stav,datum_pridani,datum_vyrazeni,casopis_ISSN,kniha_ISBN) SELECT 'skladem',NULL,NULL,NULL,max(ISBN) FROM Vydani_knihy WHERE id_titulu=(SELECT max(id_titulu) FROM Titul WHERE nazev='Babička' FETCH FIRST 1 ROWS ONLY) AND cislo_vydani=2;
INSERT INTO Vytisk (stav,datum_pridani,datum_vyrazeni,casopis_ISSN,kniha_ISBN) SELECT 'skladem',TO_DATE('2009-05-04', 'YYYY-MM-DD'),NULL,NULL,max(ISBN) FROM Vydani_knihy WHERE id_titulu=(SELECT max(id_titulu) FROM Titul WHERE nazev='R.U.R.' FETCH FIRST 1 ROWS ONLY) AND cislo_vydani=6;
INSERT INTO Vytisk (stav,datum_pridani,datum_vyrazeni,casopis_ISSN,kniha_ISBN) SELECT 'vypůjčen',NULL,NULL,NULL,max(ISBN) FROM Vydani_knihy WHERE id_titulu=(SELECT max(id_titulu) FROM Titul WHERE nazev='Babička' FETCH FIRST 1 ROWS ONLY) AND cislo_vydani=2;
INSERT INTO Vytisk (stav,datum_pridani,datum_vyrazeni,casopis_ISSN,kniha_ISBN) SELECT 'vypůjčen',NULL,NULL,NULL,max(ISBN) FROM Vydani_knihy WHERE id_titulu=(SELECT max(id_titulu) FROM Titul WHERE nazev='Válka s Mloky' FETCH FIRST 1 ROWS ONLY) AND cislo_vydani=10;



INSERT INTO Rezervace VALUES(DEFAULT,'platná',TO_DATE('2021-03-03', 'YYYY-MM-DD'),TO_DATE('2023-05-04', 'YYYY-MM-DD'),NULL,'978-80-7483-080-8',NULL,1,NULL); -- Audience 1
INSERT INTO Rezervace VALUES(DEFAULT,'ukončena',TO_DATE('2021-05-03', 'YYYY-MM-DD'),TO_DATE('2021-05-04', 'YYYY-MM-DD'),NULL,'369-66-823-1456-4',NULL,1,1); -- R.U.R., vydani 6
INSERT INTO Rezervace VALUES(DEFAULT,'ukončena',TO_DATE('2021-07-03', 'YYYY-MM-DD'),TO_DATE('2021-09-04', 'YYYY-MM-DD'),NULL,'7886-364-53-366',NULL,2,NULL); --Válka s mloky
INSERT INTO Rezervace VALUES(DEFAULT,'ukončena',TO_DATE('2021-01-01', 'YYYY-MM-DD'),TO_DATE('2021-09-01', 'YYYY-MM-DD'),NULL,'9598-56-657-0154-2',NULL,4,NULL); -- Babička, vydani 2
INSERT INTO Rezervace VALUES(DEFAULT,'ukončena',TO_DATE('2021-02-01', 'YYYY-MM-DD'),TO_DATE('2021-10-01', 'YYYY-MM-DD'),NULL,'456-25-951-7853-6',NULL,5,NULL); -- Spalovac mrtvol, vydani 1
INSERT INTO Rezervace VALUES(DEFAULT,'ukončena',TO_DATE('2021-03-01', 'YYYY-MM-DD'),TO_DATE('2021-11-01', 'YYYY-MM-DD'),NULL,'448-55-456-2589-3',NULL,3,NULL); -- Spalovac mrtvol, vydani 3

INSERT INTO Vypujcka VALUES(DEFAULT,'vypůjčeno',TO_DATE('2021-03-20', 'YYYY-MM-DD'),TO_DATE('2021-7-04', 'YYYY-MM-DD'),9,3,2,2,NULL); --Válka s mloky
INSERT INTO Vypujcka VALUES(DEFAULT,'vypůjčeno',TO_DATE('2021-03-20', 'YYYY-MM-DD'),TO_DATE('2021-8-04', 'YYYY-MM-DD'),6,4,4,3,NULL); -- Babička, vydani 2
INSERT INTO Vypujcka VALUES(DEFAULT,'vypůjčeno',TO_DATE('2021-03-26', 'YYYY-MM-DD'),TO_DATE('2021-10-04', 'YYYY-MM-DD'),1,5,5,4,NULL); -- Spalovac mrtvol, vydani 1
INSERT INTO Vypujcka VALUES(DEFAULT,'vráceno',TO_DATE('2021-03-10', 'YYYY-MM-DD'),TO_DATE('2021-03-28', 'YYYY-MM-DD'),2,6,3,5,3); -- Spalovac mrtvol, vydani 3



--zobrazeni tabulek--
SELECT * FROM Pracovnik;
SELECT * FROM Ctenar;
SELECT * FROM Tema;
SELECT * FROM Zanr;
SELECT * FROM Autor;
SELECT * FROM Titul;
SELECT * FROM Vydani_knihy;
SELECT * FROM Cislo_casopisu;
SELECT * FROM Vytisk;
SELECT * FROM Rezervace;
SELECT * FROM Vypujcka;
