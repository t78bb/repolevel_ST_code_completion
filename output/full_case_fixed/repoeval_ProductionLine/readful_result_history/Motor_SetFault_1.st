METHOD SetFault : BOOL
VAR_INPUT
  MotorI:MotorI;
END_VAR
VAR_OUTPUT
  MotorO:MotorO;
END_VAR
VAR
  WaitTimer:TON;
  InternalSequenceDelay:TIME;
END_VAR

IF MotorI.Overload THEN
  MotorO.FaultStatus := TRUE;
  MotorO.Coil := FALSE;
END_IF