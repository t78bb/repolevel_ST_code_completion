PROGRAM DynModel_Tests
VAR_OUTPUT
	successful: BOOL;
	error : BOOL;
END_VAR
VAR
	state : INT;
	tester : Test_DynModel_Scara2_Z;
END_VAR

CASE state OF
	0:
		IF tester.CheckScrewAxis() THEN
			state := state + 10;
		ELSE
			state := state + 1000;
		END_IF
	
	10:
		IF tester.CheckStandstillTorque() THEN
			state := state + 10;
		ELSE
			state := state + 1000;
		END_IF
	
	20:
		state := 100;
END_CASE

successful := state = 100;
error := state >= 1000;