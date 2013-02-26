set feedback on

create or replace package TIS
as

function nova_zakazka(p_zakaznik_id in TIS_ZAKAZNIK.zakaznik_id%type)
                      return TIS_ZAKAZKA.zakazka_id%type;
					  
procedure potvrzeni_zakazka(p_zakazka_id in TIS_ZAKAZKA.zakazka_id%type);

procedure storno_zakazka(p_zakazka_id in TIS_ZAKAZKA.zakazka_id%type);

procedure odesli_zakazku(p_zakazka_id in TIS_ZAKAZKA.zakazka_id%type);

function vyroba_start(p_vyrobni_linka_id in TIS_VYROBNI_LINKA.vyrobni_linka_id%type)
                      return TIS_PLAN.plan_id%type;

procedure vyroba_konec(p_vyrobni_linka_id in TIS_VYROBNI_LINKA.vyrobni_linka_id%type);

end;
/
create or replace package body TIS
as

procedure je_zakazka_kompletni(p_zakazka_id in TIS_ZAKAZKA.zakazka_id%type) is

	cursor c_polozky(cp_zakazka_id in TIS_ZAKAZKA.zakazka_id%type) is
		select * from TIS_POLOZKA p
			where p.zakazka_id = cp_zakazka_id;
	v_polozka c_polozky%rowtype;

  v_sklad_pocet number;
  je_skladem boolean;

begin
  je_skladem := true;
  
	for v_polozka in c_polozky(p_zakazka_id) loop
    select count(*) into v_sklad_pocet from TIS_SKLAD s
      where s.vyrobek_id = v_polozka.vyrobek_id and
            s.zakazka_id = p_zakazka_id;
    
    if v_sklad_pocet > 0 then
      select s.pocet into v_sklad_pocet from TIS_SKLAD s
        where s.vyrobek_id = v_polozka.vyrobek_id and
              s.zakazka_id = p_zakazka_id;
      if v_polozka.pocet > v_sklad_pocet then
        je_skladem := false;
      end if;
    else
      je_skladem := false;
    end if;
  end loop;

  if je_skladem then
    update TIS_ZAKAZKA z
      set z.stav = 'Skladem'
      where z.zakazka_id = p_zakazka_id;
  end if;  
end je_zakazka_kompletni;

function rezervuj_sklad(p_vyrobek_id in TIS_VYROBEK.vyrobek_id%type,
                        p_zakazka_id in TIS_ZAKAZKA.zakazka_id%type,
                        p_pocet in TIS_SKLAD.pocet%type)
                        return TIS_SKLAD.pocet%type is

  v_sklad_pocet number;
  v_sklad TIS_SKLAD%rowtype;
  v_sklad_rezervace TIS_SKLAD.pocet%type;
  
  v_pocet TIS_SKLAD.pocet%type;
  
begin
  -- konec procedury - spatny vstup
  if p_pocet < 1 then
    return 0;
  end if;
  v_pocet := p_pocet;
	
  -- existuji skladove zasoby vyrobku
  select count(*) into v_sklad_pocet from TIS_SKLAD s
    where s.vyrobek_id = p_vyrobek_id and
          s.zakazka_id is null;
  
  if v_sklad_pocet > 0 then
    select * into v_sklad from TIS_SKLAD s
      where s.vyrobek_id = p_vyrobek_id and
            s.zakazka_id is null;
	  
    if v_sklad.pocet > p_pocet then
      -- updatuj zaznam o stavu volnych skladovych zasob vyrobku
      update TIS_SKLAD s
        set s.pocet = (s.pocet - p_pocet)
        where s.vyrobek_id = p_vyrobek_id and s.zakazka_id is null;
	  
      v_sklad_rezervace := p_pocet;
      v_pocet := 0;
    else
      -- smaz zaznam o volnych skladovych zasob vyrobku
      v_sklad_rezervace := v_sklad.pocet;
      v_pocet := p_pocet - v_sklad_rezervace;
	  
      delete from TIS_SKLAD s
        where s.vyrobek_id = p_vyrobek_id and s.zakazka_id is null;
    end if;
  
    -- existuji skladove zasoby vyrobku pro zakazku?
    select count(*) into v_sklad_pocet from TIS_SKLAD s
      where s.vyrobek_id = p_vyrobek_id and s.zakazka_id = p_zakazka_id;
  
    if v_sklad_pocet > 0 then
      -- updatuj zaznam o stavu skladovych zasob vyrobku pro zakazku
      update TIS_SKLAD s
        set s.pocet = (s.pocet + v_sklad_rezervace)
        where s.vyrobek_id = p_vyrobek_id and s.zakazka_id = p_zakazka_id;
    else
      -- vytvor zaznam o skladovych zasobach vyrobku pro zakazku
      insert into TIS_SKLAD(vyrobek_id, zakazka_id, pocet)
        values(p_vyrobek_id, p_zakazka_id, v_sklad_rezervace);
    end if;
  end if; -- rezervace skladu

  return v_pocet;

