VAR
    nTotalSeconds    : UINT;   // 总秒数
    nElapsedSeconds  : UINT;   // 已过秒数
END_VAR

nTotalSeconds := TIME_TO_UINT(tTotalTime) / 1000; // 将总时间转换为秒
nElapsedSeconds := TIME_TO_UINT(tElapsedTime) / 1000; // 将已过时间转换为秒

IF nElapsedSeconds >= nTotalSeconds THEN
    nRemainingSeconds := 0; // 如果已过时间大于等于总时间，剩余秒数为0
ELSE
    nRemainingSeconds := nTotalSeconds - nElapsedSeconds; // 否则计算剩余秒数
END_IF
END_FUNCTION_BLOCK
