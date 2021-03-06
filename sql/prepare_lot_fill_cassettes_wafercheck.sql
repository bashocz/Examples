set serveroutput on format wrapped;

DECLARE
-- nutne vyplnit !!!
var_lot_id VARCHAR(11) := 'TC15380.AA';
var_lot_wafers_count NUMBER(5) := 32;
var_part_id NUMBER(2) := 3;
var_asm1_cp_count NUMBER(2) := 8;
var_asm2_cp_count NUMBER(2) := 0;
var_asm1_wafer_count NUMBER(2) := 4;
var_asm2_wafer_count NUMBER(2) := 4; /* NESMI BYT NULA !!! */



var_cassette_number NUMBER(10) := 2; /* pokud 0, dopocita se automaticky, kazety se budou pocitat 'do plna' - prvni kazety budou po 25, posledni kazeta bude mit zbytek waferu */
                                     /* v opacnem pripade je treba zadat, kolik kazet se bude plnit a v nasledujicim poli presne vyplnit, ktera kazeta bude mit kolik waferu */ 

var_cass1_count NUMBER(2) := 25;
var_cass2_count NUMBER(2) := 7;
var_cass3_count NUMBER(2) := 0;
var_cass4_count NUMBER(2) := 0;
var_cass5_count NUMBER(2) := 0;
var_cass6_count NUMBER(2) := 0;
var_cass7_count NUMBER(2) := 0;

-- promenne
var_cass_count NUMBER(2) := 0;
var_cass_capa NUMBER(2) := 0;
var_assembly_id NUMBER(10); -- vyplni se po vlozeni do psc_lot_assemblies
var_last_wafer_id NUMBER(10);
var_cassette_usage_id NUMBER(10);
var_cassette_id NUMBER(10);
var_lot_wafers_counter NUMBER(10) := 0;

