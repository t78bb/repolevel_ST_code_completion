FUNCTION_BLOCK FB_TripleAxisStop
VAR_INPUT
	AxisX			:	SM3_Basic.AXIS_REF_SM3			//X轴引用
	AxisY			:	SM3_Basic.AXIS_REF_SM3			//Y轴引用
	AxisZ			:	SM3_Basic.AXIS_REF_SM3			//Z轴引用
	bExecute		:	BOOL;				//执行停止信号
	rDeceleration	:	REAL := 100.0;		//减速度
END_VAR
VAR_OUTPUT
	bDone			:	BOOL;				//三轴都停止完成
	bBusy			:	BOOL;				//停止进行中
	bError			:	BOOL;				//错误标志
	sErrorString	:	STRING;				//错误信息字符串
END_VAR

# VAR
# 	fbStopX		:	MC_STOP;			//X轴停止
# 	fbStopY		:	MC_STOP;			//Y轴停止
# 	fbStopZ		:	MC_STOP;			//Z轴停止
# END_VAR
# 
# // X轴停止
# fbStopX(
# 	Execute := bExecute,
# 	Axis := AxisX,
# 	Deceleration := rDeceleration
# );
# 
# // Y轴停止
# fbStopY(
# 	Execute := bExecute,
# 	Axis := AxisY,
# 	Deceleration := rDeceleration
# );
# 
# // Z轴停止
# fbStopZ(
# 	Execute := bExecute,
# 	Axis := AxisZ,
# 	Deceleration := rDeceleration
# );
# 
# // 检查停止状态
# bDone := fbStopX.Done AND fbStopY.Done AND fbStopZ.Done;
# bBusy := fbStopX.Busy OR fbStopY.Busy OR fbStopZ.Busy;
# bError := fbStopX.Error OR fbStopY.Error OR fbStopZ.Error;
# 
# IF bError THEN
# 	sErrorString := 'Error in one or more axes during stop operation';
# END_IF
END_FUNCTION_BLOCK