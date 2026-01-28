IF FloorSensor0 THEN 
	F_DetectCurrentFloor := 0;
ELSIF FloorSensor1 THEN 
	F_DetectCurrentFloor := 1;
ELSIF FloorSensor2 THEN 
	F_DetectCurrentFloor := 2;
ELSIF FloorSensor3 THEN 
	F_DetectCurrentFloor := 3;
ELSE
	F_DetectCurrentFloor := CurrentFloor;
END_IF;
RETURN;
END_FUNCTION
