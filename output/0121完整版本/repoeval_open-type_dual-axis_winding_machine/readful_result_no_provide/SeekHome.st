VAR
	_fbMoveVel	:	MC_MoveVelocity;
	_fbMoveAbs	:	MC_MoveAbsolute;
	_fbHalt		:	MC_Halt;
	_fbSetPos	:	MC_SetPosition;
	_fbRtrig	:	R_TRIG;
	_fbFtrig	:	F_TRIG;
	_nBDirection	:	MC_DIRECTION;
	_fTempPos		:	LREAL;
	_nState		:	USINT;
	_xPrevHome	:	BOOL;
	_xPrevAbort	:	BOOL;
	_xErrorDetected	:	BOOL;
	_iTempErrId		:	DINT;
END_VAR

IF _xAbort THEN
	_fbHalt.Execute := TRUE;
	_fbHalt.Axis := _Axis;
	_fbHalt.Deceleration := _fHomeDec;
	_fbHalt.Start();
	_xBusy := FALSE;
	_xDone := FALSE;
	_xErr := FALSE;
	_iErrId := 0;
	_nState := 0;
	RETURN;
END_IF

CASE _nState OF
	0: // Idle state
		IF _xHome THEN
			_xBusy := TRUE;
			_xDone := FALSE;
			_xErr := FALSE;
			_iErrId := 0;
			_nState := 1;
		END_IF

	1: // Start homing
		_fbMoveVel.Execute := TRUE;
		_fbMoveVel.Axis := _Axis;
		_fbMoveVel.Velocity := _fFastHomeVel;
		_fbMoveVel.Acceleration := _fHomeAcc;
		_fbMoveVel.Deceleration := _fHomeDec;
		_fbMoveVel.Direction := _nDirection;
		_fbMoveVel.Start();
		_nState := 2;

	2: // Monitor reference switch
		IF _xReferenceSwitch THEN
			_fbMoveVel.Execute := FALSE;
			_fbMoveVel.Start();
			_nState := 3;
		END_IF

	3: // Slow homing
		_fbMoveVel.Execute := TRUE;
		_fbMoveVel.Axis := _Axis;
		_fbMoveVel.Velocity := _fSlowHomeVel;
		_fbMoveVel.Acceleration := _fHomeAcc;
		_fbMoveVel.Deceleration := _fHomeDec;
		_fbMoveVel.Direction := _nDirection;
		_fbMoveVel.Start();
		_nState := 4;

	4: // Monitor index pulse
		IF _xIndexPulse THEN
			_fbMoveVel.Execute := FALSE;
			_fbMoveVel.Start();
			_nState := 5;
		END_IF

	5: // Set position
		_fbSetPos.Execute := TRUE;
		_fbSetPos.Axis := _Axis;
		_fbSetPos.Position := _fHomePos;
		_fbSetPos.Start();
		_nState := 6;

	6: // Complete homing
		_xBusy := FALSE;
		_xDone := TRUE;
		_xErr := FALSE;
		_iErrId := 0;
		_nState := 0;

	ELSE
		_xErr := TRUE;
		_iErrId := _fbMoveVel.ErrorID;
		_xBusy := FALSE;
		_xDone := FALSE;
		_nState := 0;
	END_CASE

RETURN;
END_FUNCTION_BLOCK
