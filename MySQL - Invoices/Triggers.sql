
select * from klienci;
select * from g_klientow;
select * from faktury;
-- ALTER TABLE faktury modify FOREIGN KEY (Klient) REFERENCES klienci(REF) ON delete cascade;
-- ALTER TABLE faktury add FOREIGN KEY (Klient) REFERENCES klienci(REF) ;-- ON delete cascade;
-- Alter table faktury drop foreign key faktury_ibfk_1;
drop trigger if exists usunklientow;
-- this below trigger enables automatic deletion of clients after deleting the group they belong to.
DELIMITER $$
create trigger delete_clients_BD before delete on g_klientow 
for each row 
BEGIN
	delete from faktury where faktury.klient in(select REF from klienci where klienci.GrupaKlienta = old.symbol);
DELETE FROM klienci 
WHERE
    klienci.GrupaKlienta = old.symbol;
    
END$$    
 delimiter ;

start transaction;
delete from g_klientow where g_klientow.Domyslny_rabat = 10;
rollback;
-- After executed above transaction, group with clients belonged to it have been deleted

drop trigger if exists count_brutto_AI;
--  the trigger below do counting all gross values after adding to table
delimiter $$
create trigger count_brutto_AI after insert on faktury for each row 
begin

set @sum = @sum + new.Brutto;
  
 end $$
 delimiter ;
 set @sum =0;
 
 start transaction;
insert into faktury(REF, Symbol, Dataa, Klient, Brutto, Rabat_procent) values (10, 'F/2/09/12', '2012-09-01', 12374, 9000.00, 15 ); 
select @sum;
 
 drop trigger if exists block_adding_clients_BI;
 -- the trigger below enables block adding wholesale clients into 'klienci' table
 delimiter //
 create trigger block_adding_clients_BI before insert on klienci
 for each row
 begin
	if(new.GrupaKlienta = 'HURT' )  then
    signal SQLstate '45000' set message_text = 'You cannot adding wholesale clients';
 end if;
 end //
 delimiter ;

start transaction;
insert into klienci(REF, Nazwa, Miasto, GrupaKlienta) values (12567, 'Browar Sp. z.o.', 'Wroclaw', 'HURT'); 
rollback;
select * from klienci;

