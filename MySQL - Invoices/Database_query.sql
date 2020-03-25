/*              The tables configuration
describe klienci;
describe faktury;
alter table klienci modify REF int primary key;
alter table faktury modify Klient int not null;
ALTER TABLE faktury ADD FOREIGN KEY (Klient) REFERENCES klienci(REF); 

describe miasta;
alter table miasta modify Nazwa varchar(20) primary key;
ALTER TABLE klienci ADD FOREIGN KEY (Miasto) REFERENCES miasta(Nazwa); 

describe g_klientow;
alter table g_klientow modify symbol varchar(10) primary key;
ALTER TABLE klienci ADD FOREIGN KEY (GrupaKlienta) REFERENCES g_klientow(symbol);      */

 -- 1. Klienci alfabetycznie kturym nie wystawiono faktury
 SELECT 
    klienci.Nazwa
FROM
    klienci
        LEFT JOIN
    faktury ON klienci.REF = faktury.klient
WHERE
    faktury.klient IS NULL
GROUP BY Nazwa
ORDER BY Nazwa; ;
select * from faktury;

-- 2. TOP 3 klientow ktorzy kupili za najwieksze kwoty;
SELECT 
    Nazwa
FROM
    klienci
        INNER JOIN
    faktury ON klienci.REF = faktury.Klient
GROUP BY klienci.Nazwa
ORDER BY SUM(faktury.Brutto) DESC
LIMIT 3;

-- 3. Wartość faktur wrześniowych z podziałem na wielkość miast uwzględniając faktury dla hurtowników i detalistów
 SELECT 
    faktury.Brutto,
    faktury.Dataa,
    klienci.Miasto,
    miasta.l_mieszkancow,
    klienci.GrupaKlienta
FROM
    klienci
        LEFT JOIN
    faktury ON klienci.REF = faktury.klient
        RIGHT JOIN
    miasta ON miasta.nazwa = klienci.miasto
WHERE
    Dataa BETWEEN '2012-09-01' AND '2012-09-31'
        AND GrupaKlienta = 'HURT'
        OR 'DETAL';
        
-- 4. Klienci, których nazwa zaczyna lub kończy się na 'a' lub 'A'
SELECT 
    Nazwa
FROM
    klienci
WHERE
    Nazwa LIKE 'a%'
        OR Nazwa RLIKE 'a[[:space:]]';

-- 5.Liczba klientów, którym we wrześniu wystawiono faktury na łączną kwotę większą niż 25 000,00 zł
SELECT 
    klienci.Nazwa, SUM(faktury.Brutto) AS kwota
FROM
    klienci
        INNER JOIN
    faktury ON klienci.REF = faktury.Klient
WHERE
    dataa BETWEEN '2012-09-01' AND '2012-09-31'
GROUP BY klienci.Nazwa
HAVING kwota > 25000;

-- 6.Lista faktur dla detalistów zawierająca następujące informację: SYMBOL, DATA,BRUTTO, INFORABAT( słowo 'zgodny' gdy rabat=rabatdomyslny lub 'niezgodny' jeślirabat jest inny niż domyślny)
SELECT 
    faktury.symbol,
    Dataa,
    Brutto,
    CASE Rabat_procent = Domyslny_rabat
        WHEN  true THEN 'zgodny' else 'niezgodny'
    END AS INFORABAT
FROM
    faktury
        INNER JOIN
    klienci ON faktury.Klient = klienci.REF
        LEFT JOIN
    g_klientow ON g_klientow.symbol = klienci.GrupaKlienta
WHERE
    GrupaKlienta = 'DETAL';

-- 7. Zestawienie klientów (kolumny: KLIENT, RODZAJ), którym wystawiono fakturę we wrześniu ( w kolumnie rodzaj wpisać S) oraz tych którzy mieli przynajmniej jedna fakturę we wrześniu na kwotę powyżej 4900 ( w polu rodzaj wpisać V).(klienci w danym rodzaju nie powinni się powtarzać) 
 SELECT 
    klient,
    CASE
        WHEN brutto > 4900 THEN 'V'
        ELSE 'S'
    END AS RODZAJ
FROM
    faktury
WHERE
    Dataa BETWEEN '2012-09-01' AND '2012-09-31' group by klient;

-- 8. Klienci z jakiego miasta kupili najwięcej towarów (wg wartości brutto)
SELECT 
    Miasto, SUM(faktury.Brutto) AS kwota
FROM
    klienci
        INNER JOIN
    faktury ON klienci.REF = faktury.klient
GROUP BY klienci.Miasto;

-- 9. Analiza klientów pokazująca ile łącznie ma wystawionych faktur, na jaką kwotę, ile średnio jest pozycji na fakturze.
SELECT 
    klienci.Nazwa,
    COUNT(klienci.REF) AS Ilosc_faktur,
    SUM(faktury.Brutto) AS laczna_kwota
FROM
    klienci
        INNER JOIN
    faktury ON faktury.Klient = klienci.REF
GROUP BY klienci.REF;

