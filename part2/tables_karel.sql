--zobrazeni data a casu--
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';



--smazani tabulek--
DROP TABLE Pracovnik CASCADE CONSTRAINTS;
DROP TABLE Ctenar CASCADE CONSTRAINTS;

DROP TABLE Titul CASCADE CONSTRAINTS;
DROP TABLE Tema CASCADE CONSTRAINTS;
DROP TABLE Zanr CASCADE CONSTRAINTS;
DROP TABLE Autor CASCADE CONSTRAINTS;

DROP TABLE Titul_zanr CASCADE CONSTRAINTS;
DROP TABLE Zanr_autor CASCADE CONSTRAINTS;
DROP TABLE Titul_autor CASCADE CONSTRAINTS;
DROP TABLE Titul_tema CASCADE CONSTRAINTS;

DROP TABLE Vydani_knihy CASCADE CONSTRAINTS;
DROP TABLE Cislo_casopisu CASCADE CONSTRAINTS;

DROP TABLE Vytisk CASCADE CONSTRAINTS;
DROP TABLE Rezervace CASCADE CONSTRAINTS;

DROP TABLE Vypujcka CASCADE CONSTRAINTS;



--vytvareni tabulek--
/* Osoby */
CREATE TABLE Pracovnik (
    id_pracovnika INTEGER NOT NULL, -- PRIMARY KEY
    jmeno VARCHAR(20) NOT NULL,
    prijmeni VARCHAR(20) NOT NULL,
    email VARCHAR(50),

    CONSTRAINT PK_Pracovnik PRIMARY KEY (id_pracovnika)
);

CREATE TABLE Ctenar (
    cislo_prukazu INTEGER NOT NULL, -- PRIMARY KEY
    platnost_prukazu DATE NOT NULL,
    jmeno VARCHAR(20) NOT NULL,
    prijmeni VARCHAR(20) NOT NULL,
    email VARCHAR(50),
    telefon VARCHAR(15) NOT NULL,
    ulice VARCHAR(20) NOT NULL,
    cislo_popisne INTEGER NOT NULL,
    mesto VARCHAR(20) NOT NULL,
    psc INTEGER NOT NULL,
    stat VARCHAR(20) NOT NULL,

    CONSTRAINT PK_Ctenar PRIMARY KEY (cislo_prukazu)
);



/* Titul */
CREATE TABLE Tema (
    id_tema INTEGER NOT NULL, -- PRIMARY KEY
    nazev VARCHAR(20) NOT NULL,

    CONSTRAINT PK_Tema PRIMARY KEY (id_tema)
);

CREATE TABLE Zanr (
    id_zanru INTEGER NOT NULL, -- PRIMARY KEY
    nazev VARCHAR(20) NOT NULL, 

    CONSTRAINT PK_Zanr PRIMARY KEY (id_zanru)
);

CREATE TABLE Autor (
    id_autora INTEGER NOT NULL, -- PRIMARY KEY
    jmeno VARCHAR(20) NOT NULL,
    prijmeni VARCHAR(20) NOT NULL,
    rok_narozeni INTEGER, -- CHECK
    rok_umrti INTEGER, -- CHECK
    narodnost VARCHAR(20),

    CONSTRAINT CHK_Autor_rok CHECK (rok_umrti=NULL OR rok_narozeni<rok_umrti),
    CONSTRAINT PK_Autor PRIMARY KEY (id_autora)
);

CREATE TABLE Titul (
    id_titulu INTEGER NOT NULL, -- PRIMARY KEY
    nazev VARCHAR(50) NOT NULL,
    podnazev VARCHAR(50),
    vydavatel VARCHAR(50), -- CHECK

    --CONSTRAINT CHK_Titul_typ CHECK ((vydavatel<>NULL AND id_autora=NULL AND id_zanru=NULL) OR (id_autora<>NULL AND vydavatel=NULL AND id_tema=NULL)),
    CONSTRAINT PK_Titul PRIMARY KEY (id_titulu)
);



/* Vazební tabulky */
CREATE TABLE Titul_zanr (
    id_zanru INTEGER NOT NULL, 
    id_titulu INTEGER NOT NULL,
    
    CONSTRAINT FK_Titul_zanr_id_zanru FOREIGN KEY (id_zanru) REFERENCES Zanr(id_zanru),
    CONSTRAINT FK_Titul_zanr_id_titulu FOREIGN KEY (id_titulu) REFERENCES Titul(id_titulu),
    
    CONSTRAINT PK_Titul_zanr PRIMARY KEY (id_zanru, id_titulu)
);

