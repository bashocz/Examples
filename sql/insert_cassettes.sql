/* SELECT * FROM psc_cassettes */

/*
     select * from psc_cassette_types
     1 S             CASSETTE TYPE FOR INPUT SPEC                                                                                                                                                                                                                               
     2 I             CASSETTE TYPE FOR INPUT MP1                                                                                                                                                                                                                                
     3 1             CASSETTE TYPE FOR INPUT DEWAX SPEC FROM MP1                                                                                                                                                                                                                
     4 3             CASSETTE TYPE FOR INPUT DEWAX SPEC FROM MP3                                                                                                                                                                                                                
     5 T             CASSETTE TYPE FOR DEWAX SPEC                                                                                                                                                                                                                               
     6 O             CASSETTE TYPE FOR OUTPUT WAFERCHECK                                                                                                                                                                                                                        
     7 F             CASSETTE TYPE FOR FINAL SPEC  
*/

CREATE TABLE TEMP_PSC_CASSETTES ( CASSETTE_ID NUMBER(8,0), BARCODE VARCHAR2(20 BYTE), WAFER_SIZE NUMBER(2,0), CASSETTE_TYPE_ID NUMBER(2,0), CAS_MISREAD_COUNT NUMBER(8,0), USED_COUNT NUMBER(8,0) );
CREATE SEQUENCE TEMP_PSC_CAS_SEQ START WITH 1 INCREMENT BY 1;
CREATE OR REPLACE TRIGGER TEMP_PSC_CAS_TRIGGER BEFORE INSERT ON TEMP_PSC_CASSETTES 
  REFERENCING NEW AS NEW FOR EACH ROW BEGIN SELECT TEMP_PSC_CAS_SEQ.nextval INTO :NEW.CASSETTE_ID FROM dual; 
END;

BEGIN
/* A. 50101-50119 - Vstupní SPEC, nízké */     
    FOR i IN 50101..50119 loop
      INSERT INTO TEMP_PSC_CASSETTES(barcode, wafer_size, cassette_type_id, cas_misread_count, used_count) VALUES (to_char(i), 6, 1, 0, 0);
    END loop;

/* B. 60101-60127 - Vstupní SPEC, nízké */     
    FOR i IN 60101..60127 loop
      INSERT INTO TEMP_PSC_CASSETTES(barcode, wafer_size, cassette_type_id, cas_misread_count, used_count) VALUES (to_char(i), 6, 1, 0, 0);
    END loop;

/* C. 80101-80119 - Vstupní SPEC, nízké */     
    FOR i IN 80101..80119 loop
      INSERT INTO TEMP_PSC_CASSETTES(barcode, wafer_size, cassette_type_id, cas_misread_count, used_count) VALUES (to_char(i), 6, 1, 0, 0);
    END loop;


/* D. 50401 - 50412 vysoké, Demontér MP3, + E: 60401-60408 */
    FOR i IN 50401..50412 loop
      INSERT INTO TEMP_PSC_CASSETTES(barcode, wafer_size, cassette_type_id, cas_misread_count, used_count) VALUES (to_char(i), 6, 4, 0, 0);
    END loop;

/* E. 60401 - 60440 vysoké */
    FOR i IN 60401..60408 loop /* => D -> demontér MP3 */
      INSERT INTO TEMP_PSC_CASSETTES(barcode, wafer_size, cassette_type_id, cas_misread_count, used_count) VALUES (to_char(i), 6, 4, 0, 0);
    END loop;

    FOR i IN 60417..60440 loop /* => F -> demontér MP1 */
      INSERT INTO TEMP_PSC_CASSETTES(barcode, wafer_size, cassette_type_id, cas_misread_count, used_count) VALUES (to_char(i), 6, 4, 0, 0);
    END loop;