exception
  when OTHERS then
    raise;
end rezervuj_sklad;
  
procedure vytvor_plan(p_vyrobek_id in TIS_VYROBEK.vyrobek_id%type,
                      p_zakazka_id in TIS_ZAKAZKA.zakazka_id%type,
                      p_pocet in TIS_SKLAD.pocet%type) is
  
  cursor c_vyrobni_linky is
    select * from TIS_VYROBNI_LINKA where aktivni = 1 order by kapacita desc;
  v_vyrobni_linka c_vyrobni_linky%rowtype;
  v_plan_pocet TIS_PLAN.pocet%type;
  
  v_pocet number;
  
begin
  -- konec procedury - spatny vstup
  if p_pocet < 1 then
    return;
  end if;
  v_pocet := p_pocet;
	
  -- zde by urcite slo vymyslet vynikajici algoritmus, ktery by inteligentne rozdeloval plan
  -- mezi jednotlive vyrobni linky, podle kapacity a vykonnosti, aby jejich vytizeni bylo optimalni
  -- to si vsak autor nekladl za cil a tak je zde pouze "jednoduche planovani" ...
  while v_pocet > 0
  loop
    for v_vyrobni_linka in c_vyrobni_linky
    loop
      if v_pocet > 0 then
        if v_pocet > v_vyrobni_linka.kapacita then
          v_plan_pocet := v_vyrobni_linka.kapacita;
          v_pocet := v_pocet - v_vyrobni_linka.kapacita;
        else
          v_plan_pocet := v_pocet;
          v_pocet := 0;
        end if;
        -- vloz jeden plan
        insert into TIS_PLAN(vyrobek_id, zakazka_id, datum_vytvoreni, pocet, stav)
          values(p_vyrobek_id, p_zakazka_id, SYSDATE, v_plan_pocet, 'Naplanovano');
      end if;
    end loop;
  end loop;

exception
  when OTHERS then
    raise;
end vytvor_plan;

function nova_zakazka(p_zakaznik_id in TIS_ZAKAZNIK.zakaznik_id%type)
                      return TIS_ZAKAZKA.zakazka_id%type is

  v_zakazka_pocet number;
  v_zakazka_id TIS_ZAKAZKA.zakazka_id%type;

begin
  v_zakazka_id := 0;
  -- je nejaka zakazka?
  select count(*) into v_zakazka_pocet from TIS_ZAKAZKA z
    where z.zakaznik_id = p_zakaznik_id and z.stav = 'Nova';
  
  if v_zakazka_pocet > 0 then
    select z.zakazka_id into v_zakazka_id from TIS_ZAKAZKA z
      where z.zakaznik_id = p_zakaznik_id and z.stav = 'Nova';
  else
    select SEQ_TIS_ZAKAZKA_ID.nextval into v_zakazka_id from DUAL;
  
    insert into TIS_ZAKAZKA(zakazka_id, zakaznik_id, datum_objednavky, stav)
      values(v_zakazka_id, p_zakaznik_id, SYSDATE, 'Nova');  
  
    commit;
  end if;
  
  return v_zakazka_id;
  
