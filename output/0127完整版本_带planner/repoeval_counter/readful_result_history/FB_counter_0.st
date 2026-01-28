FUNCTION_BLOCK FB_Counter
VAR_INPUT
	bUp:BOOL;			(*递增信号输入*)
	bDown:BOOL;			(*递减信号输入*)
	bReset:BOOL;		(*复位、清零信号输入*)
END_VAR
VAR_OUTPUT
	nValue:INT;			(*输出数值*)
END_VAR
VAR
    nValueInitialized: BOOL := FALSE; (*标记是否已初始化*)
END_VAR

IF NOT nValueInitialized THEN
    nValue := 0; (*初始化nValue为有效数值*)
    nValueInitialized := TRUE;
END_IF

IF bReset THEN
    nValue := 0; (*复位信号为TRUE时，清零nValue*)
ELSIF bUp THEN
    nValue := nValue + 1; (*递增信号为TRUE时，递增nValue*)
ELSIF bDown THEN
    nValue := nValue - 1; (*递减信号为TRUE时，递减nValue*)
END_IF
END_FUNCTION_BLOCK
