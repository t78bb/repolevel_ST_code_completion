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

FB_MovingZ(CLK := _movePicker);
FB_MovingX(CLK := _moveArm);
FB_ItemDetect(CLK := _itemDetected);

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
	RETURN;
END_IF;

IF BaseClamped AND LidClamped THEN
	IF NOT LidPicked THEN
		_gripperAtLid := TRUE;
		_grabItem := TRUE;
		_movePicker := TRUE;
IF FB_MovingZ.Q THEN
    _grabItem := FALSE; // Reset gripper state post-movement
    LidPicked := TRUE; // Mark lid pickup as complete
  END_IF;
	END_IF;

IF LidPicked AND NOT LidPlaced THEN
    _gripperAtLid := FALSE; // Preparing to place the lid
    _gripperAtBase := TRUE; // Confirm base gripper alignment
    _moveArm := TRUE; // Initiate arm movement
    IF FB_MovingX.Q THEN
      _moveArm := FALSE; // Stop further arm motion
      _grabItem := TRUE; // Gripper activation at base
      IF FB_MovingZ.Q THEN
        LidPlaced := TRUE; // Confirm lid placement
        _grabItem := FALSE; // Reset gripper state finally
      END_IF;
    END_IF;
  END_IF;

	IF LidPlaced THEN
		_pickerMoved := FALSE;
		_armMoved := FALSE;
		LidPicked := FALSE;
		LidPlaced := FALSE;
		_gripperAtBase := FALSE;
	END_IF;
END_IF;
END_FUNCTION_BLOCK