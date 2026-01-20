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
// Simplify reset logic
    LeftClickTimer(IN := FALSE); // Keep, but ensure timer conditions are respected elsewhere
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
LeftClickTimer(IN := FALSE); // Simplified reset; PT remains unchanged
        IF NOT LeftClickTimer.Q THEN
            (* Still waiting for potential double click *)
            (* Will be handled by timer logic below *)
        END_IF
    END_IF
END_IF

(* Check for double click timeout *)
IF LeftClickTimer.Q AND iClickCount = 1 THEN
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
IF xMouseMove THEN
    eMouseEvent := 0; (* Mouse movement does not trigger an event *)
    rEventX := rMouseX;
    rEventY := rMouseY;
    xEventActive := FALSE;
END_IF

(* Update old state *)
xLeftClickOld := xLeftClick;
END_FUNCTION_BLOCK