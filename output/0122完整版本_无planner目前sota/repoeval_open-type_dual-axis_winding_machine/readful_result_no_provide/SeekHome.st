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
	_xRefSwitchPrev	:	BOOL;
	_xIndexPulsePrev	:	BOOL;
END_VAR

IF _xAbort THEN
	_fbHalt.Execute := TRUE;
	_fbHalt.Axis := _Axis;
	_xBusy := FALSE;
	_xDone := FALSE;
	_xErr := FALSE;
	_iErrId := 0;
	_nState := 0;
	RETURN;
END_IF

CASE _nState OF
	0: // Idle
		IF _xHome THEN
			_xBusy := TRUE;
			_xDone := FALSE;
			_xErr := FALSE;
			_iErrId := 0;
			_nState := 1;
		END_IF;

	1: // Start Homing
		_fbMoveVel.Execute := TRUE;
		_fbMoveVel.Axis := _Axis;
		_fbMoveVel.Velocity := _fFastHomeVel;
		_fbMoveVel.Acceleration := _fHomeAcc;
		_fbMoveVel.Deceleration := _fHomeDec;
		_fbMoveVel.Direction := _nDirection;

		IF _xReferenceSwitch THEN
			_fbMoveVel.Execute := FALSE;
			_nState := 2;
		END_IF;

	2: // Slow Homing
		_fbMoveVel.Execute := TRUE;
		_fbMoveVel.Velocity := _fSlowHomeVel;

		IF _xIndexPulse THEN
			_fbMoveVel.Execute := FALSE;
			_nState := 3;
		END_IF;

	3: // Set Position
		_fbSetPos.Execute := TRUE;
		_fbSetPos.Axis := _Axis;
		_fbSetPos.Position := _fHomePos;

		IF NOT _fbSetPos.Busy THEN
			_fbSetPos.Execute := FALSE;
			_xBusy := FALSE;
			_xDone := TRUE;
			_nState := 0;
		END_IF;

	ELSE
		_xErr := TRUE;
		_iErrId := 1; // Error code for unexpected state
		_xBusy := FALSE;
		_nState := 0;
	END_CASE;
RETURN;
END_FUNCTION_BLOCK
