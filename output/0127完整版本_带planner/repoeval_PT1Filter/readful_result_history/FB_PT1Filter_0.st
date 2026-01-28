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
	_rT: LREAL;											//时间常数转换为实数
	_alpha: REAL;										//滤波系数
END_VAR

// 计算时间步长
_rT := TIME_TO_REAL(tT) / 10.0;						// 假设采样周期为10ms

// 防止时间常数为零的情况
IF _rT <= 0.0 THEN
	rOutput := rInput;								// 时间常数无效时直接输出输入值
	RETURN;
END_IF

// 计算滤波系数alpha
_alpha := rK / (_rT + rK);

// 更新滤波输出
rOutput := rOutput + _alpha * (rInput - rOutput);

// 存储滤波结果
RETURN;
END_FUNCTION_BLOCK
