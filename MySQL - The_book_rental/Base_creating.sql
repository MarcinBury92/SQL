drop table  if exists kary,typy_kar, wypozyczenia, ksiazki,kategorie, czytelnicy;

create table  kategorie(
 id int primary key,
 nazwa varchar(50)
);

create table  ksiazki(
 id serial,
 nazwa varchar(50),
 ilosc_stron int,
 kategoria_id int,
 autor varchar(30),
 foreign key(kategoria_id) references kategorie(id)
 );
 
 create table  czytelnicy(
 id serial primary key,
 imie varchar(20),
 nazwisko varchar(50),
 data_urodzenia DATE,
 plec varchar(10)
 );
 
 create table  wypozyczenia(
 id serial,
 ksiazka_id bigint(20) unsigned,
 czytelnik_id bigint(20) unsigned,
 Data_wypozyczenia DATE,
 Planowana_data_zwrotu DATE,
 Data_zwrotu DATE,
 foreign key(czytelnik_id) references czytelnicy(id),
 foreign key(ksiazka_id) references ksiazki(id)
);
 
 create table typy_kar(
 id serial primary key,
 nazwa varchar(50)
 );
 
create table  kary(
 id serial,
 wypozyczenie_id bigint(20) unsigned,
 typ_kary_id bigint(20) unsigned,
 kwota numeric(14,2),
 opis varchar(255), 
 foreign key(typ_kary_id) references typy_kar(id),
 foreign key(wypozyczenie_id) references wypozyczenia(id)
 );
-- INSERT KARY table
insert into typy_kar(nazwa) values('Zniszczenie');
insert into typy_kar(nazwa) values('Brak terminowego zdania');
insert into typy_kar(nazwa) values('Znaczne pogorszenie stanu');
select * from typy_kar;

-- INSERT Kategorie table
insert into kategorie(id,nazwa) values(1,'Fantastyka');
insert into kategorie(id,nazwa) values(2,'Horror');
insert into kategorie(id,nazwa) values(3,'Kryminal');
insert into kategorie(id,nazwa) values(4,'Poezja');
insert into kategorie(id,nazwa) values(5,'Dramat');


-- INSERT ksiazki table
insert into ksiazki(nazwa, ilosc_stron, kategoria_id, autor) values('Cień', 434, 1, 'Przechrzta Adam');
insert into ksiazki(nazwa, ilosc_stron, kategoria_id, autor) values('Podejrzany', 320, 3, 'Świst Paulina');
insert into ksiazki(nazwa, ilosc_stron, kategoria_id, autor) values('Outsider', 640, 2, 'King Stephen');
insert into ksiazki(nazwa, ilosc_stron, kategoria_id, autor) values('Tango', 208, 5, 'Mrożek Sławomir');
insert into ksiazki(nazwa, ilosc_stron, kategoria_id, autor) values('Miała dzikie serce', 232, 4, 'Atticus');
insert into ksiazki(nazwa, ilosc_stron, kategoria_id, autor) values('Dramaty', 280, 5, 'Masłowska Dorota');
insert into ksiazki(nazwa, ilosc_stron, kategoria_id, autor) values('Cztery żywioły.Tom 4.Czerwony Pająk', 816, 3, 'Bonda Katarzyna');
insert into ksiazki(nazwa, ilosc_stron, kategoria_id, autor) values('Mitologia nordycka', 208, 1, 'Gaiman Neil');
insert into ksiazki(nazwa, ilosc_stron, kategoria_id, autor) values('Policja', 386, 5, 'Mrożek Sławomir');
insert into ksiazki(nazwa, ilosc_stron, kategoria_id, autor) values('To', 1150, 2, 'King Stephen');
insert into ksiazki(nazwa, ilosc_stron, kategoria_id, autor) values('Wirus', 320, 2, 'Masterton Graham');
insert into ksiazki(nazwa, ilosc_stron, kategoria_id, autor) values('I że cię nie opuszczę', 488, 3, 'Richmond Michelle');
insert into ksiazki(nazwa, ilosc_stron, kategoria_id, autor) values('Otchłań. Księga 2', 565, 1, 'Brett Peter V.');
insert into ksiazki(nazwa, ilosc_stron, kategoria_id, autor) values('Mleko i miód. Milk and Honey', 416, 4, 'Rupi Kaur');
insert into ksiazki(nazwa, ilosc_stron, kategoria_id, autor) values('Zew Cthulhu', 296, 2, 'Lovecraft Howard Phillips');

-- INSERT CZYTELNICY table
insert into czytelnicy(imie, nazwisko, data_urodzenia, plec) values('Malgorzata', 'Janiszewska', '1985-04-02', 'Kobieta');
insert into czytelnicy(imie, nazwisko, data_urodzenia, plec) values('Kinga', 'Kurek', '1947-03-15', 'Kobieta');
insert into czytelnicy(imie, nazwisko, data_urodzenia, plec) values('Kamil', 'Michalak', '1988-07-16', 'Mezczyzna');
insert into czytelnicy(imie, nazwisko, data_urodzenia, plec) values('Joanna', 'Paluch', '1980-05-22', 'Kobieta');
insert into czytelnicy(imie, nazwisko, data_urodzenia, plec) values('Zofia', 'Kurowska', '1990-06-01', 'Kobieta');
insert into czytelnicy(imie, nazwisko, data_urodzenia, plec) values('Antoni', 'Lipinski', '1990-04-15', 'Mezczyzna');
insert into czytelnicy(imie, nazwisko, data_urodzenia, plec) values('Kaja', 'Domagala', '1990-09-19', 'Kobieta');
insert into czytelnicy(imie, nazwisko, data_urodzenia, plec) values('Szymon', 'Zak', '1975-11-25', 'Mezczyzna');
insert into czytelnicy(imie, nazwisko, data_urodzenia, plec) values('Michal', 'Kasprzak', '1989-10-13', 'Mezczyzna');

