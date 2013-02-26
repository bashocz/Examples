-- opakuj nasledujici testy pro vsechny skupiny 1..4

-- (A) vytvoreni tabulky a indexu
create table tmapper_events_test
as
select * from tmapper_events_copy where eventdate > '31.12.2008';
-- kolik ma tabulka radku?
select count(*) from tmapper_events_test;

select count(distinct event_id) from tmapper_events_test;
select count(distinct eventdate) from tmapper_events_test;
select count(distinct lot) from tmapper_events_test;
select count(distinct wafer_id) from tmapper_events_test;
select count(distinct message) from tmapper_events_test;
select count(distinct prober_id) from tmapper_events_test;
select count(distinct tester_id) from tmapper_events_test;
select count(distinct adapter_id) from tmapper_events_test;
select count(distinct test_board) from tmapper_events_test;
select count(distinct sampling) from tmapper_events_test;
select count(distinct gooddice) from tmapper_events_test;

-- vytvoreni vsech indexu - spoustej podle skupin

-- indexy na sloupec EVENT_ID
-- b-strom index - skupina 2, 4
create index tmapper_events_test_id_idx on tmapper_events_test(event_id);
-- bitmap index - skupina 3
create bitmap index tmapper_events_test_id_bmx on tmapper_events_test(event_id);
-- indexy na sloupec EVENTDATE
-- b-strom index - skupina 2, 4
create index tmapper_events_test_date_idx on tmapper_events_test(eventdate);
-- bitmap index - skupina 3
create bitmap index tmapper_events_test_date_bmx on tmapper_events_test(eventdate);
-- indexy na sloupec LOT
-- b-strom index - skupina 2
create index tmapper_events_test_lot_idx on tmapper_events_test(lot);
-- bitmap index - skupina 3, 4
create bitmap index tmapper_events_test_lot_bmx on tmapper_events_test(lot);
-- indexy na sloupec WAFER_ID
-- b-strom index - skupina 2
create index tmapper_events_test_wafer_idx on tmapper_events_test(wafer_id);
-- bitmap index - skupina 3, 4
create bitmap index tmapper_events_test_wafer_bmx on tmapper_events_test(wafer_id);
-- indexy na sloupec MESSAGE
-- b-strom index - skupina 2
create index tmapper_events_test_msg_idx on tmapper_events_test(message);
-- bitmap index - skupina 3, 4
create bitmap index tmapper_events_test_msg_bmx on tmapper_events_test(message);
-- indexy na sloupec PROBER_ID
-- b-strom index - skupina 2
create index tmapper_events_test_prober_idx on tmapper_events_test(prober_id);
-- bitmap index - skupina 3, 4
create bitmap index tmapper_events_test_prober_bmx on tmapper_events_test(prober_id);
-- indexy na sloupec TESTER_ID
-- b-strom index - skupina 2
create index tmapper_events_test_tester_idx on tmapper_events_test(tester_id);
-- bitmap index - skupina 3, 4
create bitmap index tmapper_events_test_tester_bmx on tmapper_events_test(tester_id);
-- indexy na sloupec ADAPTER_ID
-- b-strom index - skupina 2
create index tmapper_events_test_adp_idx on tmapper_events_test(adapter_id);
-- bitmap index - skupina 3, 4
create bitmap index tmapper_events_test_adp_bmx on tmapper_events_test(adapter_id);
-- indexy na sloupec TEST_BOARD
-- b-strom index - skupina 2
create index tmapper_events_test_board_idx on tmapper_events_test(test_board);
-- bitmap index - skupina 3, 4
create bitmap index tmapper_events_test_board_bmx on tmapper_events_test(test_board);
-- indexy na sloupec SAMPLING
-- b-strom index - skupina 2
create index tmapper_events_test_smpl_idx on tmapper_events_test(sampling);
-- bitmap index - skupina 3, 4
create bitmap index tmapper_events_test_smpl_bmx on tmapper_events_test(sampling);
-- indexy na sloupec GOODDICE
-- b-strom index - skupina 2
create index tmapper_events_test_good_idx on tmapper_events_test(gooddice);
-- bitmap index - skupina 3, 4
create bitmap index tmapper_events_test_good_bmx on tmapper_events_test(gooddice);
-- analyzuje tabulku a vytvori statistiky pro optimalizator
analyze table tmapper_events_test compute statistics for table for all indexes for all indexed columns;

