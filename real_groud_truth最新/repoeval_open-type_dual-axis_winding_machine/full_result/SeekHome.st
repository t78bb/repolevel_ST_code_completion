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
	_fbMoveVel	:	MC_MoveVelocity;
	_fbMoveAbs	:	MC_MoveAbsolute;
	_fbHalt		:	MC_Halt;
	_fbSetPos	:	MC_SetPosition;
	_fbRtrig		:	R_TRIG;
	_fbFtrig		:	F_TRIG;
	_nBDirection	:	MC_DIRECTION;
	_fTempPos		:	LREAL;
	_nState		:	USINT;
END_VAR

METHOD FAST_ZERO
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
	_fbMoveVel	:	MC_MoveVelocity;
	_fbMoveAbs	:	MC_MoveAbsolute;
	_fbHalt		:	MC_Halt;
	_fbSetPos	:	MC_SetPosition;
	_fbRtrig		:	R_TRIG;
	_fbFtrig		:	F_TRIG;
	_nBDirection	:	MC_DIRECTION;
	_fTempPos		:	LREAL;
	_nState		:	USINT;
END_VAR

CASE _nState OF
	0: // Initialization
		_xBusy := TRUE;
		_xDone := FALSE;
		_xErr := FALSE;
		_iErrId := 0;
		_nState := 1;

	1: // Check Home Condition
		IF _xHome THEN
			_fbRtrig(CLK := _xHome);
			IF _fbRtrig.Q THEN
				_nState := 2;
			END_IF;
		END_IF;

	2: // Execute Fast Home Velocity
		_fbMoveVel(Axis := _Axis, Velocity := _fFastHomeVel, Acceleration := _fHomeAcc, Deceleration := _fHomeDec, Direction := _nDirection);
		IF _fbMoveVel.Done THEN
			_nState := 3;
		END_IF;

	3: // Execute Slow Home Velocity
		_fbMoveVel(Axis := _Axis, Velocity := _fSlowHomeVel, Acceleration := _fHomeAcc, Deceleration := _fHomeDec, Direction := _nDirection);
		IF _fbMoveVel.Done THEN
			_nState := 4;
		END_IF;

	4: // Set Position
		_fbSetPos(Axis := _Axis, Position := _fHomePos);
		IF _fbSetPos.Done THEN
			_nState := 5;
		END_IF;

	5: // Complete
		_xBusy := FALSE;
		_xDone := TRUE;
		_nState := 0;

ELSE
	_xErr := TRUE;
	_iErrId := -1; // Error ID
END_CASE;
END_FUNCTION_BLOCK