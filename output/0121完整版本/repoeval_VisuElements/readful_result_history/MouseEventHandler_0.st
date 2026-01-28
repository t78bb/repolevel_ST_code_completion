FUNCTION_BLOCK MouseEventHandler
VAR_INPUT
    xLeftClick : BOOL;      (* Left mouse button click *)
    xRightClick : BOOL;     (* Right mouse button click *)
    xMiddleClick : BOOL;    (* Middle mouse button click *)
    xMouseMove : BOOL;      (* Mouse movement detected *)
    rMouseX : REAL;         (* Current mouse X position *)
    rMouseY : REAL;         (* Current mouse Y position *)
    tDblClickTime : TIME := T#300MS;  (* Double click timeout *)
END_VAR

VAR_OUTPUT
    eMouseEvent : INT;      (* Event type: 0=None, 1=SingleClick, 2=DoubleClick, 3=RightClick, 4=MiddleClick *)
    rEventX : REAL;         (* X position where event occurred *)
    rEventY : REAL;         (* Y position where event occurred *)
    xEventActive : BOOL;    (* TRUE when an event is active *)
END_VAR
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
