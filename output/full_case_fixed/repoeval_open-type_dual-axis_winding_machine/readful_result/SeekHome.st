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
    _fbMoveVel : MC_MoveVelocity;
    _fbMoveAbs : MC_MoveAbsolute;
    _fbHalt : MC_Halt;
    _fbSetPos : MC_SetPosition;
    _fbRtrig : R_TRIG;
    _fbFtrig : F_TRIG;
    _nBDirection : MC_DIRECTION;
    _fTempPos : LREAL;
    _nState : USINT;
    _xPrevHome : BOOL;
END_VAR

CASE _nState OF
    0: // Idle state
        _xBusy := FALSE;
        _xDone := FALSE;
        _xErr := FALSE;
        _iErrId := 0;
        IF _xHome THEN
            _xBusy := TRUE;
            _nState := 1;
        END_IF;

    1: // Start homing sequence
_fbMoveVel.Axis := _Axis;
  _fbMoveVel.Velocity := _fFastHomeVel;
  _fbMoveVel.Acceleration := _fHomeAcc;
  _fbMoveVel.Deceleration := _fHomeDec;
  _fbMoveVel.Direction := _nDirection;

IF NOT _fbMoveVel.Execute THEN
   _fbMoveVel.Execute := TRUE;
  END_IF;

    IF _fbMoveVel.Error THEN
      _xErr := TRUE;
      _iErrId := _fbMoveVel.ErrorID;
      _fbMoveVel.Execute := FALSE;
      _nState := 0;
    ELSIF _xReferenceSwitch THEN
      _fbMoveVel.Execute := FALSE;
      _nState := 2;
    END_IF;

    2: // Slow homing
_fbMoveVel.Axis := _Axis;
  _fbMoveVel.Velocity := _fSlowHomeVel;
  _fbMoveVel.Acceleration := _fHomeAcc;
  _fbMoveVel.Deceleration := _fHomeDec;
  _fbMoveVel.Direction := _nDirection;

    IF NOT _fbMoveVel.Enabled THEN
      _fbMoveVel.Execute := TRUE;
    END_IF;

    IF _fbMoveVel.Error THEN
      _xErr := TRUE;
      _iErrId := _fbMoveVel.ErrorID;
      _fbMoveVel.Execute := FALSE;
      _nState := 0;
    ELSIF _xIndexPulse THEN
      _fbMoveVel.Execute := FALSE;
      _nState := 3;
    END_IF;

    3: // Set position
_fbSetPos.Axis := _Axis;
    _fbSetPos.Position := _fHomePos;

IF NOT _fbSetPos.Execute THEN
   _fbSetPos.Execute := TRUE;
  END_IF;

    IF _fbSetPos.Error THEN
      _xErr := TRUE;
      _iErrId := _fbSetPos.ErrorID;
      _fbSetPos.Execute := FALSE;
      _nState := 0;
    ELSIF _fbSetPos.Done THEN
      _fbSetPos.Execute := FALSE;
      _nState := 4;
    END_IF;

    4: // Homing complete
        _xBusy := FALSE;
        _xDone := TRUE;
        _nState := 0;

END_CASE;

IF _xAbort THEN
    _fbMoveVel.Execute := FALSE;
    _fbSetPos.Execute := FALSE;
    _xBusy := FALSE;
    _xDone := FALSE;
    _xErr := FALSE;
    _iErrId := 0;
    _nState := 0;
END_IF;
END_FUNCTION_BLOCK