exception
  when OTHERS then
    rollback;
    raise;
end nova_zakazka;

procedure potvrzeni_zakazka(p_zakazka_id in TIS_ZAKAZKA.zakazka_id%type) is

  v_zakazka_pocet number;
  v_vyrobek_id TIS_VYROBEK.vyrobek_id%type;
  v_plan_pocet TIS_SKLAD.pocet%type;
  
	cursor c_polozka(cp_zakazka_id in TIS_ZAKAZKA.zakazka_id%type) is
		select * from TIS_POLOZKA p
			where p.zakazka_id = cp_zakazka_id;
	v_polozka c_polozka%rowtype;
  
begin
  -- je nejaka zakazka?
  select count(*) into v_zakazka_pocet from TIS_ZAKAZKA z
    where z.zakazka_id = p_zakazka_id and z.stav = 'Nova';
  
  if v_zakazka_pocet = 0 then
    return;
  end if;
 
  -- zrus zakazku u vsech planu, ktere se vyrabi
  update TIS_ZAKAZKA z
    set z.stav = 'Vyrabi se'
    where z.zakazka_id = p_zakazka_id;
dbms_output.put_line('p_zakazka_id = ' || p_zakazka_id);  
  -- polozky zakazky
	for v_polozka in c_polozka(p_zakazka_id) loop
    -- rezervace na sklade
    v_plan_pocet := rezervuj_sklad(v_polozka.vyrobek_id, p_zakazka_id, v_polozka.pocet); 
    -- vytvoreni planu
    vytvor_plan(v_polozka.vyrobek_id, p_zakazka_id, v_plan_pocet);
  end loop;
  
  je_zakazka_kompletni(p_zakazka_id);
 
  commit;

exception
  when OTHERS then
    rollback;
    raise;
end potvrzeni_zakazka;

procedure storno_zakazka(p_zakazka_id in TIS_ZAKAZKA.zakazka_id%type) is

  v_sklad_pocet number;

	cursor c_sklad(cp_zakazka_id in TIS_ZAKAZKA.zakazka_id%type) is
		select * from TIS_SKLAD s
			where s.zakazka_id = cp_zakazka_id;
	v_sklad_polozka c_sklad%rowtype;
  
begin
  -- smaz vsechny plany pro zakazku, ktere se jeste nezacaly vyrabet
  delete from TIS_PLAN p
    where p.zakazka_id = p_zakazka_id and
          p.stav = 'Naplanovano';
  -- zrus zakazku u vsech planu, ktere se vyrabi
  update TIS_PLAN p
    set p.zakazka_id = null
    where p.zakazka_id = p_zakazka_id and
          p.stav <> 'Naplanovano';
  
  -- jsou nejake skladove zasoby pro zakazku?
  select count(*) into v_sklad_pocet from TIS_SKLAD s
    where s.zakazka_id = p_zakazka_id;
 
  if v_sklad_pocet > 0 then
    -- pro vsechny skladove zasoby pro zakazku
		for v_sklad_polozka in c_sklad(p_zakazka_id) loop
      -- jsou nejake volne skladove zasoby vyrobku?
      select count(*) into v_sklad_pocet from TIS_SKLAD s
        where s.vyrobek_id = v_sklad_polozka.vyrobek_id and
              s.zakazka_id = null;
   
      if v_sklad_pocet > 0 then
        -- zvys pocet volnych skladovych zasob
        update TIS_SKLAD s
          set s.pocet = (s.pocet + v_sklad_polozka.pocet)
          where s.vyrobek_id = v_sklad_polozka.vyrobek_id and
                s.zakazka_id = null;
        -- smaz skladove zasovy pro zakazku
        delete from TIS_SKLAD s
          where s.vyrobek_id = v_sklad_polozka.vyrobek_id and
                s.zakazka_id = v_sklad_polozka.zakazka_id;
      else
        -- zmen skladove zasoby pro zakazku na volne skladove zasoby
        update TIS_SKLAD s
          set s.zakazka_id = null
          where s.vyrobek_id = v_sklad_polozka.vyrobek_id and
                s.zakazka_id = p_zakazka_id;
        
      end if;
    end loop;
  end if;
  
  -- smaz polozky zakazky
  delete from TIS_POLOZKA p
    where p.zakazka_id = p_zakazka_id;

  -- smaz zakazku
  delete from TIS_ZAKAZKA z
    where z.zakazka_id = p_zakazka_id;

  commit;
  