/* F. 80401 - 80424 vysoké, demontér MP1, + E: 60417-60440 */
    FOR i IN 80401..80424 loop
      INSERT INTO TEMP_PSC_CASSETTES(barcode, wafer_size, cassette_type_id, cas_misread_count, used_count) VALUES (to_char(i), 6, 3, 0, 0);
    END loop;



/* G. 50601 - 50625 nízké, Dewax */
    FOR i IN 50601..50625 loop
      INSERT INTO TEMP_PSC_CASSETTES(barcode, wafer_size, cassette_type_id, cas_misread_count, used_count) VALUES (to_char(i), 6, 5, 0, 0);
    END loop;

/* H. 60601 - 60642 nízké, Dewax */
    FOR i IN 60601..60642 loop
      INSERT INTO TEMP_PSC_CASSETTES(barcode, wafer_size, cassette_type_id, cas_misread_count, used_count) VALUES (to_char(i), 6, 5, 0, 0);
    END loop;

/* I. 80601 - 80628 nízké, Dewax */
    FOR i IN 80601..80628 loop
      INSERT INTO TEMP_PSC_CASSETTES(barcode, wafer_size, cassette_type_id, cas_misread_count, used_count) VALUES (to_char(i), 6, 5, 0, 0);
    END loop;



/* J. 50901 - 50925 nízké, Final SPEC */
    FOR i IN 50901..50925 loop
      INSERT INTO TEMP_PSC_CASSETTES(barcode, wafer_size, cassette_type_id, cas_misread_count, used_count) VALUES (to_char(i), 6, 7, 0, 0);
    END loop;

/* K. 60901 - 60952 nízké, Final SPEC */
    FOR i IN 60901..60952 loop
      INSERT INTO TEMP_PSC_CASSETTES(barcode, wafer_size, cassette_type_id, cas_misread_count, used_count) VALUES (to_char(i), 6, 7, 0, 0);
    END loop;

/* L. 80901 - 80928 nízké, Final SPEC */
    FOR i IN 80901..80928 loop
      INSERT INTO TEMP_PSC_CASSETTES(barcode, wafer_size, cassette_type_id, cas_misread_count, used_count) VALUES (to_char(i), 6, 7, 0, 0);
    END loop;
END;

/* select * from (select barcode, count(*) as cnt from TEMP_PSC_CASSETTES group by barcode) where cnt > 1 order by barcode */

MERGE INTO PSC_CASSETTES orig
USING TEMP_PSC_CASSETTES temp ON (orig.barcode = temp.barcode)
WHEN NOT MATCHED THEN INSERT (orig.barcode, orig.wafer_size, orig.cassette_type_id, orig.cas_misread_count, orig.used_count) VALUES (temp.barcode, temp.wafer_size, temp.cassette_type_id, temp.cas_misread_count, temp.used_count);

DROP TRIGGER TEMP_PSC_CAS_TRIGGER;
DROP SEQUENCE TEMP_PSC_CAS_SEQ;
DROP TABLE TEMP_PSC_CASSETTES;


BEGIN
FOR i IN 1..9 loop
  insert into psc_cassettes(barcode, wafer_size, cassette_type_id, cas_misread_count, used_count) values ('8PALEM0' || to_char(i), 8, 2, 0, 0);
END loop;
end;

BEGIN
FOR i IN 1..9 loop
  insert into psc_cassettes(barcode, wafer_size, cassette_type_id, cas_misread_count, used_count) values ('6PALEM0' || to_char(i), 6, 2, 0, 0);
END loop;
END;

BEGIN
FOR i IN 10..99 loop
  insert into psc_cassettes(barcode, wafer_size, cassette_type_id, cas_misread_count, used_count) values ('8PALEM' || to_char(i), 8, 2, 0, 0);
END loop;
end;

BEGIN
FOR i IN 10..99 loop
  insert into psc_cassettes(barcode, wafer_size, cassette_type_id, cas_misread_count, used_count) values ('6PALEM' || to_char(i), 6, 2, 0, 0);
END loop;
END;

