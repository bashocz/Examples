declare
 user_id number;
 role_id number;
begin
  -- users, user roles
  
  select seq_tmapper_user_id.nextval into user_id from dual;
  insert into TMAPPER_USERS(id, on_user_id, full_name, description) 
    values (user_id, 'ffvtbn', 'Petr Baros', 'developer');

  select id into role_id from tmapper_roles where name = 'ADMINISTRATOR';
  insert into TMAPPER_USER_ROLES(ID_USER, ID_ROLE) 
    values (user_id, role_id);

  select seq_tmapper_user_id.nextval into user_id from dual;
  insert into TMAPPER_USERS(id, on_user_id, full_name, description) 
    values (user_id, 'ffmqzt', 'Vit Matejka', 'developer');

  select id into role_id from tmapper_roles where name = 'ADMINISTRATOR';
  insert into TMAPPER_USER_ROLES(ID_USER, ID_ROLE) 
    values (user_id, role_id);

  select seq_tmapper_user_id.nextval into user_id from dual;
  insert into TMAPPER_USERS(id, on_user_id, full_name, description) 
    values (user_id, 'fftpdj', 'Pavol Melicharek', 'developer');

  select id into role_id from tmapper_roles where name = 'ADMINISTRATOR';
  insert into TMAPPER_USER_ROLES(ID_USER, ID_ROLE) 
    values (user_id, role_id);

  select seq_tmapper_user_id.nextval into user_id from dual;
  insert into TMAPPER_USERS(id, on_user_id, full_name, description) 
    values (user_id, 'fftbpy', 'Stanislav Poboril', 'developer');

  select id into role_id from tmapper_roles where name = 'ADMINISTRATOR';
  insert into TMAPPER_USER_ROLES(ID_USER, ID_ROLE) 
    values (user_id, role_id);
            	
  -- commit 
  commit;
end;
/