exception
  when OTHERS then
    rollback;
    raise;
end storno_zakazka;

function je_skladem(p_zakazka_id in TIS_ZAKAZKA.zakazka_id%type)
                    return boolean is
  
  v_zakazka TIS_ZAKAZKA%rowtype;
  
begin
  
  select * into v_zakazka from TIS_ZAKAZKA z
    where z.zakazka_id = p_zakazka_id;
    
  return v_zakazka.stav = 'Skladem';
  
exception
  when OTHERS then
    rollback;
    raise;
end;

procedure odesli_zakazku(p_zakazka_id TIS_ZAKAZKA.zakazka_id%type) is

begin
  if je_skladem(p_zakazka_id) then
    -- updatuj zakazku
    update TIS_ZAKAZKA z
      set z.stav = 'Odeslano'
      where z.zakazka_id = p_zakazka_id;
    
    -- smaz skladove zasoby
    delete from TIS_SKLAD s
      where s.zakazka_id = p_zakazka_id;
  end if;
  
  commit;
  
exception
  when OTHERS then
    rollback;
    raise;
end odesli_zakazku;

function aktivni(p_vyrobni_linka_id in TIS_VYROBNI_LINKA.vyrobni_linka_id%type)
                 return boolean is

  v_vyrobni_linka_pocet number;
                
begin
  select count(*) into v_vyrobni_linka_pocet from TIS_VYROBNI_LINKA v
    where v.aktivni = 1 and
	        v.vyrobni_linka_id = p_vyrobni_linka_id;
  if v_vyrobni_linka_pocet > 0 then
    return true;
  end if;
  return false;
end aktivni;

function vyrabi(p_vyrobni_linka_id in TIS_VYROBNI_LINKA.vyrobni_linka_id%type)
                return boolean is

  v_plan_pocet number;
                
begin
  select count(*) into v_plan_pocet from TIS_PLAN p
    where p.stav = 'Vyrabi se' and
	        p.vyrobni_linka_id = p_vyrobni_linka_id;
  if v_plan_pocet > 0 then
    return true;
  end if;
  return false;
end vyrabi;

function vyroba_start(p_vyrobni_linka_id in TIS_VYROBNI_LINKA.vyrobni_linka_id%type)
                      return TIS_PLAN.plan_id%type is

  v_kapacita TIS_VYROBNI_LINKA.kapacita%type;

  v_plan_pocet number;
  v_plan_id TIS_PLAN.plan_id%type;
  
  v_plan_existuje boolean;
  
