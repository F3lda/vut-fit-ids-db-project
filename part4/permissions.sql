CREATE TABLE tempTable (id INTEGER);
INSERT INTO tempTable VALUES(1);
SELECT * FROM tempTable;



DEFINE userName = 'xlogin00';

REVOKE ALL ON tempTable FROM &userName;
GRANT SELECT ON tempTable TO &userName;





/* Výpis informací */

-- vložení do tabulky
INSERT INTO tempTable VALUES(1);
-- výpis tabulky
SELECT * FROM tempTable;



-- Takto lze zjistit přihlášeného uživatele
SELECT USER FROM dual;
-- Výpis práv přiřazených přihlášenému uživateli
SELECT * FROM session_privs ORDER BY privilege;
-- Výpis rolí přiřazených přihlášenému uživateli
SELECT * FROM USER_ROLE_PRIVS;
-- Výpis jemu přímo přiřazených systémových práv
SELECT * FROM USER_SYS_PRIVS;
-- Výpis jemu přímo přiřazených práv k objektům
SELECT * FROM USER_SYS_PRIVS;
