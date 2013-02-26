DECLARE
-- nutne vyplnit !!!
var_lot_id VARCHAR(11) := 'TC78178.8H';

var_asm1_cp_count NUMBER(2) := 4;
var_asm1_wafer_count NUMBER(2) := 8;

var_asm2_cp_count NUMBER(2) := 0;
var_asm2_wafer_count NUMBER(2) := 4; /* NESMI BYT NULA !!! */




var_sort_by_value VARCHAR(20) := 'INPUT-THK';


var_assembly_id NUMBER(8); -- id z assembly tabulky (rozlozeni)
var_assembly_order NUMBER(3) := 1;

var_cassette_order NUMBER(3) := 1;


BEGIN
  INSERT INTO PSC_LOT_ASSEMBLIES (lot_id, NAME, division, of_type, assembly1_cp_count, assembly1_wafer_count, assembly2_cp_count, assembly2_wafer_count, ng_wafer_count) 
                          VALUES (var_lot_id, 'ASMBL_' || var_lot_id || '_a', 'NEW', 'OF', var_asm1_cp_count, var_asm1_wafer_count, var_asm2_cp_count, var_asm2_wafer_count, 0);

  SELECT assembly_id into var_assembly_id FROM (select assembly_id from psc_lot_assemblies WHERE lot_id = var_lot_id order by name desc) where rownum <=1;
-- -------------------------------

  INSERT INTO PSC_LOT_ACTIVE_ASMBL_HISTORY (lot_id, assembly_id, valid_time) VALUES (var_lot_id, var_assembly_id, to_date('2012/01/01:12:00:00', 'yyyy/mm/dd:hh:mi:ss'));
  
  -- nacti seznam desek podle lot id, serazeno dle tloustky - podle parametru var_sorting (desc/asc)
  FOR wid IN (SELECT wafers.wafer_id 
                FROM psc_wafers wafers 
                LEFT JOIN psc_wafer_data wdata ON wdata.wafer_id = wafers.wafer_id 
               WHERE parent_lot_id = var_lot_id 
               ORDER BY wdata.value)
  LOOP
    IF var_assembly_order <= (var_asm1_cp_count * var_asm1_wafer_count + var_asm2_cp_count * var_asm2_wafer_count) THEN
      INSERT INTO psc_lot_assembly_wafers(assembly_id, wafer_id, assembly_order) VALUES (var_assembly_id, wid.wafer_id, var_assembly_order);
    END IF;
    
    var_assembly_order := var_assembly_order + 1;
  END LOOP;
  
  FOR cassid IN (SELECT cassette_usage_id 
                   FROM psc_cassette_view 
                  WHERE lot_id = var_lot_id 
                  ORDER BY cassette_usage_id)
  LOOP
    INSERT INTO psc_lot_assembly_cassettes VALUES (cassid.cassette_usage_id, var_cassette_order);
    var_cassette_order := var_cassette_order + 1;
  END LOOP;
END;