-- kolik maji tabulky MB
select substr(segment_name,1,30) segment_name, bytes/1024/1024 "Size in MB"
from user_segments
where segment_name in ('TMAPPER_EVENTS_TEST',
                       'TMAPPER_EVENTS_TEST_ID_IDX',
                       'TMAPPER_EVENTS_TEST_DATE_IDX',
                       'TMAPPER_EVENTS_TEST_LOT_IDX',
                       'TMAPPER_EVENTS_TEST_WAFER_IDX',
                       'TMAPPER_EVENTS_TEST_MSG_IDX',
                       'TMAPPER_EVENTS_TEST_PROBER_IDX',
                       'TMAPPER_EVENTS_TEST_TESTER_IDX',
                       'TMAPPER_EVENTS_TEST_ADP_IDX',
                       'TMAPPER_EVENTS_TEST_BOARD_IDX',
                       'TMAPPER_EVENTS_TEST_SMPL_IDX',
                       'TMAPPER_EVENTS_TEST_GOOD_IDX',
                       'TMAPPER_EVENTS_TEST_ID_BMX',
                       'TMAPPER_EVENTS_TEST_DATE_BMX',
                       'TMAPPER_EVENTS_TEST_LOT_BMX',
                       'TMAPPER_EVENTS_TEST_WAFER_BMX',
                       'TMAPPER_EVENTS_TEST_MSG_BMX',
                       'TMAPPER_EVENTS_TEST_PROBER_BMX',
                       'TMAPPER_EVENTS_TEST_TESTER_BMX',
                       'TMAPPER_EVENTS_TEST_ADP_BMX',
                       'TMAPPER_EVENTS_TEST_BOARD_BMX',
                       'TMAPPER_EVENTS_TEST_SMPL_BMX',
                       'TMAPPER_EVENTS_TEST_GOOD_BMX'
                       );


                       
-- (B) insert
insert into tmapper_events_test
select * from tmapper_events_copy t where t.eventdate > '28.12.2008' and eventdate < '1.1.2009';
-- jaky byl cas teto operace?
-- kolik ma tabulka nyni radku?
-- kolik maji tabulky MB


-- (C) update
update tmapper_events_test set message = 'LP'
where eventdate < '1.1.2009';
-- jaky byl cas teto operace?
-- kolik ma tabulka nyni radku?
-- kolik maji tabulky MB


-- (D) delete
delete from tmapper_events_test
where eventdate < '1.1.2009';
-- jaky byl cas teto operace?
-- kolik ma tabulka nyni radku?
-- kolik maji tabulky MB


-- (E) select
select count(*) from tmapper_events_test where event_id = 35483553;
-- jaky byl prumerny cas teto operace?


-- (F) select
select count(*) from tmapper_events_test where event_id > 35483553 and event_id < 35531535;
-- jaky byl prumerny cas teto operace?


-- (G) select
select count(*) from tmapper_events_test where eventdate = '10.11.2009';
-- jaky byl prumerny cas teto operace?


-- (H) select
select count(*) from tmapper_events_copy where eventdate > '30.6.2009' and eventdate < '1.9.2009';
-- jaky byl prumerny cas teto operace?


-- (I) select
select count(*) from tmapper_events_test where lot = 'RG47769.1H';
-- jaky byl prumerny cas teto operace?


-- (J) select
select count(*) from tmapper_events_test where lot like 'RG477%';
-- jaky byl prumerny cas teto operace?


-- (K) select
select count(*) from tmapper_events_test where lot = 'RG47769.1H' and wafer_id = 10;
-- jaky byl prumerny cas teto operace?


-- (L) select
select count(*) from tmapper_events_test where lot = 'RG47769.1H' and message = 'PF';
-- jaky byl prumerny cas teto operace?


-- (M) select
select count(*) from tmapper_events_test where prober_id = 'ATPBR16';
-- jaky byl prumerny cas teto operace?


-- (N) select
select count(*) from tmapper_events_test where prober_id = 'ATPBR16' or prober_id = 'ATPBR35';
-- jaky byl prumerny cas teto operace?


-- (O) select
select count(*) from tmapper_events_test where tester_id = 'ATTST18';
-- jaky byl prumerny cas teto operace?