BEGIN
  IF (var_asm2_wafer_count = 0) THEN
  BEGIN
    DBMS_OUTPUT.put_line('CHYBA!!: Pocet waferu na unaseci nesmi byt nula !');
    RETURN;
  END;
  END IF;
    
  DBMS_OUTPUT.put_line('INSERT INTO PSC_LOTS(' || var_lot_id || ', ' || var_part_id || ', ' || SYSDATE || ')');
  INSERT INTO psc_lots(lot_id, part_id, create_time) VALUES (var_lot_id, var_part_id, SYSDATE);

  DBMS_OUTPUT.put_line('add wafers to psc_wafers table');
  BEGIN
    FOR lcntr IN 1..var_lot_wafers_count
    LOOP
      DBMS_OUTPUT.put_line('    INSERT INTO psc_wafers(' || var_lot_id || ', ' || lcntr || ')');
      INSERT INTO psc_wafers(PARENT_LOT_ID, WAFER_NUMBER) VALUES (var_lot_id, lcntr);
      
      SELECT wafer_id INTO var_last_wafer_id FROM (SELECT wafer_id FROM psc_wafers ORDER BY wafer_id DESC) WHERE ROWNUM = 1;
      
      DBMS_OUTPUT.put_line('    INSERT INTO psc_wafer_history(' || var_last_wafer_id || ', PROCESS, ' || sysdate || ')');
      INSERT INTO psc_wafer_history(wafer_id, wafer_state, event_time) VALUES (var_last_wafer_id, 'PROCESS', sysdate);
    END LOOP;
  END;
  
  -- zjistit wafer_id z psc_wafers, kde zacinaji desky pro dany lot
  SELECT wafer_id - 1 INTO var_last_wafer_id 
    FROM (SELECT wafer_id 
            FROM psc_wafers 
           WHERE parent_lot_id = var_lot_id 
           ORDER BY wafer_id) 
   WHERE ROWNUM=1;
  
  BEGIN
    IF (var_cassette_number <= 0) THEN
      WHILE var_lot_wafers_counter <= ((var_asm1_cp_count * var_asm1_wafer_count) + (var_asm2_cp_count * var_asm2_wafer_count))
      LOOP
        var_cassette_number := var_cassette_number + 1;
        var_lot_wafers_counter := var_lot_wafers_counter + 25;
      END LOOP;
      DBMS_OUTPUT.put_line('Pocet kazet: ' || var_cassette_number);
    END IF;  
      
    FOR lcntr IN 1..var_cassette_number
    LOOP
      SELECT cassette_id INTO var_cassette_id
        FROM (
              SELECT * 
                FROM psc_cassette_view 
               WHERE cassette_type = 'I' 
                 AND ((cassette_state IS NULL) OR (cassette_state = 'UNLOADED'))
                 AND substr(barcode, 0, 3) = 'CAS' 
             )
        WHERE ROWNUM = 1;
      
      DBMS_OUTPUT.put_line('INSERT INTO psc_cassette_usage(' || var_cassette_id || ', ' || sysdate || ')');
      INSERT INTO psc_cassette_usage(cassette_id, usage_time) VALUES (var_cassette_id, SYSDATE);
      
      SELECT cassette_usage_id INTO var_cassette_usage_id 
        FROM (SELECT cassette_usage_id 
                FROM psc_cassette_usage 
               WHERE cassette_id = var_cassette_id 
               ORDER BY cassette_usage_id DESC
             ) 
       WHERE ROWNUM=1;

      DBMS_OUTPUT.put_line('-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-');

      DBMS_OUTPUT.put_line('INSERT INTO psc_cassette_history(' || var_cassette_usage_id || ', LOADED, ' || SYSDATE || ')');
      INSERT INTO psc_cassette_history(cassette_usage_id, cassette_state, event_time) values (var_cassette_usage_id, 'LOADED', sysdate);
      
      DBMS_OUTPUT.put_line('INSERT INTO psc_cassette_lot_history(' || var_cassette_usage_id || ', ' || var_lot_id || ', ' || SYSDATE || ')');
      INSERT INTO psc_cassette_lot_history(cassette_usage_id, lot_id, valid_time) VALUES (var_cassette_usage_id, var_lot_id, SYSDATE);
      
      DBMS_OUTPUT.put_line('PSC_CASSETTE_WAFERS');
      BEGIN
        var_cass_capa := ((var_asm1_cp_count * var_asm1_wafer_count) + (var_asm2_cp_count * var_asm2_wafer_count)) - (lcntr - 1)*25;
        IF (lcntr = 1) THEN
          IF (((var_asm1_cp_count * var_asm1_wafer_count) + (var_asm2_cp_count * var_asm2_wafer_count)) > 25) THEN
            var_cass_capa := 25;
          END IF;
        END IF;
        
        IF (lcntr = 1) THEN var_cass_count := 0; IF (var_cass1_count > 0) THEN var_cass_capa := var_cass1_count; END IF; ELSE var_cass_count := 0; END IF;
        IF (lcntr = 2) THEN IF (var_cass1_count > 0) THEN var_cass_count := var_cass_count + var_cass1_count; var_cass_capa := var_cass2_count; ELSE var_cass_count := 25; END IF; END IF;
        IF (lcntr = 3) THEN IF (var_cass2_count > 0) THEN var_cass_count := var_cass_count + var_cass2_count; var_cass_capa := var_cass3_count; ELSE var_cass_count := 50; END IF; END IF;
        IF (lcntr = 4) THEN IF (var_cass3_count > 0) THEN var_cass_count := var_cass_count + var_cass3_count; var_cass_capa := var_cass4_count; ELSE var_cass_count := 75; END IF; END IF;
        IF (lcntr = 5) THEN IF (var_cass4_count > 0) THEN var_cass_count := var_cass_count + var_cass4_count; var_cass_capa := var_cass5_count; ELSE var_cass_count := 100; END IF; END IF;
        IF (lcntr = 6) THEN IF (var_cass5_count > 0) THEN var_cass_count := var_cass_count + var_cass5_count; var_cass_capa := var_cass6_count; ELSE var_cass_count := 125; END IF; END IF;

        FOR counter IN 1..var_cass_capa
        LOOP
          DBMS_OUTPUT.put_line('    ' || var_cassette_usage_id || ', ' || (var_last_wafer_id + var_cass_count + counter) || ', ' || (26 - counter) || 'Y)');
          INSERT INTO psc_cassette_wafers(cassette_usage_id, wafer_id, slot, is_present) VALUES (var_cassette_usage_id, var_last_wafer_id + var_cass_count + counter, 26 - counter, 'Y');
        END LOOP;
      END;

     END LOOP;
  END;

  SELECT assembly_id into var_assembly_id FROM psc_lot_assemblies WHERE lot_id = var_lot_id;
-- -------------------------------

  INSERT INTO PSC_LOT_HISTORY(lot_id, lot_state, lot_stage, event_time) VALUES (var_lot_id, 'ACTIVE', 'INPUT_WCHC', SYSDATE);
-- --------------------------------

END;