-- INSERT WYPOZYCZENIA table
insert into wypozyczenia(ksiazka_id, czytelnik_id, Data_wypozyczenia, Planowana_data_zwrotu, Data_zwrotu) values(7,   3, '2017-11-18', '2018-01-17', '2018-01-12');
insert into wypozyczenia(ksiazka_id, czytelnik_id, Data_wypozyczenia, Planowana_data_zwrotu) 			  values(5,   6, '2018-06-05', '2018-08-04');
insert into wypozyczenia(ksiazka_id, czytelnik_id, Data_wypozyczenia, Planowana_data_zwrotu, Data_zwrotu) values(3,   4, '2017-09-29', '2017-11-28', '2017-11-23');
insert into wypozyczenia(ksiazka_id, czytelnik_id, Data_wypozyczenia, Planowana_data_zwrotu, Data_zwrotu) values(11,  8, '2018-04-10', '2018-06-09', '2018-06-04');
insert into wypozyczenia(ksiazka_id, czytelnik_id, Data_wypozyczenia, Planowana_data_zwrotu)              values(15,  1, '2018-01-11', '2018-03-12');
insert into wypozyczenia(ksiazka_id, czytelnik_id, Data_wypozyczenia, Planowana_data_zwrotu, Data_zwrotu) values(7,   9, '2018-05-01', '2018-06-30', '2018-06-25');
insert into wypozyczenia(ksiazka_id, czytelnik_id, Data_wypozyczenia, Planowana_data_zwrotu, Data_zwrotu) values(8,   1, '2018-03-05', '2018-05-04', '2018-04-29');
insert into wypozyczenia(ksiazka_id, czytelnik_id, Data_wypozyczenia, Planowana_data_zwrotu)              values(9,   4, '2018-02-23', '2018-04-24');
insert into wypozyczenia(ksiazka_id, czytelnik_id, Data_wypozyczenia, Planowana_data_zwrotu)              values(8,   6, '2017-12-16', '2018-02-14');
insert into wypozyczenia(ksiazka_id, czytelnik_id, Data_wypozyczenia, Planowana_data_zwrotu, Data_zwrotu) values(8,   2, '2017-08-22', '2017-10-21', '2017-10-16');
insert into wypozyczenia(ksiazka_id, czytelnik_id, Data_wypozyczenia, Planowana_data_zwrotu, Data_zwrotu) values(3,   3, '2017-08-22', '2017-10-21', '2017-10-25');
insert into wypozyczenia(ksiazka_id, czytelnik_id, Data_wypozyczenia, Planowana_data_zwrotu)              values(4,   1, '2018-02-05', '2018-04-06');
insert into wypozyczenia(ksiazka_id, czytelnik_id, Data_wypozyczenia, Planowana_data_zwrotu)              values(6,   6, '2017-11-08', '2018-01-07');
insert into wypozyczenia(ksiazka_id, czytelnik_id, Data_wypozyczenia, Planowana_data_zwrotu) 			  values(2,   4, '2018-02-28', '2018-04-29');
insert into wypozyczenia(ksiazka_id, czytelnik_id, Data_wypozyczenia, Planowana_data_zwrotu) 		      values(13,  4, '2018-02-23', '2018-04-24');
insert into wypozyczenia(ksiazka_id, czytelnik_id, Data_wypozyczenia, Planowana_data_zwrotu) 			  values(7,   7, '2018-04-10', '2018-06-09');
insert into wypozyczenia(ksiazka_id, czytelnik_id, Data_wypozyczenia, Planowana_data_zwrotu, Data_zwrotu) values(4,   4, '2017-12-16', '2018-02-14', '2018-01-23');
insert into wypozyczenia(ksiazka_id, czytelnik_id, Data_wypozyczenia, Planowana_data_zwrotu, Data_zwrotu) values(8,   5, '2018-01-11', '2018-03-12', '2018-02-05');
insert into wypozyczenia(ksiazka_id, czytelnik_id, Data_wypozyczenia, Planowana_data_zwrotu)              values(11,  6, '2018-06-05', '2018-08-04');
insert into wypozyczenia(ksiazka_id, czytelnik_id, Data_wypozyczenia, Planowana_data_zwrotu)              values(14,  4, '2017-04-21', '2017-06-20');

-- INSERT KARY table
insert into kary(wypozyczenie_id, typ_kary_id, kwota, opis) values(3,  1, 40, 'Nie nadaje sie do ponownego uzytku');
insert into kary(wypozyczenie_id, typ_kary_id, kwota) 				values(5,  2, 5);
insert into kary(wypozyczenie_id, typ_kary_id, kwota) 				values(7,  2, 5);
insert into kary(wypozyczenie_id, typ_kary_id, kwota, opis) values(12, 3, 10, 'Zalanie kilku stron');
insert into kary(wypozyczenie_id, typ_kary_id, kwota) 				values(14, 2, 5);
insert into kary(wypozyczenie_id, typ_kary_id, kwota) 				values(20, 2, 5);
update kary set wypozyczenie_id = 20 where kary.id =6; 
select * from wypozyczenia;