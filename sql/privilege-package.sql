set feedback off

create or replace package PRIVILEGE
as

function get_privilege(user_id in varchar2) return varchar2;

end;
/
show errors;


create or replace package body PRIVILEGE
as

function get_privilege(user_id in varchar2) return varchar2 is
	privileges varchar2(32000) := null;
	cursor priv(on_user varchar2) is
		select u.id user_id, u.on_user_id on_user_id, u.full_name user_full_name, u.description user_desc, 
				r.id role_id, r.name role_name, r.description role_desc, 
				p.id priv_id, p.name priv_name, p.description priv_desc
			from tmapper_users u, tmapper_user_roles ur, tmapper_roles r, tmapper_role_privileges rp, tmapper_privileges p
			where u.on_user_id = on_user
			  and u.id = ur.id_user
			  and r.id = ur.id_role
			  and r.id = rp.id_role
			  and p.id = rp.id_privilege;
begin
	if user_id is null then 
		raise_application_error(-20100, 'ERR - function get_privilege, parameter user_id can not be NULL');
	end if;
	-- TODO: select privileges from database using cursor, then go through cursor and for each record 
	--  read privilege and put it into result string (devided by ":")
	--  Shouldn't it return some default privileges if user doesn't exists in tmapper_user table?
	-- privileges := 'CHECKIN:PROBE';
	for prv in priv(user_id) loop
		if (length(privileges) + length(prv.priv_name) + 1) > 32000 then
			exit;
		else
			if length(privileges) > 0 then 
				privileges := privileges || ':';
			end if;
			privileges := privileges || prv.priv_name;
		end if;
	end loop;
	return privileges;
end;

end;
/
show errors;

set feedback on

-- create public synonym PRIVILEGE for PRIVILEGE
-- grant execute on PRIVILEGE to public

/*
How to test it?

Type:

set serveroutput on size 1000000

declare
x varchar2(20);
begin
x:=PRIVILEGE.get_privilege('ffmqzt');
if length(x) > 0 then 
	dbms_output.put_line('Privileges:' || x || '.');
else
	dbms_output.put_line('No privileges');	
end if;
end;
/

Desired output:

SQL> set serveroutput on size 1000000
SQL> declare
  2  x varchar2(20);
  3  begin
  4  x:=PRIVILEGE.get_privilege('c');
  5  dbms_output.put_line(x);
  6  end;
  7  /
CHECKIN:PROBE

Procedura PL/SQL úspìšnì dokonèena.

SQL> 

*/