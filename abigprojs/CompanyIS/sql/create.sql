-- ZAKAZNIK
create table TIS_ZAKAZNIK(
  zakaznik_id number(10) not null,
  jmeno varchar2(20) not null,
  ulice varchar2(30) not null,
  cislo number(4) not null,
  mesto varchar2(30) not null,
  psc number(5) not null,
  telefon varchar(13) not null,
  aktivni number(1) not null
  );

alter table TIS_ZAKAZNIK add constraint PK_TIS_ZAKAZNIK
	primary key (zakaznik_id);

alter table TIS_ZAKAZNIK add constraint UK_TIS_ZAKAZNIK
	unique (jmeno, ulice, cislo, mesto, psc, telefon);
  
alter table TIS_ZAKAZNIK add constraint CK_TIS_ZAKAZNIK_AKTIVNI
	check ((aktivni = 0) or (aktivni = 1));
  
create index IDX_TIS_ZAKAZNIK_JMENO on TIS_ZAKAZNIK (jmeno);

create index IDX_TIS_ZAKAZNIK_MESTO on TIS_ZAKAZNIK (mesto);

create sequence SEQ_TIS_ZAKAZNIK_ID start with 1 nocache;

create or replace trigger TIS_ZAKAZNIK_BI
before insert
on TIS_ZAKAZNIK
for each row
begin
  -- kontrola ID
  if :new.zakaznik_id is null then
    select SEQ_TIS_ZAKAZNIK_ID.nextval into :new.zakaznik_id from DUAL;
  end if;
  -- kontrola aktivni
  if :new.aktivni is null then
    :new.aktivni := 1;
  end if;
end;
/

-- VYROBEK
create table TIS_VYROBEK(
  vyrobek_id number(10) not null,
  nazev varchar2(20) not null,
  cena number(6,2) not null,
  narocnost number(6,2) not null;
  aktivni number(1) not null
  );

alter table TIS_VYROBEK add constraint PK_TIS_VYROBEK
	primary key (vyrobek_id);

alter table TIS_VYROBEK add constraint UK_TIS_VYROBEK
	unique (nazev);

alter table TIS_VYROBEK add constraint CK_TIS_VYROBEK_CENA
	check (cena > 0.0);

alter table TIS_VYROBEK add constraint CK_TIS_VYROBEK_NAROCNOST
	check (narocnost > 0.0);

alter table TIS_VYROBEK add constraint CK_TIS_VYROBEK_AKTIVNI
	check ((aktivni = 0) or (aktivni = 1));
  
create sequence SEQ_TIS_VYROBEK_ID start with 1 nocache;

create or replace trigger TIS_VYROBEK_BI
before insert
on TIS_VYROBEK
for each row
begin
  -- kontrola ID
  if :new.vyrobek_id is null then
    select SEQ_TIS_VYROBEK_ID.nextval into :new.vyrobek_id from DUAL;
  end if;
  -- kontrola aktivni
  if :new.aktivni is null then
    :new.aktivni := 1;
  end if;
end;
/

-- ZAKAZKA
create table TIS_ZAKAZKA(
  zakazka_id number(10) not null,
  zakaznik_id number(10) not null,
  datum_objednavky date not null,
  datum_odeslani date,
  stav varchar2(20) not null
  );

alter table TIS_ZAKAZKA add constraint PK_TIS_ZAKAZKA
	primary key (zakazka_id);

alter table TIS_ZAKAZKA add constraint FK_TIS_ZAKAZKA_ZAKAZNIK
	foreign key (zakaznik_id) references TIS_ZAKAZNIK(zakaznik_id);

alter table TIS_ZAKAZKA add constraint CK_TIS_ZAKAZKA_STAV
	check (stav in ('Nova', 'Vyrabi se', 'Skladem', 'Odeslano'));

create index IDX_TIS_ZAKAZKA_STAV on TIS_ZAKAZKA (stav);

create sequence SEQ_TIS_ZAKAZKA_ID start with 1 nocache;

create or replace trigger TIS_ZAKAZKA_BI
before insert
on TIS_ZAKAZKA
for each row
begin
  -- kontrola ID
  if :new.zakazka_id is null then
    select SEQ_TIS_ZAKAZKA_ID.nextval into :new.zakazka_id from DUAL;
  end if;
  -- kontrola stavu
  if :new.stav is null then
    :new.stav := 'Nova';
  end if;
end;
/

-- POLOZKA
create table TIS_POLOZKA(
  zakazka_id number(10) not null,
  vyrobek_id number(10) not null,
  pocet number(6) not null
  );

alter table TIS_POLOZKA add constraint PK_TIS_POLOZKA
	primary key (zakazka_id, vyrobek_id);

alter table TIS_POLOZKA add constraint FK_TIS_POLOZKA_ZAKAZKA
	foreign key (zakazka_id) references TIS_ZAKAZKA(zakazka_id);

alter table TIS_POLOZKA add constraint FK_TIS_POLOZKA_VYROBEK
	foreign key (vyrobek_id) references TIS_VYROBEK(vyrobek_id);

alter table TIS_POLOZKA add constraint CK_TIS_POLOZKA_POCET
	check (pocet > 0);

create or replace trigger TIS_POLOZKA_BI
before insert
on TIS_POLOZKA
for each row
begin
  -- kontrola poctu
  if :new.pocet is null then
    :new.pocet := 1;
  end if;
end;
/

-- SKLAD
create table TIS_SKLAD(
  sklad_id number(10) not null,
  vyrobek_id number(10) not null,
  zakazka_id number(10),
  pocet number(6) not null
  );

