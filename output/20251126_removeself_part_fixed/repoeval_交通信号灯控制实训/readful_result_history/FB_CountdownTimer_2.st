FUNCTION_BLOCK FB_CountdownTimer
VAR_INPUT
	tElapsedTime	:	TIME;		//已经过的时间（定时器的ET）
	tTotalTime		:	TIME;		//总时间（定时器的PT）
END_VAR
VAR_OUTPUT
	nRemainingSeconds	:	UINT;	//剩余秒数
END_VAR

VAR
	tRemainingTime	:	TIME;		//剩余时间
END_VAR

// 计算剩余时间
tRemainingTime := tTotalTime - tElapsedTime;

// 将剩余时间转换为秒数
nRemainingSeconds := TO_UINT(TRUNC(TIME_TO_DWORD(tRemainingTime) / 1000));

END_FUNCTION_BLOCK

// Continue the state machine logic in PLC_PRG
CASE nState OF
    1:
        QSouthNorthYellow := TRUE; // 南北黄灯亮
        fbTon(IN := TRUE, PT := MYellowTimeOn); // 定时，定时到后，黄灯灭
        IF fbTon.Q THEN
            fbTon(IN := FALSE);
            QSouthNorthYellow := FALSE; // 南北黄灯灭
            QSouthNorthRed := TRUE; // 南北红灯亮
            nState := 2;
        END_IF
        // 计算倒计时
        fbCountdown(tElapsedTime := fbTon.ET, tTotalTime := MYellowTimeOn);
        temp := fbCountdown.nRemainingSeconds;
    2:
        QEastWestGreen := TRUE; // 东西绿灯亮
        QSouthNorthRed := TRUE; // 南北红灯亮
        fbTon1(IN := TRUE, PT := MGreenTimeOn); // 定时，定时到后，绿灯开始闪
        IF fbTon1.Q THEN
            fbTon1(IN := FALSE);
            QEastWestGreen := FALSE; // 东西绿灯灭，准备开始闪
            nState := 3;
        END_IF
        // 计算倒计时
        fbCountdown(tElapsedTime := fbTon1.ET, tTotalTime := MGreenTimeOn);
        temp := fbCountdown.nRemainingSeconds;
    3:
        QEastWestYellow := TRUE; // 东西黄灯亮
        fbTon1(IN := TRUE, PT := MYellowTimeOn); // 定时，定时到后，黄灯灭
        IF fbTon1.Q THEN
            fbTon1(IN := FALSE);
            QEastWestYellow := FALSE; // 东西黄灯灭
            QEastWestRed := TRUE; // 东西红灯亮
            nState := 0; // 返回初始状态
        END_IF
        // 计算倒计时
        fbCountdown(tElapsedTime := fbTon1.ET, tTotalTime := MYellowTimeOn);
        temp := fbCountdown.nRemainingSeconds;
END_CASE
```

This code continues the state machine logic for a traffic light control system, implementing the countdown timer functionality and handling the transitions between different states of the traffic lights.

END_FUNCTION_BLOCK