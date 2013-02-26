
--SELECT * FROM psc_cassette_view WHERE lot_id = 'TC15346.1N'
--SELECT * FROM psc_wafers WHERE parent_lot_id = 'TC15346.1N'
--SELECT * FROM psc_wafer_history WHERE wafer_id IN (SELECT wafer_id FROM psc_wafers WHERE parent_lot_id = 'TC15346.1N')
--SELECT * FROM psc_cassette_usage WHERE cassette_usage_id IN (SELECT cassette_usage_id FROM psc_cassette_view WHERE lot_id = 'TC15346.1N') 

SET serveroutput ON format wrapped;


DECLARE
-- nutne vyplnit !!!
var_lot_id VARCHAR(11) := 'TC15346.1N';
var_asm1_cp_count NUMBER(4) := 4;
var_asm1_wafer_count NUMBER(4) := 4;
var_asm2_cp_count NUMBER(4) := 0;
var_asm2_wafer_count NUMBER(4) := 4;

--     SELECT assembly_id FROM (SELECT assembly_id FROM psc_lot_assemblies WHERE lot_id = 'TC15346.1N' AND ROWNUM = 1);
var_assembly_id NUMBER(4) := 21;

      
-- promenne
var_stadium_position NUMBER(2);
var_wafers_count NUMBER(4);
var_cassette_barcode VARCHAR(11);

BEGIN
    INSERT INTO PSC_LOT_ASSEMBLIES (lot_id, NAME, division, of_type, assembly1_cp_count, assembly1_wafer_count, assembly2_cp_count, assembly2_wafer_count, ng_wafer_count) 
      VALUES (var_lot_id, 'ASMBL_' || var_lot_id || '_a', 'NEW', 'OF', var_asm1_cp_count, var_asm1_wafer_count, var_asm2_cp_count, var_asm2_wafer_count, 0);

    INSERT INTO psc_lot_active_asmbl_history(lot_id, assembly_id, valid_time)
      VALUES(var_lot_id, var_assembly_id, to_date('2012/01/01:12:00:00', 'yyyy/mm/dd:hh:mi:ss'));


    var_stadium_position := 1;
    FOR var_cassette_barcode IN (SELECT barcode
                                   FROM psc_cassette_view
                                  WHERE lot_id = var_lot_id)
        LOOP
        BEGIN
          INSERT INTO PSC_LOT_ASSEMBLY_CASSETTES(cassette_usage_id, stadium_position) 
            VALUES ((SELECT cassette_usage_id FROM psc_cassette_view WHERE barcode=var_cassette_barcode), var_stadium_position);
        
          var_stadium_position := var_stadium_position + 1;
        END;
        END LOOP;
    
    -- ---------------------------------------------------------------------------------------------------------------------------
       
    var_assembly_id := 1;                          
    FOR var_waferid IN (SELECT wafer_id
                      FROM psc_cassette_wafers 
                     WHERE cassette_usage_id IN (SELECT cassette_usage_id 
                                                   FROM psc_cassette_view 
                                                  WHERE lot_id=var_lot_id)
                   ) 
    LOOP
    BEGIN
       
        INSERT INTO psc_lot_assembly_wafers(assembly_id, wafer_id, assembly_order) VALUES (var_assembly_id, var_waferid, var_assembly_id);
        var_assembly_id := var_assembly_id + 1;
    END;
    END LOOP;

END;