alter table TIS_SKLAD add constraint PK_TIS_SKLAD
	primary key (sklad_id);

alter table TIS_SKLAD add constraint FK_TIS_SKLAD_VYROBEK
	foreign key (vyrobek_id) references TIS_VYROBEK(vyrobek_id);

alter table TIS_SKLAD add constraint FK_TIS_SKLAD_ZAKAZKA
	foreign key (zakazka_id) references TIS_ZAKAZKA(zakazka_id);

alter table TIS_SKLAD add constraint CK_TIS_SKLAD_POCET
	check (pocet > 0);

create sequence SEQ_TIS_SKLAD_ID start with 1 nocache;

create or replace trigger TIS_SKLAD_BI
before insert
on TIS_SKLAD
for each row
begin
  -- kontrola ID
  if :new.sklad_id is null then
    select SEQ_TIS_SKLAD_ID.nextval into :new.sklad_id from DUAL;
  end if;
end;
/


-- VYROBNI_LINKA
create table TIS_VYROBNI_LINKA(
  vyrobni_linka_id number(10) not null,
  nazev varchar2(20) not null,
  kapacita number(6) not null,
  vykonnost number(6,4) not null,
  aktivni number(1) not null
  );

alter table TIS_VYROBNI_LINKA add constraint PK_TIS_VYROBNI_LINKA
	primary key (vyrobni_linka_id);

alter table TIS_VYROBNI_LINKA add constraint UK_TIS_VYROBNI_LINKA
	unique (nazev);

alter table TIS_VYROBNI_LINKA add constraint CK_TIS_VYROBNI_LINKA_KAPACITA
	check (kapacita > 0);

alter table TIS_VYROBNI_LINKA add constraint CK_TIS_VYROBNI_LINKA_VYKONNOST
	check (vykonnost > 0);

alter table TIS_VYROBNI_LINKA add constraint CK_TIS_VYROBNI_LINKA_AKTIVNI
	check ((aktivni = 0) or (aktivni = 1));
  
create sequence SEQ_TIS_VYROBNI_LINKA_ID start with 1 nocache;

create or replace trigger TIS_VYROBNI_LINKA_BI
before insert
on TIS_VYROBNI_LINKA
for each row
begin
  -- kontrola ID
  if :new.vyrobni_linka_id is null then
    select SEQ_TIS_VYROBNI_LINKA_ID.nextval into :new.vyrobni_linka_id from DUAL;
  end if;
  -- kontrola kapacity
  if :new.kapacita is null then
    :new.kapacita := 1;
  end if;
  -- kontrola vykonnosti
  if :new.vykonnost is null then
    :new.vykonnost := 1;
  end if;
  -- kontrola aktivni
  if :new.aktivni is null then
    :new.aktivni := 1;
  end if;
end;
/

-- PLAN
create table TIS_PLAN(
  plan_id number(10) not null,
  vyrobek_id number(10) not null,
  zakazka_id number(10),
  vyrobni_linka_id number(10),
  datum_vytvoreni date not null,
  datum_vyroba_start date,
  datum_vyroba_konec date,
  pocet number(6) not null,
  stav varchar2(20) not null
  );

alter table TIS_PLAN add constraint PK_TIS_PLAN
	primary key (plan_id);

alter table TIS_PLAN add constraint FK_TIS_PLAN_VYROBEK
	foreign key (vyrobek_id) references TIS_VYROBEK(vyrobek_id);

alter table TIS_PLAN add constraint FK_TIS_PLAN_ZAKAZKA
	foreign key (zakazka_id) references TIS_ZAKAZKA(zakazka_id);

alter table TIS_PLAN add constraint FK_TIS_PLAN_VYROBNI_LINKA
	foreign key (vyrobni_linka_id) references TIS_VYROBNI_LINKA(vyrobni_linka_id);

alter table TIS_PLAN add constraint CK_TIS_PLAN_POCET
	check (pocet > 0);

alter table TIS_PLAN add constraint CK_TIS_PLAN_STAV
	check (stav in ('Naplanovano', 'Vyrabi se', 'Vyrobeno'));

create index IDX_TIS_PLAN_STAV on TIS_PLAN (stav);

create sequence SEQ_TIS_PLAN_ID start with 1 nocache;

create or replace trigger TIS_PLAN_BI
before insert
on TIS_PLAN
for each row
begin
  -- kontrola ID
  if :new.plan_id is null then
    select SEQ_TIS_PLAN_ID.nextval into :new.plan_id from DUAL;
  end if;
  -- kontrola datumu vytvoreni
  if :new.datum_vytvoreni is null then
    :new.datum_vytvoreni := SYSDATE;
  end if;
  -- kontrola stavu
  if :new.stav is null then
    :new.stav := 'Naplanovano';
  end if;
end;
/

-- UZIVATEL
create table TIS_UZIVATEL(
  jmeno varchar(50) not null,
  heslo varchar(50) not null,
  uloha varchar(10) not null,
  zakaznik_id number(10)
  );

alter table TIS_UZIVATEL add constraint PK_TIS_UZIVATEL
	primary key (jmeno);

alter table TIS_UZIVATEL add constraint FK_TIS_UZIVATEL_ZAKAZNIK
	foreign key (zakaznik_id) references TIS_ZAKAZNIK(zakaznik_id);

alter table TIS_UZIVATEL add constraint CK_TIS_UZIVATEL_ULOHA
	check (uloha in ('Zakaznik', 'Obchodnik', 'Vyroba'));
/
