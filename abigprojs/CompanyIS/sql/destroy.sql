-- PLAN
drop index IDX_TIS_PLAN_STAV;
drop trigger TIS_PLAN_BI;
drop sequence SEQ_TIS_PLAN_ID;
drop table TIS_PLAN cascade constraints;

-- VYROBNI_LINKA
drop trigger TIS_VYROBNI_LINKA_BI;
drop sequence SEQ_TIS_VYROBNI_LINKA_ID;
drop table TIS_VYROBNI_LINKA cascade constraints;

-- SKLAD
drop trigger TIS_SKLAD_BI;
drop sequence SEQ_TIS_SKLAD_ID;
drop table TIS_SKLAD cascade constraints;

-- POLOZKA
drop trigger TIS_POLOZKA_BI;
drop table TIS_POLOZKA cascade constraints;

-- ZAKAZKA
drop index IDX_TIS_ZAKAZKA_STAV;
drop trigger TIS_ZAKAZKA_BI;
drop sequence SEQ_TIS_ZAKAZKA_ID;
drop table TIS_ZAKAZKA cascade constraints;

-- VYROBEK
drop trigger TIS_VYROBEK_BI;
drop sequence SEQ_TIS_VYROBEK_ID;
drop table TIS_VYROBEK cascade constraints;

-- ZAKAZNIK
drop index IDX_TIS_ZAKAZNIK_MESTO;
drop index IDX_TIS_ZAKAZNIK_JMENO;
drop trigger TIS_ZAKAZNIK_BI;
drop sequence SEQ_TIS_ZAKAZNIK_ID;
drop table TIS_ZAKAZNIK cascade constraints;

-- UZIVATEL
drop table TIS_UZIVATEL cascade constraints;
