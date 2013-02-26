declare
  privilege_id number;
begin
  -- privileges 
  select seq_tmapper_privilege_id.nextval into privilege_id from dual;
  insert into TMAPPER_PRIVILEGES(id, name, description) 
    values (privilege_id, 'VIEWLOG', 'Allows to view log file');

  select seq_tmapper_privilege_id.nextval into privilege_id from dual;
  insert into TMAPPER_PRIVILEGES(id, name, description) 
    values (privilege_id, 'CHECKIN', 'Allows to do check in');

  select seq_tmapper_privilege_id.nextval into privilege_id from dual;
  insert into TMAPPER_PRIVILEGES(id, name, description) 
    values (privilege_id, 'PROBE', 'Allows to do probe process');        

  select seq_tmapper_privilege_id.nextval into privilege_id from dual;
  insert into TMAPPER_PRIVILEGES(id, name, description) 
    values (privilege_id, 'REPROBE', 'Allows to do reprobe process');        

  select seq_tmapper_privilege_id.nextval into privilege_id from dual;
  insert into TMAPPER_PRIVILEGES(id, name, description) 
    values (privilege_id, 'INK', 'Allows to do ink process');        

  select seq_tmapper_privilege_id.nextval into privilege_id from dual;
  insert into TMAPPER_PRIVILEGES(id, name, description) 
    values (privilege_id, 'PAUSE', 'Allows to pause process');

  select seq_tmapper_privilege_id.nextval into privilege_id from dual;
  insert into TMAPPER_PRIVILEGES(id, name, description) 
    values (privilege_id, 'STOP', 'Allows to stop process');

  select seq_tmapper_privilege_id.nextval into privilege_id from dual;
  insert into TMAPPER_PRIVILEGES(id, name, description) 
    values (privilege_id, 'REPROBESELECTED', 'Allows to reprobe selected die during pause');

  select seq_tmapper_privilege_id.nextval into privilege_id from dual;
  insert into TMAPPER_PRIVILEGES(id, name, description) 
    values (privilege_id, 'REPROBESPECIFIED', 'Allows to reprobe specified dice during pause');

  select seq_tmapper_privilege_id.nextval into privilege_id from dual;
  insert into TMAPPER_PRIVILEGES(id, name, description) 
    values (privilege_id, 'REPROBEFROMPOSITION', 'Allows to reprobe dice from position during pause');

  select seq_tmapper_privilege_id.nextval into privilege_id from dual;
  insert into TMAPPER_PRIVILEGES(id, name, description) 
    values (privilege_id, 'REPROBEWAFER', 'Allows to reprobe whole wafer during pause');

  select seq_tmapper_privilege_id.nextval into privilege_id from dual;
  insert into TMAPPER_PRIVILEGES(id, name, description) 
    values (privilege_id, 'CANDISABLEAUTOMATIONS', 'Allows to disable mapper automations');

  select seq_tmapper_privilege_id.nextval into privilege_id from dual;
  insert into TMAPPER_PRIVILEGES(id, name, description) 
    values (privilege_id, 'LOADPARTIALMAP', 'Allows to load partial maps');

  select seq_tmapper_privilege_id.nextval into privilege_id from dual;
  insert into TMAPPER_PRIVILEGES(id, name, description) 
    values (privilege_id, 'SAVEPARTIALMAP', 'Allows to save partial maps');

  select seq_tmapper_privilege_id.nextval into privilege_id from dual;
  insert into TMAPPER_PRIVILEGES(id, name, description) 
    values (privilege_id, 'CONTROLDIALOG', 'Allows to open control dialog');

  select seq_tmapper_privilege_id.nextval into privilege_id from dual;
  insert into TMAPPER_PRIVILEGES(id, name, description) 
    values (privilege_id, 'CANCHANGEALLOPTIONS', 'Allows to change all setting in option dialog');

  select seq_tmapper_privilege_id.nextval into privilege_id from dual;
  insert into TMAPPER_PRIVILEGES(id, name, description) 
    values (privilege_id, 'CANCHANGEBASICOPTIONS', 'Allows to change basic setting in option dialog');

  select seq_tmapper_privilege_id.nextval into privilege_id from dual;
  insert into TMAPPER_PRIVILEGES(id, name, description) 
    values (privilege_id, 'CANCHANGEDIROPTIONS', 'Allows to change directory/wafer map setting in option dialog');

  select seq_tmapper_privilege_id.nextval into privilege_id from dual;
  insert into TMAPPER_PRIVILEGES(id, name, description) 
    values (privilege_id, 'CANCHANGEPROCESSMETHODOPTIONS', 'Allows to change process method setting in option dialog');

  select seq_tmapper_privilege_id.nextval into privilege_id from dual;
  insert into TMAPPER_PRIVILEGES(id, name, description) 
    values (privilege_id, 'CANCHANGEDBOPTIONS', 'Allows to change database setting in option dialog');

  select seq_tmapper_privilege_id.nextval into privilege_id from dual;
  insert into TMAPPER_PRIVILEGES(id, name, description) 
    values (privilege_id, 'CANCHANGENEWTONOPTIONS', 'Allows to change newton setting in option dialog');

  select seq_tmapper_privilege_id.nextval into privilege_id from dual;
  insert into TMAPPER_PRIVILEGES(id, name, description) 
    values (privilege_id, 'CANCHANGEAUTOMATIONOPTIONS', 'Allows to change automation setting in option dialog');

  select seq_tmapper_privilege_id.nextval into privilege_id from dual;
  insert into TMAPPER_PRIVILEGES(id, name, description) 
    values (privilege_id, 'CANCHANGEPROBERID', 'Allows to change prober ID in option dialog');

  select seq_tmapper_privilege_id.nextval into privilege_id from dual;
  insert into TMAPPER_PRIVILEGES(id, name, description) 
    values (privilege_id, 'CANCHANGEPROBEROPTIONS', 'Allows to change prober setting in option dialog');

  select seq_tmapper_privilege_id.nextval into privilege_id from dual;
  insert into TMAPPER_PRIVILEGES(id, name, description) 
    values (privilege_id, 'CANCHANGETESTERID', 'Allows to change tester ID in option dialog');

  select seq_tmapper_privilege_id.nextval into privilege_id from dual;
  insert into TMAPPER_PRIVILEGES(id, name, description) 
    values (privilege_id, 'CANCHANGETESTEROPTIONS', 'Allows to change tester setting in option dialog');
	
  -- commit 
  commit;
end;
/