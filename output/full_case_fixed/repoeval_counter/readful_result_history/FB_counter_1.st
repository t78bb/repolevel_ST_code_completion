FUNCTION_BLOCK FB_Counter
VAR_INPUT
  bUp:BOOL;			(*递增信号输入*)
  bDown:BOOL;			(*递减信号输入*)
  bReset:BOOL;		(*复位、清零信号输入*)
END_VAR
VAR_OUTPUT
  nValue:INT;			(*输出数值*)
END_VAR

IF bReset THEN
  nValue := 0;        // 数据清零
ELSE
  // Handle simultaneous input for bUp and bDown explicitly
  IF bUp AND bDown THEN
    // No change in nValue when both are triggered
  ELSIF bUp THEN
    nValue := nValue + 1; // 数据递增
  ELSIF bDown THEN
    nValue := nValue - 1; // 数据递减
  END_IF
END_IF
END_FUNCTION_BLOCK