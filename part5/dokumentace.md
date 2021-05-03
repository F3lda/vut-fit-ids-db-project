# Projekt IDS 2020/2021 - dokumentace
Dokumentace k SQL projektu do předmětu IDS 2020/2021

Autoři: Tereza Buchníčková, Karel Jirgl

Loginy: xbuchn00, xjirgl01

Projekt č. 21 - Knihovna1

## zadání
Vytvořte jednoduchý IS knihovny, který by poskytoval informace o titulech knih a časopisů, o registrovaných čtenářích, vypůjčených exemplářích apod. a umožňoval také provádět rezervace žádaných titulů. Z hlediska přístupu k datům uvažujte dvě skupiny uživatelů: pracovníky knihovny a čtenáře.
## 1. část - ER diagram databáze
V průběhu implementace dálších částí projektu, jsme narazili na nedokonalosti prvního návrhu ER diagramu, a tak došlo k jeho mírné úpravě.

[ERD foto]

### Popis ER diagramu
V knihovně máme dva druhy **titulů**, **knihy** a **časopisy**. Protože se jedná o podskupiny s rozdílnými atributy, rozhodli jsme se použít generalizaci/specializaci. Typ entity kniha je dále navázán na **autora** a **žánr**. Žánr uchováváme jako typ entity, protože několik knih může mít stejný žánr a je tedy vhodnější, aby se nejednalo jen o atribut. 

Dále jsme vytvořili typ entity **vydání knihy** a poté samotný **výtisk**, který označuje jeden konkrétní kus knihy. U časopisů jsme vytvořili typ entity **téma**, který popisuje, o jaký druh časopisu se jedná (např.: sportovní). Časopis je navázán na **číslo časopisu,** a to je navázáno na **výtisk**, který je společný pro knihu i časopis, protože se u samotného výtisku jejich atributy neliší. 

Dále jsme navrhli typ entity **rezervace** a **výpůjčka**, kde každá instance rezervace nebo výpůjčky se vztahuje pouze na jeden výtisk. Každému čtenáři by mělo být umožněno zarezervovat si konkrétní vydání knihy nebo číslo časopisu. Rezervaci jsme proto spojili s těmito typy entit, protože se vydání mezi sebou mohou lišit. K vytvoření výpůjčky výtisku dojde, pokud si čtenář rezervovaný výtisk vyzvedne. 

Dále v našem systému ukládáme informace o **čtenářích** a **pracovnících**. Pracovníky máme v našem IS jen z důvodu, aby bylo možné dohledat, jaký pracovník vydal nebo přijal zapůjčený titul a pro tyto účely o pracovnících uchováváme jen základní informace. **Čtenář** si může výtisk vyzvednout a vrátit. **Pracovník** vydává nebo přijímá výtisky zpět a také může čtenáři rezervace rušit.

## 2. část - vytvoření tabulek databáze
Základní kámen naší databáze je tabulka `Titul`. Její generalizaci/specializaci jsme rozhodli řešit sloučením tabulek `Číslo časpisu` a `Vydání knihy` do jedné tabulky. Byl přidán atribut `typ`, který rozlišuje titul na **knihu** nebo **časopis**. Atributy `vydavatel` a `nakladatelství` byly sloučeny do jednoho, ale atributy `ISBN` a `ISSN` zůstaly oba, protože některé tituly mohou mít přidělena obě identifikační čísla.
Tabulky `Číslo časpisu` a `Téma`, ale i tybulky `Vydání knihy`, `Žánr` a `Autor` jsou propojeny **vazebními tabulkami**. 

Tabulka `Výtisk` obsahuje atribut `id_titulu`, který spojuje konkrétní výtisk s daným titulem. Další atribut `stav` pak zachycuje dostupnost výtisku a může nabývat hodnot: `'skladem'`, `'rezervován'`, `'vypůjčen'` nebo `'vyřazen'`.

Tabulka `Rezervace` obsahuje také atribut `stav` a ten může nabývat hodnot: `'platná'`, `'zrušena'` nebo `'ukončena'`. Pokud dojde k vyzvednutí rezervace a je vytvořena výpůjčka, označí se stav rezervace jako `'ukončena'`. V případě zrušení rezervace je stav nastaven na `'zrušena'`. To zda rezervaci zrušil čtenář nebo pracovník knihovny, je možné zjistit pomocí atributu `id_pracovnika_zrusil`. Pokud není tento atribut roven hodnotě `NULL`, došlo ke zrušení rezervace pracovníkem knihovny. V opačném případě rezervaci zrušil čtenář, jehož idetifikační číslo je uloženo v atributu `id_ctenare`. Rezrvace je spojena s titulem pomocí atributu `id_titulu` a pokud dojde k vyzvednutí rezervace je nastaven i atribut `id_vypujcky`, který rezervaci spojuje s její výpůjčkou.

Záznamy v tabulce `Výpůjčka` jsou propojeny s danou rezervací pomocí atributu `id_rezervace` a s konkrétním výtiskem, který je vypůjčen, atributem `id_vytisku`. Atribut `id_ctenare` říká, kdo si danou výpůjčku/výtisk vypůjčil. Atributy `id_pracovnika_vydal`/`id_pracovnika_prijal` ukládají identifikační číslo pracovníka, který výpůjčku vydal/přijal. Atribut `stav` může nabývat hodnot `'vypůjčeno'` nebo `'vráceno'`.

Tabulky `Čtenář` a `Pracovník` obsahují záznamy o osobách, které se účastní procesu rezervování/vypůjčování knih a časopisů.

## 3. část - SELECT dotazy
## 4. část - vytváření pokročilých objektů databáze
### TRIGGERY
### FUNKCE a PROCEDURY
### INDEXY
### EXPLAIN PLAN
### Přístupová práva a materializovaný pohled
