--zobrazeni data a casu--
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';



--vlozeni udaju do tabulek--
INSERT INTO Pracovnik VALUES(DEFAULT,'Jan','Novák','xnovak01@knihovna.cz');
INSERT INTO Pracovnik VALUES(DEFAULT,'Andrej','Bureš','xbures00@knihovna.cz');
INSERT INTO Pracovnik VALUES(DEFAULT,'Gregor','Johann Mendel','xmendel03@knihovna.cz');
INSERT INTO Pracovnik VALUES(DEFAULT,'František','Palacký','xpalacky00@knihovna.cz');
INSERT INTO Pracovnik VALUES(DEFAULT,'Karel','IV.','xkarel04@knihovna.cz');

INSERT INTO Ctenar VALUES(DEFAULT,TO_DATE('2012-06-05', 'YYYY-MM-DD'),'Franta','Vomáčka','vomac@email.cz','606909007','Jugoslávská',29,'Brno',61300,'CZE');
INSERT INTO Ctenar VALUES(DEFAULT,TO_DATE('2022-06-30', 'YYYY-MM-DD'),'Miloš','Pudding','mipad@gmail.com','723658965','Vídeňská',49,'Brno',63900,'CZE');
INSERT INTO Ctenar VALUES(DEFAULT,TO_DATE('1920-07-15', 'YYYY-MM-DD'),'Milan','Rastislav Štefánik','genstef@tatry.sk','456987321','Brněnská',7,'Bratislava',11300,'SVK');
INSERT INTO Ctenar VALUES(DEFAULT,TO_DATE('1950-02-01', 'YYYY-MM-DD'),'Edvard','Beneš','benes84@gov.csr','32546','Exilová',13,'Praha',00700,'CZE');
INSERT INTO Ctenar VALUES(DEFAULT,TO_DATE('2012-10-12', 'YYYY-MM-DD'),'Dennis','MacAlistair Ritchie','cdennis@comps.com','11332489963','Harvard',69,'Berkeley',10110,'USA');

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


--zobrazeni tabulek--
SELECT * FROM Pracovnik;
SELECT * FROM Ctenar;
SELECT * FROM Tema;
SELECT * FROM Zanr;
SELECT * FROM Autor;
SELECT * FROM Titul;