-- (P) select
select count(*) from tmapper_events_test where tester_id = 'ATTST18' and tester_id = 'ATTST10';
-- jaky byl prumerny cas teto operace?


-- (Q) select
select count(*) from tmapper_events_test where adapter_id = '468';
-- jaky byl prumerny cas teto operace?


-- (R) select
select count(*) from tmapper_events_test where test_board = '1083';
-- jaky byl prumerny cas teto operace?


-- (S) select
select count(*) from tmapper_events_test where sampling = 'Y';
-- jaky byl prumerny cas teto operace?


-- (T) select
select count(*) from tmapper_events_test where gooddice < 1000;
-- jaky byl prumerny cas teto operace?


-- (U) select
select count(*) from tmapper_events_test where gooddice > 1000 and gooddice < 10000;
-- jaky byl prumerny cas teto operace?


-- (V) select
select count(*) from tmapper_events_test where lot = 'RG47769.1H' and wafer_id = 10 and (message = 'PS' or message = 'PF');
-- jaky byl prumerny cas teto operace?


-- (W) select
select count(distinct lot) from tmapper_events_test where tester_id = 'ATTST18' and eventdate > '30.6.2009' and eventdate < '1.9.2009';
-- jaky byl prumerny cas teto operace?


-- (X) select
select count(distinct lot) from tmapper_events_test where tester_id = 'ATTST18' and (message = 'PSP' or message = 'PFP') and sampling = 'N' and eventdate > '30.6.2009' and eventdate < '1.9.2009';
-- jaky byl prumerny cas teto operace?


-- (Y) select
select count(distinct lot) from tmapper_events_test where (prober_id = 'ATPBR12' or prober_id = 'ATPBR16' or prober_id = 'ATPBR19' or prober_id = 'ATPBR24') 
and (message = 'LP' or message = 'PSP' or message = 'PFP'or message = 'ISP' or message = 'IFP');
-- jaky byl prumerny cas teto operace?


-- (Z) drop tables - uklid
-- indexy na sloupec EVENT_ID
-- b-strom index - skupina 2, 4
drop index tmapper_events_test_id_idx;
-- bitmap index - skupina 3
drop index tmapper_events_test_id_bmx;
-- indexy na sloupec EVENTDATE
-- b-strom index - skupina 2
drop index tmapper_events_test_date_idx;
-- bitmap index - skupina 3
drop index tmapper_events_test_date_bmx;
-- indexy na sloupec LOT
-- b-strom index - skupina 2, 4
drop index tmapper_events_test_lot_idx;
-- bitmap index - skupina 3
drop index tmapper_events_test_lot_bmx;
-- indexy na sloupec WAFER_ID
-- b-strom index - skupina 2
drop index tmapper_events_test_wafer_idx;
-- bitmap index - skupina 3, 4
drop index tmapper_events_test_wafer_bmx;
-- indexy na sloupec MESSAGE
-- b-strom index - skupina 2
drop index tmapper_events_test_msg_idx;
-- bitmap index - skupina 3, 4
drop index tmapper_events_test_msg_bmx;
-- indexy na sloupec PROBER_ID
-- b-strom index - skupina 2
drop index tmapper_events_test_prober_idx;
-- bitmap index - skupina 3, 4
drop index tmapper_events_test_prober_bmx;
-- indexy na sloupec TESTER_ID
-- b-strom index - skupina 2
drop index tmapper_events_test_tester_idx;
-- bitmap index - skupina 3, 4
drop index tmapper_events_test_tester_bmx;
-- indexy na sloupec ADAPTER_ID
-- b-strom index - skupina 2
drop index tmapper_events_test_adp_idx;
-- bitmap index - skupina 3
drop index tmapper_events_test_adp_bmx;
-- indexy na sloupec TEST_BOARD
-- b-strom index - skupina 2
drop index tmapper_events_test_board_idx;
-- bitmap index - skupina 3
drop index tmapper_events_test_board_bmx;
-- indexy na sloupec SAMPLING
-- b-strom index - skupina 2
drop index tmapper_events_test_smpl_idx;
-- bitmap index - skupina 3
drop index tmapper_events_test_smpl_bmx;
-- indexy na sloupec GOODDICE
-- b-strom index - skupina 2
drop index tmapper_events_test_good_idx;
-- bitmap index - skupina 3
drop index tmapper_events_test_good_bmx;

-- samotna tabulka
drop table tmapper_events_test;