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
    nPrevValue: INT;   (* Previous value for internal tracking *)
END_VAR

IF bReset THEN
    nValue := 0;       (* Reset the counter *)
ELSIF bUp THEN
    nValue := nValue + 1; (* Increment the counter *)
ELSIF bDown THEN
    nValue := nValue - 1; (* Decrement the counter *)
END_IF
END_FUNCTION_BLOCK
