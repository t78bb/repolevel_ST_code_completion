It seems the code provided is incomplete and references fragments from a PLC (Programmable Logic Controller) program written in Structured Text (ST). To continue writing the code logically, I will complete the `F_SetElevatorDirection` function and provide additional context for the `F_ClearFloorStop` function. Here's the continuation:

```structuredtext
# --------------------------------------------------
# Continuation of F_SetElevatorDirection
# --------------------------------------------------
ELSIF nTargetFloor < nCurrentFloor THEN
    // 目标楼层低于当前楼层，电梯下降
    Tar_Dir.IsPositive := FALSE;
    Tar_Dir.IsNegative := TRUE;
ELSE
    // 当前楼层与目标楼层相同，电梯停止
    Tar_Dir.IsPositive := FALSE;
    Tar_Dir.IsNegative := FALSE;
END_IF

# --------------------------------------------------
# Continuation of F_ClearFloorStop
# --------------------------------------------------
IF bClearUpStop THEN
    Tar_Dir.IsUpStop[nFloor] := FALSE; // 清除上升停靠标志
END_IF

IF bClearDownStop THEN
    Tar_Dir.IsDownStop[nFloor] := FALSE; // 清除下降停靠标志
END_IF

IF bClearStopFloor THEN
    Tar_Dir.IsStopFloor[nFloor] := FALSE; // 清除楼层停靠标志
END_IF
```

### Explanation:
1. **`F_SetElevatorDirection`**:
   - This function determines the elevator's direction based on the current floor (`nCurrentFloor`) and the target floor (`nTargetFloor`).
   - If the target floor is higher, the elevator moves up (`IsPositive` is set to `TRUE`).
   - If the target floor is lower, the elevator moves down (`IsNegative` is set to `TRUE`).
   - If the current floor equals the target floor, the elevator stops (`IsPositive` and `IsNegative` are both set to `FALSE`).

2. **`F_ClearFloorStop`**:
   - This function clears specific flags for a given floor (`nFloor`).
   - It clears the upward stop flag (`IsUpStop`), downward stop flag (`IsDownStop`), and floor stop flag (`IsStopFloor`) based on the input parameters (`bClearUpStop`, `bClearDownStop`, `bClearStopFloor`).

These fragments are part of a larger elevator control system, and the logic ensures safe and efficient operation of the elevator based on user commands and floor-specific tasks. Let me know if you need further elaboration or additional code!