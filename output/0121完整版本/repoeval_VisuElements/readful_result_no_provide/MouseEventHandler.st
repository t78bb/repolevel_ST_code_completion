VAR
    LeftClickTimer : TON;
    xLeftClickOld : BOOL;
    iClickCount : INT := 0;
    xEventProcessed : BOOL := FALSE;
    xRightClickOld : BOOL;
    xMiddleClickOld : BOOL;
    xMouseMoveOld : BOOL;
END_VAR

(* Reset event state *)
eMouseEvent := 0;
xEventActive := FALSE;

(* Handle left click events (single/double click) *)
IF xLeftClick AND NOT xLeftClickOld THEN
    IF iClickCount = 0 THEN
        LeftClickTimer(IN := TRUE, PT := tDblClickTime);
        iClickCount := 1;
    ELSE
        LeftClickTimer(IN := FALSE);
        eMouseEvent := 2; (* Double click *)
        rEventX := rMouseX;
        rEventY := rMouseY;
        xEventActive := TRUE;
        iClickCount := 0;
        xEventProcessed := TRUE;
    END_IF
ELSIF NOT xLeftClick AND xLeftClickOld THEN
    IF iClickCount = 1 AND NOT xEventProcessed THEN
        LeftClickTimer();
        IF NOT LeftClickTimer.Q THEN
            (* Waiting for potential double click *)
        END_IF
    END_IF
END_IF

IF LeftClickTimer.Q AND iClickCount = 1 THEN
    eMouseEvent := 1; (* Single click *)
    rEventX := rMouseX;
    rEventY := rMouseY;
    xEventActive := TRUE;
    iClickCount := 0;
END_IF

(* Handle right click events *)
IF xRightClick AND NOT xRightClickOld THEN
    eMouseEvent := 3; (* Right click *)
    rEventX := rMouseX;
    rEventY := rMouseY;
    xEventActive := TRUE;
END_IF

(* Handle middle click events *)
IF xMiddleClick AND NOT xMiddleClickOld THEN
    eMouseEvent := 4; (* Middle click *)
    rEventX := rMouseX;
    rEventY := rMouseY;
    xEventActive := TRUE;
END_IF

(* Handle mouse movement events *)
IF xMouseMove AND NOT xMouseMoveOld THEN
    eMouseEvent := 0; (* Mouse movement does not trigger an event type *)
    rEventX := rMouseX;
    rEventY := rMouseY;
    xEventActive := TRUE;
END_IF

(* Update old states *)
xLeftClickOld := xLeftClick;
xRightClickOld := xRightClick;
xMiddleClickOld := xMiddleClick;
xMouseMoveOld := xMouseMove;
END_FUNCTION_BLOCK
