It seems you have provided multiple code fragments from the same file (`电子凸轮运动实训-FUN\F_AxisStatusToString.st`) that define the `F_AxisStatusToString` function. This function takes an input parameter `fbReadStatus` of type `MC_ReadStatus` and returns a string describing the axis status based on priority.

The function checks various states of the axis (`Errorstop`, `Disabled`, `Homing`, `Stopping`, `SynchronizedMotion`, `ContinuousMotion`, etc.) in a sequential manner and assigns the corresponding string to `F_AxisStatusToString`. Once a match is found, the function exits using `RETURN`.

Here is a consolidated version of the function based on the fragments you provided:

```st
FUNCTION F_AxisStatusToString : STRING
VAR_INPUT
	fbReadStatus	:	MC_ReadStatus;		//轴状态读取功能块
END_VAR

// 根据轴状态返回对应的字符串描述
// 按优先级顺序检查状态

IF fbReadStatus.Errorstop THEN
	F_AxisStatusToString := 'Errorstop';
	RETURN;
END_IF

IF fbReadStatus.Disabled THEN
	F_AxisStatusToString := 'Disabled';
	RETURN;
END_IF

IF fbReadStatus.Homing THEN
	F_AxisStatusToString := 'Homing';
	RETURN;
END_IF

IF fbReadStatus.Stopping THEN
	F_AxisStatusToString := 'Stopping';
	RETURN;
END_IF

IF fbReadStatus.SynchronizedMotion THEN
	F_AxisStatusToString := 'SynchronizedMotion';
	RETURN;
END_IF

IF fbReadStatus.ContinuousMotion THEN
	F_AxisStatusToString := 'ContinuousMotion';
	RETURN;
END_IF

// 如果没有匹配的状态，返回默认值
F_AxisStatusToString := 'Unknown';
```

### Explanation:
1. **Priority Order**: The function checks the states in a specific order, ensuring that higher-priority states (e.g., `Errorstop`) are handled first.
2. **Return Statement**: Once a state is matched, the function assigns the corresponding string and exits immediately using `RETURN`.
3. **Default Case**: If none of the states match, the function returns `'Unknown'` as a fallback.

### Notes:
- Ensure that the `MC_ReadStatus` structure includes all the states mentioned (`Errorstop`, `Disabled`, `Homing`, `Stopping`, `SynchronizedMotion`, `ContinuousMotion`).
- If additional states need to be handled, they can be added following the same pattern.
- The function is written in Structured Text (ST), commonly used in PLC programming.