--smazani tabulek--
DROP TABLE titul CASCADE CONSTRAINTS;
DROP TABLE tema CASCADE CONSTRAINTS;
DROP TABLE zanr CASCADE CONSTRAINTS;
DROP TABLE autor CASCADE CONSTRAINTS;
DROP TABLE cislo_casopisu CASCADE CONSTRAINTS;
DROP TABLE vydani_knihy CASCADE CONSTRAINTS;
DROP TABLE vytisk CASCADE CONSTRAINTS;
DROP TABLE vypujcka CASCADE CONSTRAINTS;
DROP TABLE ctenar CASCADE CONSTRAINTS;
DROP TABLE pracovnik CASCADE CONSTRAINTS;
DROP TABLE rezervace CASCADE CONSTRAINTS;

--vytvareni tabulek--
CREATE TABLE rezervace (
id_rezervace INTEGER, --pk
stav VARCHAR(20) CHECK ( stav IN
	('rezervováno','rezervace skončila')) NOT NULL,
rezervovano_od TIME,
rezervovano_do TIME
);

CREATE TABLE pracovnik (
id_pracovnika INTEGER, --pk
jmeno VARCHAR(20) NOT NULL,
prijmeni VARCHAR(20) NOT NULL,
email VARCHAR(50)
);

CREATE TABLE ctenar (
cislo_prukazu INTEGER, --pk
platnost_prukazu VARCHAR(10) CHECK ( stav IN
	('platný','neplatný')) NOT NULL,
jmeno VARCHAR(20) NOT NULL,
prijmeni VARCHAR(20) NOT NULL,
email VARCHAR(50)
telefon INTEGER,
ulice VARCHAR(20),
cislo_opisne INTEGER,
mesto VARCHAR(20),
psc INTEGER,
stat VARCHAR(20)
);

CREATE TABLE vypujcka (
id_vypujcky INTEGER, --pk
stav VARCHAR(20) CHECK ( stav IN
	('vypůjčeno','vráceno')) NOT NULL,
vypujceno_od TIME,
vypujceno_do TIME
);

CREATE TABLE vytisk (
id_vytisku INTEGER, --pk
stav VARCHAR(20) CHECK ( stav IN
	('vypůjčen','')) NOT NULL,
datum_pridani DATE,
datum_vyrazeni DATE
);

CREATE TABLE vydani_knihy (
ISBN INTEGER, --pk
rok_vydani INTEGER,
cislo_vydani INTEGER,
nakladatelstvi VARCHAR(50)
);

CREATE TABLE cislo_casopisu (
ISSN INTEGER, --pk
rok_vydani INTEGER,
cislo_vydani INTEGER,
);

CREATE TABLE autor (
id_autora INTEGER, --pk
jmeno VARCHAR(20),
prijmeni VARCHAR(20),
rok_narozeni rok_vydani INTEGER,
rok_umrti rok_vydani INTEGER,
narodnost VARCHAR(20)
);

CREATE TABLE zanr (
id_zanru INTEGER, --pk
nazev VARCHAR(20)
);

CREATE TABLE tema (
id_tema INTEGER, --pk
nazev VARCHAR(20)
);

CREATE TABLE titul (
id_titulu INTEGER, --pk
nazev VARCHAR(50),
podnazev VARCHAR(50),
vydavatel VARCHAR(50)
);

