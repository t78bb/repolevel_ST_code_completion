FUNCTION_BLOCK FB_PT1Filter
VAR_INPUT
	rInput: REAL:= 0.0; 								//输入数据
	rK: REAL:= 1.0; 									//增益
	tT: TIME; 											//时间参数
END_VAR
VAR_OUTPUT
	rOutput: REAL:= 0.0;  								//输出数据
END_VAR
VAR
	_rT: LREAL;
	_rY: LREAL;
END_VAR

_rT := TIME_TO_REAL(tT) / 10.0;  // Convert time constant to real and normalize by sampling period (10ms)

IF _rT = 0.0 THEN
	rOutput := rInput;  // Initialize output if time constant is zero
ELSIF ABS(rOutput - rInput) < 1E-6 THEN
	rOutput := rInput;  // Prevent division by zero for very small differences
ELSIF _rT > 0.0 THEN
	rOutput := (rK / _rT) * rInput + (1.0 - (1.0 / _rT)) * _rY;  // Apply PT1 filter formula
ELSE
	rOutput := rInput;  // Output equals input if time constant is less than or equal to zero
END_IF

_rY := rOutput;  // Update internal state
END_FUNCTION_BLOCK
