prompt /* initialize levels */;
insert into tmapper_ws_cfg_level values (null, 'GLOBAL');
insert into tmapper_ws_cfg_level values (null, 'TESTER');
insert into tmapper_ws_cfg_level values (null, 'PROBER');
insert into tmapper_ws_cfg_level values (null, 'SYSTEM');
insert into tmapper_ws_cfg_level values (null, 'DEVICE');
insert into tmapper_ws_cfg_level values (null, 'LOT');
insert into tmapper_ws_cfg_level values (null, 'CUSTOM');

prompt /* initialize data types */;
insert into tmapper_ws_cfg_data_type values (null, 'BOOLEAN', 1, 0);
insert into tmapper_ws_cfg_data_type values (null, 'STRING', 2000, 0);
insert into tmapper_ws_cfg_data_type values (null, 'INTEGER', 32, 0);
insert into tmapper_ws_cfg_data_type values (null, 'LONG', 64, 0);
insert into tmapper_ws_cfg_data_type values (null, 'FLOAT', 32, 7);
insert into tmapper_ws_cfg_data_type values (null, 'DOUBLE', 64, 15);
insert into tmapper_ws_cfg_data_type values (null, 'LIST', 0, 0);
insert into tmapper_ws_cfg_data_type values (null, 'STRUCT', 0, 0);

prompt /* initialize configuration types */;
insert into tmapper_ws_cfg_type values (null, 'MAPPER', 'Common application setting.');
insert into tmapper_ws_cfg_type values (null, 'LOT', 'Material related setting.');

prompt /* initialize equipment types */;
insert into tmapper_ws_equipment_type values (null, 'TESTER', 'some description about tester');
insert into tmapper_ws_equipment_type values (null, 'PROBER', 'some description about prober');

commit;