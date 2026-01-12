PROGRAM Example_GroupContinue
VAR_INPUT
  /// Start command execution
  Execute : BOOL;
END_VAR 

VAR_OUTPUT
  /// Error ID
  ErrorID     : DINT;
  /// Error addition text
  ErrorAddTxt : STRING;
END_VAR

VAR
  /// internal step counter
 _stepCmd    : DINT;
  /// internal timer for command 
 _timerCmd   : TON;
  /// internal timeout for command
 _timeoutCmd : TIME := T#5S; 
END_VAR

CASE _stepCmd OF

  0: // start execution ?    
     IF ( Execute )
     THEN 
       // reset request
       Execute := FALSE;
       // set timeout
       SetTimeout(PT := _timeoutCmd, rTimer := _timerCmd);
       // inc step counter
      _stepCmd := _stepCmd + 1;
     END_IF
     
  1: // Start Execution
     IF (( NOT GroupContinue.Busy  ) AND
         ( NOT GroupContinue.Error ))
     THEN 
       // start execution
       GroupContinue.Execute := TRUE;
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
       IF (GroupContinue.Error)
       THEN
         ErrorID     := GroupContinue.ErrorID;
         ErrorAddTxt := CONCAT('_stepCmd = ' , DINT_TO_STRING(_stepCmd));
       END_IF
     END_IF

  2: // Wait Execution done ? 
     IF (( NOT GroupContinue.Error ) AND
         (     GroupContinue.Done  ))
     THEN 
       // stop execution
       GroupContinue.Execute := FALSE;
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
       IF (GroupContinue.Error)
       THEN
         ErrorID     := GroupContinue.ErrorID;
         ErrorAddTxt := CONCAT('_stepCmd = ' , DINT_TO_STRING(_stepCmd));
       END_IF
     END_IF     
     
ELSE
  // invalid step
  ErrorID     := RobotLibraryErrorIdEnum.ERR_INVALID_STEP;
  ErrorAddTxt := CONCAT('_stepCmd = ' , DINT_TO_STRING(_stepCmd));
END_CASE


// call function block
GroupContinue
( 
  Name      := 'GroupContinue',
  ExecMode  := ExecutionMode.PARALLEL,
  Priority  := PriorityLevel.NORMAL,
  AxesGroup := AxesGroup
);