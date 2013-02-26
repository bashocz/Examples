/******************************************************************************/
-- CSL_2_7_7 - Check state of lot (since Mapper version 2.7.7
/******************************************************************************/
procedure CSL_2_7_7(in_param in varchar2) -- check state of lot
is
	mlot		varchar2(20);
	plot		tmapper_lots.lot%type;
--	pdevice		tmapper_lots.device%type;
	pdevice		varchar2(30);
	pdevicever	tmapper_lots.devicever%type;
	pdeviceStr	varchar2(30);
	ppdpw		vmapper_pdpw.pdpw%type;
	plimit		vmapper_pdpw.limit%type;
	phold       	vmapper_pdpw.limit%type;
	psample		vmapper_pdpw.sample%type;
	pedgeunit  	vmapper_pdpw.sample%type;
	pforceedit  	vmapper_pdpw.sample%type;
	pltosam		vmapper_pdpw.levelToSample%type;
	plfromsam	vmapper_pdpw.levelFromSample%type;
	plfromsam2	vmapper_pdpw.levelFromSample%type;
	wlstate		varchar2(1000);
	wafperlot	varchar2(3);
	wgooddice	varchar2(1000);
	wtestboard	varchar2(2000);
	wproberid	varchar2(2000);
	wtesterid	varchar2(2000);
	wwafers		varchar2(400);
	lscrbs          varchar2(5000); /* assume that max laserscribe length is 100-1 */
	nTemprPar	number;
	nBaseTemprPar	number;
	BaseTemprval	varchar2(32);
	Temprval	varchar2(32);
	TemprType	varchar2(1);

	nSamplPar	number;
	Samplval	varchar2(32);
	SamplType	varchar2(1);
  torr_link	VARCHAR2(256);

	lformat_id	varchar2(20);
	ls_mask		varchar2(100) := 'NO_FORMAT';

	res		varchar2(32767);

	cursor Clot(rlot in varchar2) is -- return wafer specific data like how many times was tested etc.
		select wafer_id,nvl(state,0) state,nvl(samplinginfo,0) samplinfo, nvl(editinfo,0) edtinfo
			from tmapper_wafer w
			where w.lot = rlot
			order by wafer_id;
	ResClot Clot%rowtype;
	cursor Cgooddice(rlot in varchar2) is-- select gooddice count from mapper events table
		select gooddice, wafer_id
		from tmapper_events w
		where w.lot = rlot and message = 'PF' and
			event_id = (
				select max(event_id)
				from tmapper_events w1
				where w1.lot = rlot and w1.message = 'PF' and w1.wafer_id = w.wafer_id)
		order by wafer_id;
	ResCgooddice Cgooddice%rowtype;

	-- FIXME laserscribe ---------------------------------------------------------
	cursor Clscrbs_trak(rlot in varchar2) is-- select laserscribe from
		select wafer_id, laserscribe
		from ml_actual_wafer w
		where w.lot_id_trak = rlot
		order by wafer_id;
	ResLscrbs_trak Clscrbs_trak%rowtype;

    TYPE ref_cursor is REF CURSOR;
    rc ref_cursor;
  
    promis_ls_stmt varchar2(1000);

    ResLscrbs_promis_waferid number;
    ResLscrbs_promis_ls varchar2(5000);

	------------------------------------------------------------------------------

	TYPE WaferTabTyp IS TABLE OF number INDEX BY BINARY_INTEGER;
	wafer_tab	WaferTabTyp;
	sampl_tab	WaferTabTyp;
	edt_tab		WaferTabTyp;
	goodd_tab	WaferTabTyp;
	
	TYPE LscrbsTabTyp IS TABLE OF varchar(99) INDEX BY BINARY_INTEGER;
	lscrbs_tab	LscrbsTabTyp;

	nwafperlot	number;
	i			number;
	result		number;

	pmaverick	varchar2(10);
	nParam		number;
	sParam		varchar2(100);
	monitoring	varchar2(10);
	bWorkInTempr	boolean;
	bUseTrakLot	boolean;
begin
	mlot:=web.Param(in_param,1);

	if ltrim(rtrim(web.Param(in_param,2))) = 'TRUE' then
	  bUseTrakLot:=true;
	else
	  bUseTrakLot:=false;
	end if;

	if ltrim(rtrim(web.Param(in_param,3))) = 'TRUE' then
	  bWorkInTempr:=true;
	else
	  bWorkInTempr:=false;
	end if;

	if not bUseTrakLot then
		mlot:=ltrim(rtrim(mlot)); -- ??? WHY???
	else
		pltosam := null;
		plfromsam := null;
		plfromsam2 := null;
	end if;

	-- change from 5 digits to coplete lotID
	if bUseTrakLot then
    begin
	  	Mprobe.get_lot_device_ml_2(mlot, plot, pdevice, pdevicever, pmaverick,
				ppdpw, plimit, phold, psample, pedgeunit, pforceedit, plfromsam, plfromsam2, lformat_id); -- what device type is given lot ?

		exception
			when NO_DATA_FOUND then
				plot:=null;
				pdevice:=null;
				pdevicever:=null;
		end;

		if(pmaverick = 'Y') then
	 	 	raise MAVERICK;
		end if;

		if(plot is null or pdevice is null or pdevicever is null) then
	 	 raise INV_ARGS;
		end if;
	else
    begin
       Mprobe.get_lot_device2(mlot, plot, pdevice, pdevicever); -- what device type is given lot ?
		exception
			when NO_DATA_FOUND then
				plot:=null;
				pdevice:=null;
				pdevicever:=null;
				raise INV_ARGS;
		end;

		TryGetPDPW(pdevice, pdevicever, ppdpw, plimit, psample, pltosam, plfromsam);

		nParam := get_lot_param(plot, '$DIESHIPPART', sParam, SamplType);
		if(nParam = 0) then
		  nParam := get_part_param(pdevice, pdevicever, '$DIESHIPPART', sParam, SamplType);
		end if;
		if(nParam>0 and sParam='WAFERS') then
		  monitoring := 'M';
		end if;

		nSamplPar := get_lot_param(plot, '$TFPRBCTRL-UNP', SamplVal, SamplType);
		if SamplVal = '1' then
		  psample := '0';
		end if;

		nBaseTemprPar := get_part_param(pdevice, pdevicever, '$ATUNPROBE-T01', BaseTemprVal, TemprType);
		nTemprPar := get_part_param(pdevice, pdevicever, '$ATUNPROBE-T02', TemprVal, TemprType);
	end if;

	-- retrieve number of wafers per lot
	select to_number(ltrim(rtrim(cvalue))) into nwafperlot
		from ENVIRONMENT
		where varname = 'MAPPER_WAF_PER_LOT';
	for i in 1..nwafperlot loop -- fill table with 0
		wafer_tab(i):=0;
		sampl_tab(i):=0;
		edt_tab(i):=0;
		goodd_tab(i):=0; --good dice count
		lscrbs_tab(i):='';
	end loop;

	if (bUseTrakLot) then
		for ResClot in Clot(mlot) loop -- fill appropriate positions in wafer table with sampling info etc.
			wafer_tab(ResClot.wafer_id):=ResClot.state;
			sampl_tab(ResClot.wafer_id):=ResClot.samplinfo;
			edt_tab(ResClot.wafer_id) := ResClot.edtinfo;
		end loop;

		for ResCgooddice in Cgooddice(mlot) loop -- retrieve gooddice count for all wafers in the lot
			goodd_tab(ResCgooddice.wafer_id):=ResCgooddice.gooddice;
		end loop;

		for ResLscrbs_trak in Clscrbs_trak(mlot) loop -- retrieve laserscribes for all wafers in the lot
			lscrbs_tab(ResLscrbs_trak.wafer_id):=ResLscrbs_trak.laserscribe;
		end loop;
	else
		for ResClot in Clot(plot) loop -- fill appropriate positions in wafer table with sampling info etc.
			wafer_tab(ResClot.wafer_id) :=ResClot.state;
			sampl_tab(ResClot.wafer_id) :=ResClot.samplinfo;
			edt_tab(ResClot.wafer_id)   := ResClot.edtinfo;
		end loop;

		for ResCgooddice in Cgooddice(plot) loop -- retrieve gooddice count for all wafers in the lot
			goodd_tab(ResCgooddice.wafer_id):=ResCgooddice.gooddice;
		end loop;
/*
		select cvalue into torr_link
		from ENVIRONMENT
		where upper(varname)='MAPPER_TORR_LINK';
		
    promis_ls_stmt:= 'select TO_NUMBER(SUBSTR(PARMNAME, INSTR(PARMNAME, ''-'', -1)+1 )) as wafer_id, '||
                     'PARMVAL from actllotparmcount@'||torr_link||' w where w.lotid = '''||plot||''' and '||
                     'w.PARMNAME like ''$G-WAFER-%'' order by wafer_id';

		OPEN rc FOR promis_ls_stmt;
    
    LOOP
      FETCH rc INTO ResLscrbs_promis_waferid, ResLscrbs_promis_ls;
      EXIT WHEN rc%NOTFOUND;
      lscrbs_tab(ResLscrbs_promis_waferid):=ResLscrbs_promis_ls;
    END LOOP;*/
	end if;

	wlstate:='';
	wgooddice:='';
	wwafers:='';
	for i in 1..nwafperlot loop -- create comma delimited string with waferstates for output
		wlstate:=wlstate||to_char(wafer_tab(i))||'.'||to_char(sampl_tab(i));
		if bWorkInTempr or bUseTrakLot then
			wlstate:=wlstate||'.'||to_char(edt_tab(i));
		end if;
		wlstate:=wlstate||',';
		wgooddice:=wgooddice||to_char(goodd_tab(i))||',';
		lscrbs:=lscrbs||lscrbs_tab(i)||',';
	end loop;

	begin
		if (bUseTrakLot) then
			result := ask_for_ml_wafers(mlot, wwafers);
		else
			result:=ask_torrent_for_wafers(plot, wwafers);
		end if;
	exception
		when OTHERS then	-- if TORRENT does not work
			for i in 1..50 loop
				wwafers:=wwafers||to_char(i)||',';
			end loop;
			result:=50;
	end;

	if result<0 then
	  result:=0;
	  raise NO_WFRS;
	end if;


	-- change from 5 digits to coplete lotID
	if substr(pdevicever, 1, 1)='.' then
		pdeviceStr:=pdevice||pdevicever;
	else
		pdeviceStr:=pdevice||'.'||pdevicever;
	end if;

	-- result creating -----------------------------------------------------------
	res := '';

	if bUseTrakLot then
		res := res||plot||web.delimiter;
	end if;

	res := res||pdeviceStr||web.delimiter||
			to_char(ppdpw)||web.delimiter||
			to_char(plimit)||web.delimiter;
	if bUseTrakLot then
		res := res||to_char(phold)||web.delimiter;
	end if;

	res := res||psample||web.delimiter;

	if bUseTrakLot then
		res := res||pedgeunit||web.delimiter||pforceedit||web.delimiter;
	end if;

	res := res||to_char(pltosam)||web.delimiter||
		to_char(plfromsam)||web.delimiter;

	if bUseTrakLot then
		res := res||to_char(plfromsam2)||web.delimiter;
	end if;

	if bUseTrakLot or bWorkInTempr then
		res := res||BaseTemprVal||web.delimiter||
			TemprVal||web.delimiter;
	end if;

	if bWorkInTempr and (not bUseTrakLot) then
		res := res||monitoring||web.delimiter;
	end if;

	res := res||wlstate||web.delimiter||
		wgooddice||web.delimiter||
		to_char(result)||web.delimiter||
		wwafers||web.delimiter;

		res := res||lscrbs||web.delimiter;
	------------------------------------------------------------------------------

	web.MODUL_OUT := res;

exception
	when INV_ARGS then
		err:=SQLCODE;
		if bUseTrakLot then
			web.MODUL_OUT := 'Not Found'||web.delimiter||in_param||
			'plot='||plot||', pdevice='||pdevice||', '||pdevicever||web.delimiter;
		else
			web.MODUL_OUT := 'Not Found'||web.delimiter;
		end if;
	when MAVERICK then
		web.MODUL_OUT := 'E'||web.delimiter||'The lot is MAVERICK'||web.delimiter;
	when NO_WFRS then
		err:=SQLCODE;
		web.MODUL_OUT := 'No wafers'||web.delimiter;
	when OTHERS then
		err := SQLCODE;
--		web.MODUL_OUT := 'ERR'||to_char(err)||web.delimiter;
--		web.MODUL_OUT := '<ERROR>INVALID ARGUMENTS'||web.delimiter;
--		web.MODUL_OUT := 'E'||web.delimiter;
		web.MODUL_OUT := 'E'||web.delimiter||to_char(err)||web.delimiter||SQLERRM||web.delimiter;
end CSL_2_7_7;
