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

FB_MovingZ(CLK := FIO.FIO_iMovingZ);
FB_MovingX(CLK := FIO.FIO_iMovingX);
FB_ItemDetect(CLK := FIO.FIO_iItemDetected);

FIO.FIO_oMoveZ := _movePicker;
FIO.FIO_oGrab := _grabItem;
FIO.FIO_oMoveX := _moveArm;

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
		IF FB_MovingZ.Q THEN
			_gripperAtLid := TRUE;
			_movePicker := FALSE;
		END_IF
	END_IF
	
	IF _gripperAtLid AND NOT _itemDetected THEN
		_grabItem := TRUE;
		IF FB_ItemDetect.Q THEN
			_itemDetected := TRUE;
			_grabItem := FALSE;
			LidPicked := TRUE;
		END_IF
	END_IF
	
	IF LidPicked AND NOT _armMoved THEN
		_moveArm := TRUE;
		IF FB_MovingX.Q THEN
			_armMoved := TRUE;
			_moveArm := FALSE;
		END_IF
	END_IF
	
	IF _armMoved AND NOT _gripperAtBase THEN
		_movePicker := TRUE;
		IF FB_MovingZ.Q THEN
			_gripperAtBase := TRUE;
			_movePicker := FALSE;
		END_IF
	END_IF
	
	IF _gripperAtBase THEN
		_grabItem := TRUE;
		IF FB_ItemDetect.Q THEN
			LidPlaced := TRUE;
			_grabItem := FALSE;
		END_IF
	END_IF
END_IF
END_FUNCTION_BLOCK
