CREATE OR REPLACE TRIGGER ml_trak_hold_bibu_tr
BEFORE INSERT OR UPDATE ON ml_trak_hold
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
	ENG_STATE_HOLD				ml_trak_hold.hold_state%type := 'HOLD';
	ENG_STATE_RELEASE			ml_trak_hold.hold_state%type := 'RELEASE';
	
	HOLD_LEVEL_AUTO				ml_trak_hold.hold_level%type := 'AUTOMATIC';
	HOLD_LEVEL_GEN				ml_trak_hold.hold_level%type := 'GENESIS';
	HOLD_LEVEL_ENG				ml_trak_hold.hold_level%type := 'ENGINEER';
	HOLD_LEVEL_MPE				ml_trak_hold.hold_level%type := 'MPE';

 	HOLD_STATE_ERROR_NUM 	NUMBER := -20101;
 	HOLD_LEVEL_ERROR_NUM 	NUMBER := -20102;
BEGIN
	-- check if inserted hold_state is allowed here
	IF ((:new.hold_state != ENG_STATE_HOLD) AND
		(:new.hold_state != ENG_STATE_RELEASE)) THEN
		RAISE_APPLICATION_ERROR(HOLD_STATE_ERROR_NUM, 
								'Your hold_state (' || :new.hold_state || ') is not allowed here. ' ||
								'Here is list of allowed hold_state: (' ||
								ENG_STATE_HOLD || '), (' || ENG_STATE_RELEASE || ')', true);
	END IF;
	
	-- check if inserted hold_level is allowed here
	IF ((:new.hold_level != HOLD_LEVEL_AUTO) AND
		(:new.hold_level != HOLD_LEVEL_GEN)  AND
		(:new.hold_level != HOLD_LEVEL_ENG)  AND
		(:new.hold_level != HOLD_LEVEL_MPE)) THEN
		RAISE_APPLICATION_ERROR(HOLD_LEVEL_ERROR_NUM, 
								'Your hold_level (' || :new.hold_level || ') is not allowed here. ' ||
								'Here is list of allowed hold_level: (' ||
								HOLD_LEVEL_AUTO || '), (' || HOLD_LEVEL_GEN || '), (' || HOLD_LEVEL_ENG ||
								'), (' || HOLD_LEVEL_MPE || ')', true);
	END IF;
END;