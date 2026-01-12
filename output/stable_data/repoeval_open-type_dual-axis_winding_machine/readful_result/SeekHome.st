VAR
	_fbMoveVel	:	MC_MoveVelocity;
	_fbMoveAbs	:	MC_MoveAbsolute;
	_fbHalt		:	MC_Halt;
	_fbSetPos	:	MC_SetPosition;
	_fbRtrig	:	R_TRIG;
	_fbFtrig	:	F_TRIG;
	_nState		:	USINT;
	_fTempPos	:	LREAL;
END_VAR

IF _xAbort THEN
	_fbHalt.Axis := _Axis;
	_fbHalt.Execute := TRUE;
	_fbHalt.Deceleration := _fHomeDec;
	_fbHalt.Brake := FALSE;
	_fbHalt();
	_xBusy := FALSE;
	_xDone := FALSE;
	_xErr := FALSE;
	_iErrId := 0;
	RETURN;
END_IF

_fbRtrig(CLK := _xHome);

CASE _nState OF
	0: // Idle state
		_xBusy := FALSE;
		_xDone := FALSE;
		_xErr := FALSE;
		IF _fbRtrig.Q THEN
			_nState := 1;
			_xBusy := TRUE;
		END_IF;

	1: // Fast homing
		_fbMoveVel.Axis := _Axis;
		_fbMoveVel.Velocity := _fFastHomeVel;
		_fbMoveVel.Acceleration := _fHomeAcc;
		_fbMoveVel.Deceleration := _fHomeDec;
		_fbMoveVel.Direction := _nDirection;
		_fbMoveVel.Execute := TRUE;
		_fbMoveVel();
		IF _fbMoveVel.Error THEN
			_xErr := TRUE;
			_iErrId := _fbMoveVel.ErrorID;
			_nState := 0;
		ELSIF _xReferenceSwitch THEN
			_fbMoveVel.Execute := FALSE;
			_nState := 2;
		END_IF;

	2: // Slow homing
		_fbMoveVel.Velocity := _fSlowHomeVel;
		_fbMoveVel.Execute := TRUE;
		_fbMoveVel();
		IF _fbMoveVel.Error THEN
			_xErr := TRUE;
			_iErrId := _fbMoveVel.ErrorID;
			_nState := 0;
		ELSIF _xIndexPulse THEN
			_fbMoveVel.Execute := FALSE;
			_nState := 3;
		END_IF;

	3: // Set position
		_fbSetPos.Axis := _Axis;
		_fbSetPos.Position := _fHomePos;
		_fbSetPos.Execute := TRUE;
		_fbSetPos();
		IF _fbSetPos.Done THEN
			_fbSetPos.Execute := FALSE;
			_nState := 4;
		END_IF;

	4: // Done
		_xBusy := FALSE;
		_xDone := TRUE;
		_nState := 0;

	ELSE
		_xErr := TRUE;
		_iErrId := -1; // Unknown state error
		_nState := 0;
END_CASE;