CREATE TABLE Zanr_autor (
    id_zanru INTEGER NOT NULL, 
    id_autora INTEGER NOT NULL,
    
    CONSTRAINT FK_Zanr_autor_id_zanru FOREIGN KEY (id_zanru) REFERENCES Zanr(id_zanru),
    CONSTRAINT FK_Zanr_autor_id_autora FOREIGN KEY (id_autora) REFERENCES Autor(id_autora),
    
    CONSTRAINT PK_Zanr_autor PRIMARY KEY (id_zanru, id_autora)
);

CREATE TABLE Titul_autor (
    id_titulu INTEGER NOT NULL, 
    id_autora INTEGER NOT NULL,
    
    CONSTRAINT FK_Titul_autor_id_titulu FOREIGN KEY (id_titulu) REFERENCES Titul(id_titulu),
    CONSTRAINT FK_Titul_autor_id_autora FOREIGN KEY (id_autora) REFERENCES Autor(id_autora),
    
    CONSTRAINT PK_Titul_autor PRIMARY KEY (id_titulu, id_autora)
);

CREATE TABLE Titul_tema (
    id_titulu INTEGER NOT NULL, 
    id_tema INTEGER NOT NULL,
    
    CONSTRAINT FK_Titul_tema_id_titulu FOREIGN KEY (id_titulu) REFERENCES Titul(id_titulu),
    CONSTRAINT FK_Titul_tema_id_autora FOREIGN KEY (id_tema) REFERENCES Tema(id_tema),
    
    CONSTRAINT PK_Titul_tema PRIMARY KEY (id_titulu, id_tema)
);



/* Vydání titulu */
CREATE TABLE Vydani_knihy (
    ISBN INTEGER NOT NULL, -- PRIMARY KEY
    rok_vydani INTEGER NOT NULL,
    cislo_vydani INTEGER NOT NULL,
    nakladatelstvi VARCHAR(50) NOT NULL,

    id_titulu INTEGER NOT NULL, -- FOREIGN KEY

    CONSTRAINT PK_Vydani_knihy PRIMARY KEY (ISBN),
    CONSTRAINT FK_Vydani_knihy_id_titulu FOREIGN KEY (id_titulu) REFERENCES Titul(id_titulu)
);

CREATE TABLE Cislo_casopisu (
    ISSN INTEGER NOT NULL, -- PRIMARY KEY
    rok_vydani INTEGER NOT NULL,
    cislo_vydani INTEGER NOT NULL,

    id_titulu INTEGER NOT NULL, -- FOREIGN KEY

    CONSTRAINT PK_Cislo_casopisu PRIMARY KEY (ISSN),
    CONSTRAINT FK_Cislo_casopisu_id_titulu FOREIGN KEY (id_titulu) REFERENCES Titul(id_titulu)
);



