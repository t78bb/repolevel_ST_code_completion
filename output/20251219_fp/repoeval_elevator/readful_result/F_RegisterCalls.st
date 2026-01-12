VAR
	i : INT;	// Loop variable
END_VAR

// Register calls to the target floors array
FOR i := 0 TO 3 DO
	CASE i OF
		0: 
			IF CallGround THEN
				TargetFloors[i] := TRUE;
			END_IF;
		1: 
			IF CallFloor1 THEN
				TargetFloors[i] := TRUE;
			END_IF;
		2: 
			IF CallFloor2 THEN
				TargetFloors[i] := TRUE;
			END_IF;
		3: 
			IF CallFloor3 THEN
				TargetFloors[i] := TRUE;
			END_IF;
	END_CASE;
END_FOR;