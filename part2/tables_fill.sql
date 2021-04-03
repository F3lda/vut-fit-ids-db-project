--zobrazeni data a casu--
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';



--vlozeni udaju do tabulek--
INSERT INTO Pracovnik VALUES(DEFAULT,'Jan','Novák','xnovak01@knihovna.cz');

INSERT INTO Ctenar VALUES(DEFAULT,TO_DATE('2012-06-05', 'YYYY-MM-DD'),'Franta','Vomáčka','vomac@email.cz','606909007','Jugoslávská',29,'Brno',61600,'CZ');




--zobrazeni tabulek--
SELECT * FROM Pracovnik;
SELECT * FROM Ctenar;
