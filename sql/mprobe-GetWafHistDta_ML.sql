function GetWafHistDta_ML(plot_id in varchar2, waferIndex in number, dTime in date, err_pos in out number)
	return varchar2 is

	TextData	varchar2(32000):=null;
	n		number;

  cursor c1 is
    select * from ML_ACTUAL_WAFER_HISTORY
      where lot_id_promis=pLot_ID and
	wafer_id=waferIndex
      order by last_change_date;

begin
	TextData := 'Time: ' || to_char(sysdate, 'dd.mm.yy hh24:mi:ss') || chr(13);
err_pos := 1204;
	TextData := TextData || 'ML_ACTUAL_WAFER_HISTORY table (wafID=' || to_char(waferIndex) || ')' || chr(13);

	n := 0;
err_pos := 1205;
	for w in c1 loop
	  TextData := TextData || to_char(w.last_change_date, 'dd.mm.yy hh24-mi-ss') || ' - ';
	  TextData := TextData || w.lot_id_trak || chr(13);
	  n := n+1;
	end loop;

	if n < 1 then
	  TextData := TextData || '---No data found!' || chr(13);
	end if;

	return TextData;

exception
when others then
	raise;
end GetWafHistDta_ML;
