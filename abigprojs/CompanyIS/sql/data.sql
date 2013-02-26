-- TIS_ZAKAZNIK
insert into TIS_ZAKAZNIK (jmeno,ulice,cislo,mesto,psc,telefon) values ('AlfrÈd','BrnÏnsk·',111,'Praha',11150,'602111222');
insert into TIS_ZAKAZNIK (jmeno,ulice,cislo,mesto,psc,telefon) values ('Bonif·c','Olomouck·',123,'Brno',65400,'603123456');
insert into TIS_ZAKAZNIK (jmeno,ulice,cislo,mesto,psc,telefon) values ('Cecil','Ostravsk·',666,'Olomouc',77700,'607987654');
insert into TIS_ZAKAZNIK (jmeno,ulice,cislo,mesto,psc,telefon) values ('Drahoö','BrnÏnsk·',321,'Olomouc',76540,'906112233');
insert into TIS_ZAKAZNIK (jmeno,ulice,cislo,mesto,psc,telefon) values ('Evûen','Opavsk·',369,'Ostrava',72100,'724444666');
insert into TIS_ZAKAZNIK (jmeno,ulice,cislo,mesto,psc,telefon) values ('FridolÌn','Praûsk·',55,'Brno',66550,'777654321');
insert into TIS_ZAKAZNIK (jmeno,ulice,cislo,mesto,psc,telefon) values ('Gustav','PlzeÚsk·',7,'Praha',12300,'736012345');

commit;

-- TIS_VYROBEK
insert into TIS_VYROBEK (nazev,cena,narocnost) values ('TriËko',299,2);
insert into TIS_VYROBEK (nazev,cena,narocnost) values ('Boty',1699,8);
insert into TIS_VYROBEK (nazev,cena,narocnost) values ('Rifle',799,7);
insert into TIS_VYROBEK (nazev,cena,narocnost) values ('Tren˝rky',129,1.5);
insert into TIS_VYROBEK (nazev,cena,narocnost) values ('Koöile',499,3.5);
insert into TIS_VYROBEK (nazev,cena,narocnost) values ('Kravata',349,0.5);
insert into TIS_VYROBEK (nazev,cena,narocnost) values ('Ponoûky',99,0.25);
insert into TIS_VYROBEK (nazev,cena,narocnost) values ('Sako',3599,40);
insert into TIS_VYROBEK (nazev,cena,narocnost) values ('Bunda',2099,25);

commit;

-- TIS_VYROBNI_LINKA
insert into TIS_VYROBNI_LINKA (nazev,kapacita,vykonnost) values ('Radhoöù',2,1);
insert into TIS_VYROBNI_LINKA (nazev,kapacita,vykonnost) values ('Smrk',4,1);
insert into TIS_VYROBNI_LINKA (nazev,kapacita,vykonnost) values ('KnÏhynÏ',1,1);
insert into TIS_VYROBNI_LINKA (nazev,kapacita,vykonnost) values ('Lys· Hora',4,1);
insert into TIS_VYROBNI_LINKA (nazev,kapacita,vykonnost) values ('PradÏd',3,1);

commit;

-- TIS_UZIVATEL
insert into TIS_UZIVATEL (jmeno, heslo, uloha, zakaznik_id) values ('basho','0edec12e32eadcf2849d9ab4a288648b','Obchodnik',null);
insert into TIS_UZIVATEL (jmeno, heslo, uloha, zakaznik_id) values ('vyroba','db72003c23cb98ec092f68bd5ce8b75e','Vyroba',null);
insert into TIS_UZIVATEL (jmeno, heslo, uloha, zakaznik_id) values ('alfred','29cb2448018800ab65a9de297548b6e0','Zakaznik',1);
insert into TIS_UZIVATEL (jmeno, heslo, uloha, zakaznik_id) values ('bonifac','78b13dc0c9e30147ef5f44273c4e2b4a','Zakaznik',2);
insert into TIS_UZIVATEL (jmeno, heslo, uloha, zakaznik_id) values ('cecil','c3a6f631cc20ae5b86f21fc4afd76778','Zakaznik',3);
insert into TIS_UZIVATEL (jmeno, heslo, uloha, zakaznik_id) values ('drahos','441defc0263d19d3c0ccde672f8b9877','Zakaznik',4);
insert into TIS_UZIVATEL (jmeno, heslo, uloha, zakaznik_id) values ('evzen','5daa19b85315af6a26e4825e831782f7','Zakaznik',5);
insert into TIS_UZIVATEL (jmeno, heslo, uloha, zakaznik_id) values ('fridolin','da85727d28c9a776012afea4622c78ce','Zakaznik',6);
insert into TIS_UZIVATEL (jmeno, heslo, uloha, zakaznik_id) values ('gustav','8dad71c4453cf73fbffa57dc34d0ae60','Zakaznik',7);

commit;