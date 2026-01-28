VAR
    lrTimeInMilliseconds : LREAL; // 用于存储以毫秒为单位的时间
    lrTimeInSeconds : LREAL;      // 用于存储以秒为单位的时间
END_VAR

// 将TIME类型转换为毫秒
lrTimeInMilliseconds := TIME_TO_DWORD(tTime);

// 将毫秒转换为秒
lrTimeInSeconds := lrTimeInMilliseconds / 1000.0;

// 将秒数转换为DWORD并返回
F_TimeToSeconds := DINT_TO_DWORD(TRUNC(lrTimeInSeconds));
RETURN;
END_FUNCTION
