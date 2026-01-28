VAR
    LeftClickTimer : TON;
    xLeftClickOld : BOOL;
    iClickCount : INT := 0;
    xEventProcessed : BOOL := FALSE;
    rLastMouseX : REAL := 0.0;
    rLastMouseY : REAL := 0.0;
END_VAR

(* Reset event state *)
eMouseEvent := 0;
xEventActive := FALSE;

(* Handle left click events (single/double click) *)
IF xLeftClick AND NOT xLeftClickOld THEN
    (* First click detected *)
    IF iClickCount = 0 THEN
        LeftClickTimer(IN := TRUE, PT := tDblClickTime);
        iClickCount := 1;
    ELSE
        (* Second click within time window *)
        LeftClickTimer(IN := FALSE);
        eMouseEvent := 2; (* Double click *)
        rEventX := rMouseX;
        rEventY := rMouseY;
        xEventActive := TRUE;
        iClickCount := 0;
        xEventProcessed := TRUE;
    END_IF
ELSIF NOT xLeftClick AND xLeftClickOld THEN
    (* Left button released *)
    IF iClickCount = 1 AND NOT xEventProcessed THEN
        LeftClickTimer();
        IF NOT LeftClickTimer.Q THEN
            (* Still waiting for potential double click *)
        ELSE
            (* Timeout, register single click *)
            eMouseEvent := 1; (* Single click *)
            rEventX := rMouseX;
            rEventY := rMouseY;
            xEventActive := TRUE;
            iClickCount := 0;
        END_IF
    END_IF
END_IF

(* Check for double click timeout *)
IF LeftClickTimer.Q AND iClickCount = 1 THEN
    (* Timeout, register single click *)
    eMouseEvent := 1; (* Single click *)
    rEventX := rMouseX;
    rEventY := rMouseY;
    xEventActive := TRUE;
    iClickCount := 0;
END_IF

(* Handle right click events *)
IF xRightClick THEN
    eMouseEvent := 3; (* Right click *)
    rEventX := rMouseX;
    rEventY := rMouseY;
    xEventActive := TRUE;
END_IF

(* Handle middle click events *)
IF xMiddleClick THEN
    eMouseEvent := 4; (* Middle click *)
    rEventX := rMouseX;
    rEventY := rMouseY;
    xEventActive := TRUE;
END_IF

(* Handle mouse movement events *)
IF xMouseMove AND (rMouseX <> rLastMouseX OR rMouseY <> rLastMouseY) THEN
    eMouseEvent := 0; (* Mouse move *)
    rEventX := rMouseX;
    rEventY := rMouseY;
    xEventActive := TRUE;
    rLastMouseX := rMouseX;
    rLastMouseY := rMouseY;
END_IF

(* Update old state *)
xLeftClickOld := xLeftClick;
END_FUNCTION_BLOCK
