PROGRAM Example_ChangeSpeedOverride
VAR_INPUT
  /// Start command execution
  Execute : BOOL;
  /// Command parameter 
  ParCmd  : ChangeSpeedOverrideParCmd;
END_VAR 

VAR_OUTPUT
  /// Error ID
  ErrorID     : DINT;
  /// Error addition text
  ErrorAddTxt : STRING;
  /// Command outputs
  OutCmd      : ChangeSpeedOverrideOutCmd;
END_VAR

VAR
  /// internal step counter
 _stepCmd    : DINT;
  /// internal timer for command 
 _timerCmd   : TON;
  /// internal timeout for command
 _timeoutCmd : TIME := T#5S; 
END_VAR

// forwarding command parameter(s) 
ChangeSpeedOverride.ParCmd := ParCmd;
// forwarding command output(s)
OutCmd := ChangeSpeedOverride.OutCmd;

CASE _stepCmd OF

  0: // start execution ?  
     IF ( Execute ) 
     THEN 
       // Reset request
       Execute := FALSE;
       // set timeout
       SetTimeout(PT := _timeoutCmd, rTimer := _timerCmd);
       // inc step counter
      _stepCmd := _stepCmd + 1;
     END_IF
     
  1: // Start Execution
     IF (( NOT ChangeSpeedOverride.Error  ) AND
         ( NOT ChangeSpeedOverride.Error  ))
     THEN
       // start execution
       SetSequence.Execute := TRUE;
       // set timeout
       SetTimeout(PT := _timeoutCmd, rTimer := _timerCmd);
       // inc step counter
      _stepCmd := _stepCmd + 1;
     ELSE
       // timeout exceeded ? 
       IF (CheckTimeout(_timerCmd) = RobotLibraryConstants.OK)
       THEN
         ErrorID     := RobotLibraryErrorIdEnum.ERR_TIMEOUT_CMD;
         ErrorAddTxt := CONCAT('_stepCmd = ' , DINT_TO_STRING(_stepCmd));
       END_IF

       // Error occurred ? 
       IF (ChangeSpeedOverride.Error)
       THEN
         ErrorID     := ChangeSpeedOverride.ErrorID;
         ErrorAddTxt := CONCAT('_stepCmd = ' , DINT_TO_STRING(_stepCmd));
       END_IF
     END_IF

  2: // Wait Execution done ? 
     IF (( NOT ChangeSpeedOverride.Busy ) AND
         (     ChangeSpeedOverride.Done ))
     THEN 
       // stop execution
       ChangeSpeedOverride.Execute := FALSE;
       // set timeout
       SetTimeout(PT := _timeoutCmd, rTimer := _timerCmd);
       // set step counter
      _stepCmd := 0;
     ELSE
       // timeout exceeded ? 
       IF (CheckTimeout(_timerCmd) = RobotLibraryConstants.OK)
       THEN
         ErrorID     := RobotLibraryErrorIdEnum.ERR_TIMEOUT_CMD;
         ErrorAddTxt := CONCAT('_stepCmd = ' , DINT_TO_STRING(_stepCmd));
       END_IF

       // Error occurred ? 
       IF (ChangeSpeedOverride.Error)
       THEN
         ErrorID     := ChangeSpeedOverride.ErrorID;
         ErrorAddTxt := CONCAT('_stepCmd = ' , DINT_TO_STRING(_stepCmd));
       END_IF
     END_IF     
     
ELSE
  // invalid step
  ErrorID     := RobotLibraryErrorIdEnum.ERR_INVALID_STEP;
  ErrorAddTxt := CONCAT('_stepCmd = ' , DINT_TO_STRING(_stepCmd));
END_CASE

// Call functionblock
ChangeSpeedOverride
( 
  Name         := 'ChangeSpeedOverride',
  ExecMode     := ExecutionMode.PARALLEL,
  Priority     := PriorityLevel.NORMAL,
  AxesGroup    := AxesGroup
);