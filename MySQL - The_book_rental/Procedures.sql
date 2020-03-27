-- Below procedure show all readers from 'czytelnicy' table;
drop procedure if exists readers;
create procedure readers()
	select * from czytelnicy;
call readers();
-- Below procedure show single reader from 'czytelnicy' table
drop procedure if exists reader_selection;
create procedure reader_selection(in nr_id int)
select * from czytelnicy where id = nr_id;
call reader_selection(5);

drop procedure  if exists add_reader;
-- Below procedure add reader into 'czytelnicy' table
Delimiter \\
create procedure add_reader (in Name_ varchar(10),in Surname_ varchar(20),in Date_of_birth Date, in Gender varchar(10))
begin
    insert into czytelnicy(imie, nazwisko, data_urodzenia, plec) values(Name_, Surname_, Date_of_birth, Gender);
    call readers();
end \\
delimiter ; 
call add_reader('Marcin','Bury','2000-07-25','Mezczyzna'); -- Calling above 'add_reader' procedure

drop procedure if exists add_readers;
-- Below procedure add many readers with to same personaldata into 'czytelnicy' table
Delimiter \\
CREATE PROCEDURE add_readers(in nr_readers int,in Name_ varchar(20),in Surname_ varchar(20),in Date_of_birth Date, in Gender varchar(10))
BEGIN
    WHILE nr_readers > 0 DO
    call add_reader(Name_, Surname_, Date_of_birth, Gender);
    SET nr_readers = nr_readers - 1;
  END WHILE;
  call readers();
END \\
delimiter ;

call add_readers (3,'Marcin','Bury','2000-00-00','Mezczyzna'); -- Calling above 'add_readers' procedure

drop procedure if exists delete_readers;
-- Below procedure delete many readers between two id numbers in 'czytelnicy' table
Delimiter \\
CREATE PROCEDURE delete_readers(nr_id1 INT,nr_id2 int)
BEGIN
  label1: LOOP
    
    IF nr_id1 <= nr_id2 THEN
    delete from czytelnicy where id =nr_id1;
    SET nr_id1 = nr_id1 + 1;
	ITERATE label1;
    END IF;
    LEAVE label1;
  END LOOP label1;
  call readers();
  END \\
delimiter ;

call delete_readers (11,113);  -- Calling above 'delete_readers' procedure
drop procedure if exists update_readers;
-- Below procedure update reader 
delimiter $$
CREATE PROCEDURE update_readers(nr_id INT,feature varchar(10), feature_data varchar(30))
begin
if feature = 'Name' then update czytelnicy set imie = feature_data where czytelnicy.id =nr_id;
elseif feature = 'Surname' then update czytelnicy set nazwisko = feature_data where czytelnicy.id =nr_id;
elseif feature = 'Dateofbirth' then update czytelnicy set data_urodzenia = feature_data where czytelnicy.id =nr_id;
elseif feature = 'Gender' then update czytelnicy set plec = feature_data where czytelnicy.id =nr_id;
else select @val := 'Incorrect entered parameters!! Second parametr: Name Surname Dateofbirth Gender' as Instruction_for_the_function;
end if;
  call readers();
end $$
delimiter ;
call update_readers(14,'Name','Karolina'); -- Calling above 'update_readers' procedure




