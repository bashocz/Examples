declare
  role_id number;
  privilege_id number;
begin
  -- roles 
  select seq_tmapper_role_id.nextval into role_id from dual;
  insert into TMAPPER_ROLES(id, name, description) 
    values (role_id, 'ADMINISTRATOR', 'Role for administrators/developers');
      
  -- role privileges
  select id into privilege_id from tmapper_privileges where name = 'VIEWLOG';
  insert into TMAPPER_ROLE_PRIVILEGES(ID_ROLE, ID_PRIVILEGE) 
    values (role_id, privilege_id);
  
  select id into privilege_id from tmapper_privileges where name = 'CHECKIN';
  insert into TMAPPER_ROLE_PRIVILEGES(ID_ROLE, ID_PRIVILEGE) 
    values (role_id, privilege_id);
  
  select id into privilege_id from tmapper_privileges where name = 'PROBE';
  insert into TMAPPER_ROLE_PRIVILEGES(ID_ROLE, ID_PRIVILEGE) 
    values (role_id, privilege_id);
  
  select id into privilege_id from tmapper_privileges where name = 'REPROBE';
  insert into TMAPPER_ROLE_PRIVILEGES(ID_ROLE, ID_PRIVILEGE) 
    values (role_id, privilege_id);
  
  select id into privilege_id from tmapper_privileges where name = 'INK';
  insert into TMAPPER_ROLE_PRIVILEGES(ID_ROLE, ID_PRIVILEGE) 
    values (role_id, privilege_id);
  
  select id into privilege_id from tmapper_privileges where name = 'PAUSE';
  insert into TMAPPER_ROLE_PRIVILEGES(ID_ROLE, ID_PRIVILEGE) 
    values (role_id, privilege_id);
  
  select id into privilege_id from tmapper_privileges where name = 'STOP';
  insert into TMAPPER_ROLE_PRIVILEGES(ID_ROLE, ID_PRIVILEGE) 
    values (role_id, privilege_id);
  
  select id into privilege_id from tmapper_privileges where name = 'REPROBESELECTED';
  insert into TMAPPER_ROLE_PRIVILEGES(ID_ROLE, ID_PRIVILEGE) 
    values (role_id, privilege_id);
  
  select id into privilege_id from tmapper_privileges where name = 'REPROBESPECIFIED';
  insert into TMAPPER_ROLE_PRIVILEGES(ID_ROLE, ID_PRIVILEGE) 
    values (role_id, privilege_id);
  
  select id into privilege_id from tmapper_privileges where name = 'REPROBEFROMPOSITION';
  insert into TMAPPER_ROLE_PRIVILEGES(ID_ROLE, ID_PRIVILEGE) 
    values (role_id, privilege_id);
  
  select id into privilege_id from tmapper_privileges where name = 'REPROBEWAFER';
  insert into TMAPPER_ROLE_PRIVILEGES(ID_ROLE, ID_PRIVILEGE) 
    values (role_id, privilege_id);
  
  select id into privilege_id from tmapper_privileges where name = 'CANDISABLEAUTOMATIONS';
  insert into TMAPPER_ROLE_PRIVILEGES(ID_ROLE, ID_PRIVILEGE) 
    values (role_id, privilege_id);
  
  select id into privilege_id from tmapper_privileges where name = 'LOADPARTIALMAP';
  insert into TMAPPER_ROLE_PRIVILEGES(ID_ROLE, ID_PRIVILEGE) 
    values (role_id, privilege_id);
  
  select id into privilege_id from tmapper_privileges where name = 'SAVEPARTIALMAP';
  insert into TMAPPER_ROLE_PRIVILEGES(ID_ROLE, ID_PRIVILEGE) 
    values (role_id, privilege_id);
  
  select id into privilege_id from tmapper_privileges where name = 'CONTROLDIALOG';
  insert into TMAPPER_ROLE_PRIVILEGES(ID_ROLE, ID_PRIVILEGE) 
    values (role_id, privilege_id);
  
  select id into privilege_id from tmapper_privileges where name = 'CANCHANGEALLOPTIONS';
  insert into TMAPPER_ROLE_PRIVILEGES(ID_ROLE, ID_PRIVILEGE) 
    values (role_id, privilege_id);
  
--  select id into privilege_id from tmapper_privileges where name = 'CANCHANGEBASICOPTIONS';
--  insert into TMAPPER_ROLE_PRIVILEGES(ID_ROLE, ID_PRIVILEGE) 
--    values (role_id, privilege_id);
  
--  select id into privilege_id from tmapper_privileges where name = 'CANCHANGEDIROPTIONS';
--  insert into TMAPPER_ROLE_PRIVILEGES(ID_ROLE, ID_PRIVILEGE) 
--    values (role_id, privilege_id);
  
--  select id into privilege_id from tmapper_privileges where name = 'CANCHANGEPROCESSMETHODOPTIONS';
--  insert into TMAPPER_ROLE_PRIVILEGES(ID_ROLE, ID_PRIVILEGE) 
--    values (role_id, privilege_id);
  
--  select id into privilege_id from tmapper_privileges where name = 'CANCHANGEDBOPTIONS';
--  insert into TMAPPER_ROLE_PRIVILEGES(ID_ROLE, ID_PRIVILEGE) 
--    values (role_id, privilege_id);
  
--  select id into privilege_id from tmapper_privileges where name = 'CANCHANGENEWTONOPTIONS';
--  insert into TMAPPER_ROLE_PRIVILEGES(ID_ROLE, ID_PRIVILEGE) 
--    values (role_id, privilege_id);
  
--  select id into privilege_id from tmapper_privileges where name = 'CANCHANGEAUTOMATIONOPTIONS';
--  insert into TMAPPER_ROLE_PRIVILEGES(ID_ROLE, ID_PRIVILEGE) 
--    values (role_id, privilege_id);
  
--  select id into privilege_id from tmapper_privileges where name = 'CANCHANGEPROBERID';
--  insert into TMAPPER_ROLE_PRIVILEGES(ID_ROLE, ID_PRIVILEGE) 
--    values (role_id, privilege_id);
  
--  select id into privilege_id from tmapper_privileges where name = 'CANCHANGEPROBEROPTIONS';
--  insert into TMAPPER_ROLE_PRIVILEGES(ID_ROLE, ID_PRIVILEGE) 
--    values (role_id, privilege_id);
  
--  select id into privilege_id from tmapper_privileges where name = 'CANCHANGETESTERID';
--  insert into TMAPPER_ROLE_PRIVILEGES(ID_ROLE, ID_PRIVILEGE) 
--    values (role_id, privilege_id);
  
--  select id into privilege_id from tmapper_privileges where name = 'CANCHANGETESTEROPTIONS';
--  insert into TMAPPER_ROLE_PRIVILEGES(ID_ROLE, ID_PRIVILEGE) 
--    values (role_id, privilege_id);
	
  -- commit 
  commit;
end;
/