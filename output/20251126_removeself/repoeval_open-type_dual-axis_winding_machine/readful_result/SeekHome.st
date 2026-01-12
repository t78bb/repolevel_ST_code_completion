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
	_fbRtrigHome	:	R_TRIG;
	_fbFtrigAbort	:	F_TRIG;
	_xPrevHome		:	BOOL;
	_xPrevAbort		:	BOOL;
	_xPrevReferenceSwitch	:	BOOL;
	_xPrevIndexPulse	:	BOOL;
	_fPrevHomePos	:	LREAL;
	_nPrevDirection	:	MC_DIRECTION;
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
	_fbRtrig	:	R_TRIG;
	_fbFtrig	:	F_TRIG;
	_nBDirection	:	MC_DIRECTION;
	_fTempPos		:	LREAL;
	_nState		:	USINT;
	_fbRtrigHome	:	R_TRIG;
	_fbFtrigAbort	:	F_TRIG;
	_xPrevHome		:	BOOL;
	_xPrevAbort		:	BOOL;
	_xPrevReferenceSwitch	:	BOOL;
	_xPrevIndexPulse	:	BOOL;
	_fPrevHomePos	:	LREAL;
	_nPrevDirection	:	MC_DIRECTION;
END_VAR

CASE _nState OF
	0: // Initialization
		_xBusy := FALSE;
		_xDone := FALSE;
		_xErr := FALSE;
		_iErrId := 0;
		_nState := 1;
	1: // Check Home Command
		IF _xHome THEN
			_xBusy := TRUE;
			_fbRtrigHome(CLK := _xHome);
			IF _fbRtrigHome.Q THEN
				_nState := 2;
			END_IF
		END_IF
	2: // Execute Fast Home
		_fbMoveVel.Execute := TRUE;
		_fbMoveVel.Axis := _Axis;
		_fbMoveVel.Velocity := _fFastHomeVel;
		_fbMoveVel.Acceleration := _fHomeAcc;
		_fbMoveVel.Deceleration := _fHomeDec;
		_fbMoveVel.Direction := _nDirection;
		IF _fbMoveVel.Done THEN
			_nState := 3;
		END_IF
	3: // Execute Slow Home
		_fbMoveVel.Execute := TRUE;
		_fbMoveVel.Velocity := _fSlowHomeVel;
		IF _fbMoveVel.Done THEN
			_nState := 4;
		END_IF
	4: // Set Position
		_fbSetPos.Execute := TRUE;
		_fbSetPos.Axis := _Axis;
		_fbSetPos.Position := _fHomePos;
		IF _fbSetPos.Done THEN
			_xDone := TRUE;
			_xBusy := FALSE;
			_nState := 0;
		END_IF
ELSE
		_xErr := TRUE;
		_iErrId := 1; // Error Code
		_xBusy := FALSE;
		_nState := 0;
END_CASE