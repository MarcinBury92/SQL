-- 1.Zestawienie książek, które nie zostały nigdy wypożyczone
SELECT 
    nazwa
FROM
    ksiazki
        LEFT JOIN
    wypozyczenia ON ksiazki.id = wypozyczenia.ksiazka_id
WHERE
    wypozyczenia.ksiazka_id IS NULL;
-- 2. Zestawienie książek, które zostały wypożyczone
SELECT 
    ksiazki.id, nazwa
FROM
    ksiazki
        INNER JOIN
    wypozyczenia ON ksiazki.id = wypozyczenia.ksiazka_id
GROUP BY nazwa
ORDER BY ksiazki.id;
-- 3.Zestawienie czytelników, którzy posiadają aktualnie wypożyczoną książkę, nie dokonali jej zwrócenia.
SELECT 
    czytelnicy.id, imie, nazwisko
FROM
    czytelnicy
        LEFT JOIN
    wypozyczenia ON czytelnicy.id = wypozyczenia.czytelnik_id
WHERE
    Data_zwrotu IS NULL
GROUP BY czytelnicy.id
ORDER BY czytelnicy.id;
 -- 4.. Kategorie wraz z ilością książek przypisanych do danej kategorii. 
SELECT 
    kategorie.nazwa, COUNT(*) AS ilosc
FROM
    kategorie
        LEFT JOIN
    ksiazki ON kategorie.id = ksiazki.kategoria_id
GROUP BY kategorie.nazwa
ORDER BY kategorie.id;
 -- 5. Pierwszych pięciu czytelników, którzy posiadają największą ilość wypożyczeń.
SELECT 
    czytelnicy.id,
    czytelnicy.imie,
    czytelnicy.nazwisko,
    COUNT(*) AS ilosc_wypozyczen
FROM
    czytelnicy
        LEFT JOIN
    wypozyczenia ON czytelnicy.id = wypozyczenia.czytelnik_id
GROUP BY czytelnicy.id
ORDER BY ilosc_wypozyczen DESC
LIMIT 5;
-- 6. Czytelnicy wraz z sumą nałożonych na nich kar. Interesują nas tylko Ci, którzy posiadają więcej niż 1 karę, Ci o najwyższej sumie kar mają być wyświetlani jako pierwsi.
SELECT 
    czytelnicy.id,
    czytelnicy.imie,
    czytelnicy.nazwisko,
    SUM(kary.kwota) AS naleznosc
FROM
    czytelnicy
        LEFT JOIN
    wypozyczenia ON czytelnicy.id = wypozyczenia.czytelnik_id
        INNER JOIN
    kary ON kary.wypozyczenie_id = wypozyczenia.id
GROUP BY czytelnicy.id
ORDER BY naleznosc DESC;


-- 7. Z jakiego typu kar posiadamy największe wpływy, wyświetl nazwę kary wraz z sumą kwot.
SELECT 
    nazwa, SUM(kary.kwota) AS suma_kar, COUNT(*) AS ilosc_kar
FROM
    typy_kar
        LEFT JOIN
    kary ON typy_kar.id = kary.typ_kary_id
GROUP BY typy_kar.id;
-- 8. Czytelnicy w jakim wieku posiadają największą ilość wypożyczeń? Zwróć wiek wraz z ilością wypożyczeń.
SELECT 
    czytelnicy.id,
    czytelnicy.imie,
    czytelnicy.nazwisko,
    czytelnicy.data_urodzenia,
    COUNT(*) AS ilosc_wyp_ksiazek
FROM
    czytelnicy
        LEFT JOIN
    wypozyczenia ON czytelnicy.id = wypozyczenia.czytelnik_id
GROUP BY czytelnicy.id
ORDER BY ilosc_wyp_ksiazek DESC , data_urodzenia;
-- 9. Która płeć wypożycza większą ilość książek oraz jakie ma to odniesienie do wysokości naliczonych kar. Zwróć płeć, ilość wypożyczeń oraz sumę naliczonych kar.
SELECT 
    czytelnicy.plec,
    COUNT(*) AS ilosc_wypozyczen,
    SUM(kary.kwota) AS suma_kar
FROM
    czytelnicy
        LEFT JOIN
    wypozyczenia ON wypozyczenia.czytelnik_id = czytelnicy.id
        LEFT JOIN
    kary ON kary.wypozyczenie_id = wypozyczenia.id
GROUP BY plec;
-- 10. Wyświetl książki, którym zostało mniej niż tydzień do planowej daty ich zwrotu.
Założenie: dzisiejsza data to ‘2018-04-20’ 
SELECT 
    ksiazki.nazwa,
    wypozyczenia.Planowana_data_zwrotu,
    DATEDIFF('2018-04-20',
            wypozyczenia.Planowana_data_zwrotu) AS dni_do_zwrotu
FROM
    ksiazki
        LEFT JOIN
    wypozyczenia ON wypozyczenia.ksiazka_id = ksiazki.id
WHERE
    DATEDIFF('2018-04-20',
            wypozyczenia.Planowana_data_zwrotu) < 7
        AND DATEDIFF('2018-04-20',
            wypozyczenia.Planowana_data_zwrotu) > - 7;
-- 11.Wyświetl książki, które nie zostały zwrócone w terminie oraz nie zostały dla nich jeszcze naliczone kary z tytułu owego przekroczenia.
SELECT 
    ksiazki.id, ksiazki.nazwa, wypozyczenia.id
FROM
    ksiazki
        INNER JOIN
    wypozyczenia ON wypozyczenia.ksiazka_id = ksiazki.id
        LEFT JOIN
    kary ON kary.wypozyczenie_id = wypozyczenia.id
WHERE
    wypozyczenia.Data_zwrotu > wypozyczenia.Planowana_data_zwrotu
        OR wypozyczenia.Data_zwrotu IS NULL
        AND kary.id IS NULL;
