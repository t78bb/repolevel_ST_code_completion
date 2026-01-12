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
	_rT: LREAL;                                         //时间常数转换为浮点数
	_rY: LREAL;                                         //内部状态变量
END_VAR

// 初始化输出数据
IF _rT = 0.0 THEN
	rOutput := rInput;                                 // 如果时间常数为零，输出等于输入
END_IF

// 将时间常数转换为浮点数并计算采样周期
_rT := TIME_TO_REAL(tT) / 10.0;                        // 10为PLC的采样周期，单位为ms

// 防止除零情况
IF ABS(rOutput - rInput) < 1E-6 THEN
	rOutput := rInput;                                 // 如果输入与输出非常接近，直接输出输入值
ELSIF _rT > 0.0 THEN
	// PT1滤波计算公式
	rOutput := (rK / _rT) * rInput + (1.0 - (1.0 / _rT)) * _rY;
ELSE
	rOutput := rInput;                                 // 如果时间常数小于等于零，输出等于输入
END_IF

// 更新内部状态变量
_rY := rOutput;