--zobrazeni data a casu--
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';



--smazani tabulek--
DROP TABLE Pracovnik CASCADE CONSTRAINTS;
DROP TABLE Ctenar CASCADE CONSTRAINTS;

DROP TABLE Titul CASCADE CONSTRAINTS;
DROP TABLE Tema CASCADE CONSTRAINTS;
DROP TABLE Zanr CASCADE CONSTRAINTS;
DROP TABLE Autor CASCADE CONSTRAINTS;

DROP TABLE Vydani_knihy CASCADE CONSTRAINTS;
DROP TABLE Cislo_casopisu CASCADE CONSTRAINTS;

DROP TABLE Vytisk CASCADE CONSTRAINTS;
DROP TABLE Rezervace CASCADE CONSTRAINTS;

DROP TABLE Vypujcka CASCADE CONSTRAINTS;



--vytvareni tabulek--
/* Osoby */
CREATE TABLE Pracovnik (
    id_pracovnika INTEGER, -- PRIMARY KEY
    jmeno VARCHAR(20) NOT NULL,
    prijmeni VARCHAR(20) NOT NULL,
    email VARCHAR(50),

    CONSTRAINT PK_Pracovnik PRIMARY KEY (id_pracovnika)
);

CREATE TABLE Ctenar (
    cislo_prukazu INTEGER, -- PRIMARY KEY
    platnost_prukazu DATE NOT NULL,
    jmeno VARCHAR(20) NOT NULL,
    prijmeni VARCHAR(20) NOT NULL,
    email VARCHAR(50),
    telefon VARCHAR(15) NOT NULL,
    ulice VARCHAR(20),
    cislo_popisne INTEGER,
    mesto VARCHAR(20),
    psc INTEGER,
    stat VARCHAR(20),

    CONSTRAINT PK_Ctenar PRIMARY KEY (cislo_prukazu)
);



/* Titul */
CREATE TABLE Tema (
    id_tema INTEGER, -- PRIMARY KEY
    nazev VARCHAR(20) NOT NULL,

    CONSTRAINT PK_Tema PRIMARY KEY (id_tema)
);

CREATE TABLE Zanr (
    id_zanru INTEGER, -- PRIMARY KEY
    nazev VARCHAR(20) NOT NULL,

    CONSTRAINT PK_Zanr PRIMARY KEY (id_zanru)
);

CREATE TABLE Autor (
    id_autora INTEGER, -- PRIMARY KEY
    jmeno VARCHAR(20) NOT NULL,
    prijmeni VARCHAR(20) NOT NULL,
    rok_narozeni INTEGER NOT NULL, -- CHECK
    rok_umrti INTEGER, -- CHECK
    narodnost VARCHAR(20),

    CONSTRAINT CHK_Autor_rok CHECK (rok_umrti=NULL OR rok_narozeni<rok_umrti),
    CONSTRAINT PK_Autor PRIMARY KEY (id_autora)
);

CREATE TABLE Titul (
    id_titulu INTEGER, -- PRIMARY KEY
    nazev VARCHAR(50) NOT NULL,
    podnazev VARCHAR(50),
    vydavatel VARCHAR(50), -- CHECK

    id_zanru INTEGER, -- FOREIGN KEY, CHECK
    id_tema INTEGER, -- FOREIGN KEY, CHECK
    id_autora INTEGER, -- FOREIGN KEY, CHECK

    CONSTRAINT CHK_Titul_typ CHECK ((vydavatel<>NULL AND id_autora=NULL AND id_zanru=NULL) OR (id_autora<>NULL AND vydavatel=NULL AND id_tema=NULL)),
    CONSTRAINT PK_Titul PRIMARY KEY (id_titulu),
    CONSTRAINT FK_Titul_id_zanru FOREIGN KEY (id_zanru) REFERENCES Zanr(id_zanru),
    CONSTRAINT FK_Titul_id_tema FOREIGN KEY (id_tema) REFERENCES Tema(id_tema),
    CONSTRAINT FK_Titul_id_autora FOREIGN KEY (id_autora) REFERENCES Autor(id_autora)
);



/* Vydání titulu */
CREATE TABLE Vydani_knihy (
    ISBN INTEGER, -- PRIMARY KEY
    rok_vydani INTEGER NOT NULL,
    cislo_vydani INTEGER NOT NULL,
    nakladatelstvi VARCHAR(50) NOT NULL,

    id_titulu INTEGER NOT NULL, -- FOREIGN KEY

    CONSTRAINT PK_Vydani_knihy PRIMARY KEY (ISBN),
    CONSTRAINT FK_Vydani_knihy_id_titulu FOREIGN KEY (id_titulu) REFERENCES Titul(id_titulu)
);

CREATE TABLE Cislo_casopisu (
    ISSN INTEGER, -- PRIMARY KEY
    rok_vydani INTEGER NOT NULL,
    cislo_vydani INTEGER NOT NULL,

    id_titulu INTEGER NOT NULL, -- FOREIGN KEY

    CONSTRAINT PK_Cislo_casopisu PRIMARY KEY (ISSN),
    CONSTRAINT FK_Cislo_casopisu_id_titulu FOREIGN KEY (id_titulu) REFERENCES Titul(id_titulu)
);



/* Výtisk/Rezervace vydání */
CREATE TABLE Vytisk (
    id_vytisku INTEGER, -- PRIMARY KEY
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
    id_rezervace INTEGER, -- PRIMARY KEY
    stav VARCHAR(20) NOT NULL, -- CHECK
    rezervovano_od DATE NOT NULL, -- CHECK
    rezervovano_do DATE NOT NULL, -- CHECK

    casopis_ISSN INTEGER, -- FOREIGN KEY, CHECK
    kniha_ISBN INTEGER, -- FOREIGN KEY, CHECK

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
    id_vypujcky INTEGER, -- PRIMARY KEY
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
    CONSTRAINT FK_Vypujcka_id_rezervace FOREIGN KEY (id_rezervace) REFERENCES Rezervace(id_rezervace),
    CONSTRAINT FK_Vypujcka_id_ctenare FOREIGN KEY (id_ctenare) REFERENCES Ctenar(cislo_prukazu),
    CONSTRAINT FK_Vypujcka_id_pracovnika_vydal FOREIGN KEY (id_pracovnika_vydal) REFERENCES Pracovnik(id_pracovnika),
    CONSTRAINT FK_Vypujcka_id_pracovnika_prijal FOREIGN KEY (id_pracovnika_prijal) REFERENCES Pracovnik(id_pracovnika)
);