/* Výtisk/Rezervace vydání */
CREATE TABLE Vytisk (
    id_vytisku INTEGER NOT NULL, -- PRIMARY KEY
    stav VARCHAR(10) NOT NULL, -- CHECK
    datum_pridani DATE, -- CHECK
    datum_vyrazeni DATE, -- CHECK

    casopis_ISSN INTEGER, -- FOREIGN KEY, CHECK
    kniha_ISBN INTEGER, -- FOREIGN KEY, CHECK

    CONSTRAINT CHK_Vytisk_typ CHECK ((casopis_ISSN<>NULL AND kniha_ISBN=NULL) OR (kniha_ISBN<>NULL AND casopis_ISSN=NULL)),
    CONSTRAINT CHK_Vytisk_stav CHECK (stav IN ('skladem', 'vypůjčen', 'vyřazen')),
    CONSTRAINT CHK_Vytisk_datum CHECK (datum_pridani IS NULL OR datum_vyrazeni IS NULL OR datum_pridani<datum_vyrazeni),
    CONSTRAINT PK_Vytisk PRIMARY KEY (id_vytisku),
    CONSTRAINT FK_Vytisk_kniha_ISBN FOREIGN KEY (kniha_ISBN) REFERENCES Vydani_knihy(ISBN),
    CONSTRAINT FK_Vytisk_casopis_ISSN FOREIGN KEY (casopis_ISSN) REFERENCES Cislo_casopisu(ISSN)
);
/* Rezervace vydání */
CREATE TABLE Rezervace (
    id_rezervace INTEGER NOT NULL, -- PRIMARY KEY
    stav VARCHAR(20) NOT NULL, -- CHECK
    rezervovano_od DATE NOT NULL, -- CHECK
    rezervovano_do DATE NOT NULL, -- CHECK

    casopis_ISSN INTEGER, -- FOREIGN KEY, CHECK
    kniha_ISBN INTEGER, -- FOREIGN KEY, CHECK
    id_vypujcky INTEGER, -- FOREIGN KEY

    id_ctenare INTEGER NOT NULL, -- FOREIGN KEY
    id_pracovnika_zrusil INTEGER, -- FOREIGN KEY

    CONSTRAINT CHK_Rezervace_typ CHECK ((casopis_ISSN<>NULL AND kniha_ISBN=NULL) OR (kniha_ISBN<>NULL AND casopis_ISSN=NULL)),
    CONSTRAINT CHK_Rezervace_stav CHECK (stav IN ('platná', 'ukončena')),
    CONSTRAINT CHK_Rezervace_datum CHECK (rezervovano_od<rezervovano_do),
    CONSTRAINT PK_Rezervace PRIMARY KEY (id_rezervace),
    CONSTRAINT FK_Rezervace_kniha_ISBN FOREIGN KEY (kniha_ISBN) REFERENCES Vydani_knihy(ISBN),
    CONSTRAINT FK_Rezervace_casopis_ISSN FOREIGN KEY (casopis_ISSN) REFERENCES Cislo_casopisu(ISSN),
    CONSTRAINT FK_Rezervace_id_ctenare FOREIGN KEY (id_ctenare) REFERENCES Ctenar(cislo_prukazu),
    CONSTRAINT FK_Rezervace_id_pracovnika_zrusil FOREIGN KEY (id_pracovnika_zrusil) REFERENCES Pracovnik(id_pracovnika)
);



/* Výpůjčka Výtisku/Rezervace */
CREATE TABLE Vypujcka (
    id_vypujcky INTEGER NOT NULL, -- PRIMARY KEY
    stav VARCHAR(20) NOT NULL, -- CHECK
    vypujceno_od DATE NOT NULL, -- CHECK
    vypujceno_do DATE NOT NULL, -- CHECK

    id_vytisku INTEGER NOT NULL, -- FOREIGN KEY, CHECK
    id_rezervace INTEGER NOT NULL, -- FOREIGN KEY, CHECK

    id_ctenare INTEGER NOT NULL, -- FOREIGN KEY
    id_pracovnika_vydal INTEGER NOT NULL, -- FOREIGN KEY
    id_pracovnika_prijal INTEGER, -- FOREIGN KEY

    --CONSTRAINT CHK_Vypujcka_id_vytisku CHECK (id_vytisku.stav='skladem'), --? možno udělat přes funkci -> jinak asi přímo v aplikaci
    --CONSTRAINT CHK_Vypujcka_id_rezervace CHECK (id_rezervace.stav='platná'), --? možno udělat přes funkci -> jinak asi přímo v aplikaci
    CONSTRAINT CHK_Vypujcka_stav CHECK (stav IN ('vypůjčeno','vráceno')),
    CONSTRAINT CHK_Vypujcka_datum CHECK (vypujceno_od<vypujceno_do),
    CONSTRAINT PK_Vypujcka PRIMARY KEY (id_vypujcky),
    CONSTRAINT FK_Vypujcka_id_vytisku FOREIGN KEY (id_vytisku) REFERENCES Vytisk(id_vytisku),
    CONSTRAINT FK_Vypujcka_id_ctenare FOREIGN KEY (id_ctenare) REFERENCES Ctenar(cislo_prukazu),
    CONSTRAINT FK_Vypujcka_id_pracovnika_vydal FOREIGN KEY (id_pracovnika_vydal) REFERENCES Pracovnik(id_pracovnika),
    CONSTRAINT FK_Vypujcka_id_pracovnika_prijal FOREIGN KEY (id_pracovnika_prijal) REFERENCES Pracovnik(id_pracovnika)
);

ALTER TABLE Rezervace ADD CONSTRAINT FK_Rezervace_id_vypujcky FOREIGN KEY (id_vypujcky) REFERENCES Vypujcka(id_vypujcky);
ALTER TABLE Vypujcka ADD CONSTRAINT FK_Vypujcka_id_rezervace FOREIGN KEY (id_rezervace) REFERENCES Rezervace(id_rezervace);
