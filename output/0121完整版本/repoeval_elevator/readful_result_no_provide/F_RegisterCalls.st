IF CallGround THEN 
  TargetFloors[0] := TRUE; // Assign TRUE to the 0th index if CallGround is triggered
END_IF;

IF CallFloor1 THEN 
  TargetFloors[1] := TRUE; // Assign TRUE to the 1st index if CallFloor1 is triggered
END_IF;

IF CallFloor2 THEN 
  TargetFloors[2] := TRUE; // Assign TRUE to the 2nd index if CallFloor2 is triggered
END_IF;

IF CallFloor3 THEN 
  TargetFloors[3] := TRUE; // Assign TRUE to the 3rd index if CallFloor3 is triggered
END_IF;

RETURN // Correctly terminate the FUNCTION without a trailing semicolon after RETURN
END_FUNCTION