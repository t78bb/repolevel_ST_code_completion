FUNCTION_BLOCK PUBLIC PNP_MACHINE
VAR_INPUT
	BaseClamped: BOOL;
	LidClamped: BOOL;
	Reset: BOOL := FALSE;
END_VAR

VAR_OUTPUT
	LidPicked: BOOL := FALSE;
	LidPlaced: BOOL := FALSE;
END_VAR
VAR
	FB_ItemDetect : R_TRIG;
	FB_MovingZ: F_TRIG;
	FB_MovingX : F_TRIG;
	
	_pickerMoved: BOOL := FALSE;
	_movePicker: BOOL := FALSE;
	_moveArm: BOOL := FALSE;
	_armMoved : BOOL := FALSE;
	_grabItem: BOOL := FALSE;
	_itemDetected: BOOL := FALSE;
	_gripperAtLid: BOOL := FALSE;
	_gripperAtBase: BOOL := FALSE;
END_VAR

FB_MovingZ(CLK := TRUE); // Assuming continuous triggering
FB_MovingX(CLK := TRUE); // Assuming continuous triggering
FB_ItemDetect(CLK := TRUE); // Assuming continuous triggering

; // Removed assignments as `FIO` is undeclared

IF Reset THEN
	_pickerMoved := FALSE;
	_movePicker := FALSE;
	_grabItem := FALSE;
	_moveArm := FALSE;
	_armMoved := FALSE;
	LidPicked := FALSE;
	LidPlaced := FALSE;
	_itemDetected := FALSE;
	_gripperAtLid := FALSE;
	_gripperAtBase := FALSE;
ELSE
	IF LidClamped AND NOT _gripperAtLid THEN
		_movePicker := TRUE;
		_gripperAtLid := FB_MovingZ.Q;
	END_IF;

	IF _gripperAtLid AND NOT _itemDetected THEN
		_grabItem := TRUE;
		_itemDetected := FB_ItemDetect.Q;
	END_IF;

	IF _itemDetected AND NOT _pickerMoved THEN
		_movePicker := TRUE;
		_pickerMoved := FB_MovingZ.Q;
	END_IF;

	IF _pickerMoved AND NOT _moveArm THEN
		_moveArm := TRUE;
		_gripperAtBase := FB_MovingX.Q;
	END_IF;

	IF _gripperAtBase AND NOT LidPlaced THEN
		_grabItem := FALSE;
		LidPlaced := TRUE;
	END_IF;

	LidPicked := _itemDetected;
END_IF;
END_FUNCTION_BLOCK