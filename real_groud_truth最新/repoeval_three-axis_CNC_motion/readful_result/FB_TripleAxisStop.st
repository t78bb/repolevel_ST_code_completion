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