begin
  -- aktivni || vyrabi?
  if (not aktivni(p_vyrobni_linka_id)) or vyrabi(p_vyrobni_linka_id) then
    return null;
  end if;
  
  -- kapacita vyrobni linky
  select v.kapacita into v_kapacita from TIS_VYROBNI_LINKA v
    where v.vyrobni_linka_id = p_vyrobni_linka_id;

  --vyber "nejdulezitejsi, nejefektivnejsi, nejidealnejsi" vyrobek k vyrobe pro tuto linku
  v_plan_existuje := false;
  
  -- existuje nejaky plan pro konkretni vyrobni linku?
  select count(*) into v_plan_pocet from TIS_PLAN p
    where p.stav = 'Naplanovano'and
          p.vyrobni_linka_id = p_vyrobni_linka_id and
          p.pocet <= v_kapacita;

  if v_plan_pocet > 0 then
    select plan_id into v_plan_id from
      (select p.plan_id from TIS_PLAN p
          where p.stav = 'Naplanovano' and
                p.vyrobni_linka_id = p_vyrobni_linka_id and
                p.pocet <= v_kapacita
          order by p.pocet desc, p.datum_vytvoreni asc
      )
      where rownum = 1;

	  update TIS_PLAN p
      set p.datum_vyroba_start = SYSDATE, 
          p.stav = 'Vyrabi se'
	    where p.plan_id = v_plan_id;
	  
	  v_plan_existuje := true;
  else
    -- existuje nejaky plan pro libovolnou vyrobni linku?
    select count(*) into v_plan_pocet from TIS_PLAN p
      where p.stav = 'Naplanovano'and
            p.vyrobni_linka_id is null and
            p.pocet <= v_kapacita order by p.pocet desc, p.datum_vytvoreni asc;

    if v_plan_pocet > 0 then
      select plan_id into v_plan_id from
        (select * from TIS_PLAN p
           where p.stav = 'Naplanovano' and
                 p.vyrobni_linka_id is null and
                 p.pocet <= v_kapacita
  	       order by p.pocet desc, p.datum_vytvoreni asc
        )
        where rownum = 1;

      update TIS_PLAN p
        set p.vyrobni_linka_id = p_vyrobni_linka_id,
            p.datum_vyroba_start = SYSDATE,
            p.stav = 'Vyrabi se'
        where p.plan_id = v_plan_id;
	  
      v_plan_existuje := true;
    end if;
  end if;

  commit;

  if v_plan_existuje then
    return v_plan_id;
  end if;
  
  return null;
  
exception 
  when OTHERS then
    rollback;
    raise;
end vyroba_start;

procedure vyroba_konec(p_vyrobni_linka_id in TIS_VYROBNI_LINKA.vyrobni_linka_id%type) is

  v_plan_pocet number;
  v_plan TIS_PLAN%rowtype;
  
  v_vyrobek_cas TIS_VYROBEK.narocnost%type;
  v_sklad_pocet number;
  
begin
  -- aktivni || vyrabi?
  if (not aktivni(p_vyrobni_linka_id)) or (not vyrabi(p_vyrobni_linka_id)) then
    return;
  end if;

  --uz ma vyrobeno
  select * into v_plan from TIS_PLAN p
    where p.stav = 'Vyrabi se' and
	        p.vyrobni_linka_id = p_vyrobni_linka_id;
          
  update TIS_PLAN p
    set p.datum_vyroba_konec = SYSDATE,
        p.stav = 'Vyrobeno'
    where p.plan_id = v_plan.plan_id;

  -- vykonnost statistika
  select v.narocnost into v_vyrobek_cas from TIS_VYROBEK v
    where v.vyrobek_id = v_plan.vyrobek_id;

  --prevede na sklad, pripadne priradi zakazce
  select count(*) into v_sklad_pocet from TIS_SKLAD s
    where s.vyrobek_id = v_plan.vyrobek_id and
          s.zakazka_id = v_plan.zakazka_id;
       
  if v_sklad_pocet > 0 then
    update TIS_SKLAD s
	    set s.pocet = (s.pocet + v_plan.pocet)
	    where s.vyrobek_id = v_plan.vyrobek_id and
            s.zakazka_id = v_plan.zakazka_id;
  else
    insert into TIS_SKLAD(vyrobek_id, zakazka_id, pocet)
	    values(v_plan.vyrobek_id, v_plan.zakazka_id, v_plan.pocet);
  end if;
      
  je_zakazka_kompletni(v_plan.zakazka_id);
   
  commit;

exception
  when OTHERS then
    rollback;
    raise;
end vyroba_konec;

end;
