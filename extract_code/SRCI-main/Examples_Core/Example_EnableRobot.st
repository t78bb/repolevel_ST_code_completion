PROGRAM Example_EnableRobot
VAR_INPUT
  /// Enable command
  Enable : BOOL;
  /// Command parameter 
  ParCmd : EnableRobotParCmd;
END_VAR 

VAR_OUTPUT
  /// Error ID
  ErrorID     : DINT;
  /// Error addition text
  ErrorAddTxt : STRING;
  /// Command outputs
  OutCmd      : EnableRobotOutCmd;
END_VAR

VAR
  /// internal step counter
 _stepCmd    : DINT;
  /// internal timer for command 
 _timerCmd   : TON;
  /// internal timeout for command
 _timeoutCmd : TIME := T#5S; 
END_VAR

// forwarding command parameter(s) / command outputs
EnableRobot.ParCmd := ParCmd;
// forwarding command output(s)
OutCmd := EnableRobot.OutCmd;

CASE _stepCmd OF

  0: // Enable or disable function ? 
     IF (( Enable           ) XOR
         ( UserData.Enabled )) 
     THEN 
       // set timeout
       SetTimeout(PT := _timeoutCmd, rTimer := _timerCmd);
       // inc step counter
      _stepCmd := _stepCmd + 1;
     END_IF
     
  1: // Start Execution
     IF (( NOT EnableRobot.Busy  ) AND
         ( NOT EnableRobot.Error ))
     THEN 
       // enable/disable robot
       EnableRobot.Enable := Enable;
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
       IF (EnableRobot.Error)
       THEN
         ErrorID     := EnableRobot.ErrorID;
         ErrorAddTxt := CONCAT('_stepCmd = ' , DINT_TO_STRING(_stepCmd));
       END_IF
     END_IF


  2: // Wait Execution done ? 
     IF (( NOT EnableRobot.Error            ) AND
         (     EnableRobot.Enabled = Enable ))
     THEN 
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
       IF (EnableRobot.Error)
       THEN
         ErrorID     := EnableRobot.ErrorID;
         ErrorAddTxt := CONCAT('_stepCmd = ' , DINT_TO_STRING(_stepCmd));
       END_IF
     END_IF     
     
ELSE
  // invalid step
  ErrorID     := RobotLibraryErrorIdEnum.ERR_INVALID_STEP;
  ErrorAddTxt := CONCAT('_stepCmd = ' , DINT_TO_STRING(_stepCmd));
END_CASE


// call function block
EnableRobot
( 
  Name      := 'EnableRobot',
  ExecMode  := ExecutionMode.PARALLEL,
  Priority  := PriorityLevel.NORMAL,  
  AxesGroup := AxesGroup,
); 