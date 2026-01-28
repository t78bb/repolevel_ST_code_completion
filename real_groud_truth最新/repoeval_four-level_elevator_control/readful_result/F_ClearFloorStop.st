It seems like you are working on a multi-layer elevator control system, and the provided code fragments are written in Structured Text (ST), commonly used in PLC programming. Based on the context, I will continue writing the `F_SetElevatorDirection` function and the `F_ClearFloorStop` function to complete their logic.

Here is the continuation:

```
// F_SetElevatorDirection function continued
// 目标楼层低于当前楼层，电梯下降
	Tar_Dir.IsPositive := FALSE;
	Tar_Dir.IsNegative := TRUE;
ELSE
	// 当前楼层等于目标楼层，电梯停止
	Tar_Dir.IsPositive := FALSE;
	Tar_Dir.IsNegative := FALSE;
END_IF;

// F_ClearFloorStop function implementation
FUNCTION F_ClearFloorStop
VAR_INPUT
	nFloor			:	USINT;		//楼层号
	bClearUpStop	:	BOOL;		//是否清除上升停靠标志
	bClearDownStop	:	BOOL;		//是否清除下降停靠标志
	bClearStopFloor	:	BOOL;		//是否清除楼层停靠标志
END_VAR

// 清除上升停靠标志
IF bClearUpStop THEN
	Tar_Dir.IsUpStop[nFloor] := FALSE;
END_IF;

// 清除下降停靠标志
IF bClearDownStop THEN
	Tar_Dir.IsDownStop[nFloor] := FALSE;
END_IF;

// 清除楼层停靠标志
IF bClearStopFloor THEN
	Tar_Dir.IsStopFloor[nFloor] := FALSE;
END_IF;
```

### Explanation:
1. **`F_SetElevatorDirection` Function**:
   - This function determines the elevator's direction based on the current floor (`nCurrentFloor`) and the target floor (`nTargetFloor`).
   - If the target floor is higher than the current floor, the elevator moves up.
   - If the target floor is lower, the elevator moves down.
   - If the target floor equals the current floor, the elevator stops.

2. **`F_ClearFloorStop` Function**:
   - This function clears specific stop flags for a given floor (`nFloor`).
   - It checks the input flags (`bClearUpStop`, `bClearDownStop`, `bClearStopFloor`) and clears the corresponding stop flags (`IsUpStop`, `IsDownStop`, `IsStopFloor`) for the specified floor.

If you have additional requirements or need further clarification, feel free to ask!