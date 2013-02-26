begin  
  -- clean up  
  delete TMAPPER_USER_ROLES;
  
  delete TMAPPER_USERS;
  
  delete TMAPPER_ROLE_PRIVILEGES;
  
  delete TMAPPER_ROLES;
  
  delete TMAPPER_PRIVILEGES;
  
  -- commit
  commit;
end;
/