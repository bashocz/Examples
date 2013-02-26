SELECT * FROM temp_psc_carrier_plates

CREATE TABLE TEMP_PSC_CARRIER_PLATES (CP_ID NUMBER(4,0) PRIMARY KEY, BARCODE VARCHAR2(20 BYTE), INSPECTION CHAR(1 BYTE), BC_MISREAD_COUNT NUMBER(8,0), USED_COUNT NUMBER(8,0) );
CREATE SEQUENCE TEMP_PSC_CP_SEQUENCE START WITH 1 INCREMENT BY 1;
CREATE OR REPLACE TRIGGER TEMP_PSC_CP_TRIGGER BEFORE INSERT ON TEMP_PSC_CARRIER_PLATES 
  REFERENCING NEW AS NEW FOR EACH ROW BEGIN SELECT TEMP_PSC_CP_SEQUENCE.nextval INTO :NEW.CP_ID FROM dual; 
END;
  
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0169', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0169', 'N', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0205', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0396', 'N', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0577', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0551', 'N', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0083', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0049', 'N', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0419', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0424', 'N', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0029', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0616', 'N', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0064', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0586', 'N', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0019', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0075', 'N', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0414', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0564', 'N', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0154', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0231', 'N', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0491', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0056', 'N', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0589', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0508', 'N', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0043', 'N', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0138', 'N', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0076', 'N', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0374', 'N', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0418', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0283', 'N', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0458', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0113', 'N', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0601', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0495', 'Y', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0558', 'Y', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0407', 'Y', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0107', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0570', 'N', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0238', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0363', 'Y', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0213', 'N', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0063', 'N', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0480', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0086', 'N', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0463', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0441', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0537', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0479', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0315', 'Y', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0346', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0432', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0034', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0606', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0286', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0569', 'Y', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0017', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0581', 'N', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0288', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0362', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0178', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0546', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0338', 'N', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0519', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0001', 'N', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0073', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0518', 'N', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0227', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0514', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0576', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0367', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0341', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0044', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0028', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0578', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0065', 'N', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0378', 'N', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0322', 'N', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0313', 'N', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0386', 'N', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0042', 'N', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0226', 'N', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0112', 'N', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0276', 'N', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0011', 'Y', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0136', 'Y', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0163', 'Y', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0084', 'Y', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0612', 'Y', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0149', 'Y', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0080', 'Y', 0, 0);
INSERT INTO temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) VALUES ('0041', 'Y', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0497', 'Y', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0320', 'Y', 0, 0);
insert into temp_psc_carrier_plates(barcode, inspection, bc_misread_count, used_count) values ('0303', 'Y', 0, 0);

MERGE INTO psc_carrier_plates orig
USING temp_psc_carrier_plates temp ON (orig.barcode = temp.barcode)
WHEN NOT MATCHED THEN INSERT (orig.barcode, orig.inspection, orig.bc_misread_count, orig.used_count) VALUES (temp.barcode, temp.inspection, temp.bc_misread_count, temp.used_count);

commit;

DROP TRIGGER TEMP_PSC_CP_TRIGGER;
DROP SEQUENCE TEMP_PSC_CP_SEQUENCE;
DROP TABLE temp_psc_carrier_plates;
commit;