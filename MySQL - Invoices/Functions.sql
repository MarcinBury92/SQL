-- roznia sie tym ze nie musza byc paramety wejscia i wyjscia
-- funkcja zwraca wartosc w jednym z typow
drop function if exists Brutto_netto;
drop function if exists fn_daty;

delimiter $$
create function Brutto_netto(BN varchar(20), wartosc int, VAT int)
returns text 
 deterministic
begin 
 if BN ='Brutto' then return concat('Brutto: ',wartosc,'zł , stawka VAT ',VAT,'%, Podatek: ',round((wartosc*VAT)/(100+VAT),2),' | Kwota Netto:',round(wartosc - (wartosc*VAT)/(100+VAT),2),' zł');
elseif BN = 'Netto' then return concat('Netto: ',wartosc,'zł , stawka VAT ',VAT,'%, Podatek: ',round(wartosc*(VAT/100),2),' | Kwota Brutto:',round(wartosc+wartosc*(VAT/100),2),' zł');
else return 'Podales zle parametry';
-- else return 'Brutto v Netto ?';
end if;
end $$
delimiter ;
CREATE FUNCTION fn_daty (Dataa date)
RETURNS char(20)
RETURN CONCAT(YEAR(dataa),' : ', MONTHNAME(dataa));

SELECT 
    *,
    FN_DATY(faktury.Dataa) as year__month,
    BRUTTO_NETTO('Brutto', faktury.Brutto, 23) AS Brutto_Netto
FROM
    faktury;







