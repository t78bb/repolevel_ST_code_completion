FUNCTION_BLOCK SeekHome
VAR_IN_OUT 
	_Axis	:	AXIS_REF_SM3;
END_VAR
VAR_INPUT
	_xHome	:	BOOL;
	_xAbort	:	BOOL;
	_nHomeMode	:	HomeMode;
	_fFastHomeVel	:	LREAL;
	_fSlowHomeVel	:	LREAL;
	_fHomeAcc		:	LREAL;
	_fHomeDec		:	LREAL;
	_fHomePos		:	LREAL;
	_xReferenceSwitch	:	BOOL;//typically is true
	_nDirection	:	MC_DIRECTION;
	_xIndexPulse	:	BOOL;
END_VAR
VAR_OUTPUT
	_xBusy	:	BOOL;
	_xDone	:	BOOL;
	_xErr	:	BOOL;
	_iErrId	:	DINT;
END_VAR
VAR
	_nState		:	USINT;
	_fbMoveVel	:	MC_MoveVelocity;
	_fbMoveAbs	:	MC_MoveAbsolute;
	_fbHalt		:	MC_Halt;
	_fbSetPos	:	MC_SetPosition;
	_fbRtrig	:	R_TRIG;
	_fbFtrig	:	F_TRIG;
	_nBDirection	:	MC_DIRECTION;
	_fTempPos		:	LREAL;
	_xHomeActive	:	BOOL;
	_xAbortActive	:	BOOL;
END_VAR

IF _xHome THEN
	_xHomeActive := TRUE;
	_xAbortActive := FALSE;
	_xBusy := TRUE;
	_xDone := FALSE;
	_xErr := FALSE;
	_iErrId := 0;
	_nState := 1;
ELSIF _xAbort THEN
	_xAbortActive := TRUE;
	_xHomeActive := FALSE;
	_xBusy := FALSE;
	_xDone := FALSE;
	_xErr := FALSE;
	_iErrId := 0;
	_nState := 0;
END_IF

CASE _nState OF
	0: // Idle state
		IF _xAbortActive THEN
			_fbHalt.Execute := TRUE;
			_fbHalt.Axis := _Axis;
			_fbHalt.Deceleration := _fHomeDec;
			_fbHalt.Execute := FALSE;
			_xAbortActive := FALSE;
		END_IF

	1: // Start homing
		IF _xHomeActive THEN
			_fbMoveVel.Execute := TRUE;
			_fbMoveVel.Axis := _Axis;
			_fbMoveVel.Velocity := _fFastHomeVel;
			_fbMoveVel.Acceleration := _fHomeAcc;
			_fbMoveVel.Deceleration := _fHomeDec;
			_fbMoveVel.Direction := _nDirection;
			IF _fbMoveVel.Done THEN
				_fbMoveVel.Execute := FALSE;
				_nState := 2;
			END_IF
		END_IF

	2: // Monitor reference switch
		IF _xReferenceSwitch THEN
			_fbMoveVel.Execute := FALSE;
			_fbMoveAbs.Execute := TRUE;
			_fbMoveAbs.Axis := _Axis;
			_fbMoveAbs.Position := _fHomePos;
			_fbMoveAbs.Velocity := _fSlowHomeVel;
			_fbMoveAbs.Acceleration := _fHomeAcc;
			_fbMoveAbs.Deceleration := _fHomeDec;
			IF _fbMoveAbs.Done THEN
				_fbMoveAbs.Execute := FALSE;
				_nState := 3;
			END_IF
		END_IF

	3: // Monitor index pulse
		IF _xIndexPulse THEN
			_fbSetPos.Execute := TRUE;
			_fbSetPos.Axis := _Axis;
			_fbSetPos.Position := 0.0;
			IF _fbSetPos.Done THEN
				_fbSetPos.Execute := FALSE;
				_xDone := TRUE;
				_xBusy := FALSE;
				_nState := 0;
			END_IF
		END_IF

	ELSE
		_xErr := TRUE;
		_iErrId := 1; // Unknown state error
		_xBusy := FALSE;
		_nState := 0;
END_CASE
END_FUNCTION_BLOCK
