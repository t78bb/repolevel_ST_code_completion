VAR
	_rT: LREAL;                                         //内部时间常数
	_rY: LREAL;                                         //内部输出值
END_VAR

// 初始化输出数据
IF _rT = 0.0 THEN
	rOutput := rInput;                                 // 如果时间常数为零，输出等于输入
END_IF

// 计算时间常数
_rT := TIME_TO_REAL(tT) / 10.0;                        // 将时间参数转换为实数并除以采样周期（10ms）

// 防止除零和计算滤波输出
IF ABS(rOutput - rInput) < 1E-6 THEN
	rOutput := rInput;                                 // 如果输入和输出差值很小，直接输出输入值
ELSIF _rT > 0.0 THEN
	rOutput := (rK / _rT) * rInput + (1.0 - (1.0 / _rT)) * _rY; // PT1滤波计算公式
ELSE
	rOutput := rInput;                                 // 如果时间常数小于等于零，输出等于输入
END_IF

// 更新内部输出值
_rY := rOutput;