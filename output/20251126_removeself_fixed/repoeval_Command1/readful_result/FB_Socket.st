FUNCTION_BLOCK PUBLIC FB_Socket
VAR_OUTPUT
	bActive		: BOOL;
END_VAR

VAR
    fbSocketOnCommand  : FB_SocketOnCommand;
    fbSocketOffCommand : FB_SocketOffCommand;
END_VAR

METHOD PUBLIC Activate
VAR_OUTPUT
    bResult : BOOL;
END_VAR
bResult := FALSE;

fbSocketOnCommand.refSocket := THIS^;
fbSocketOnCommand.On();
bActive := fbSocketOnCommand.bActive;

IF bActive THEN
    bResult := TRUE;
END_IF

METHOD PUBLIC Deactivate
VAR_OUTPUT
    bResult : BOOL;
END_VAR
bResult := FALSE;

fbSocketOffCommand.refSocket := THIS^;
fbSocketOffCommand.Off();
bActive := fbSocketOffCommand.bActive;

IF NOT bActive THEN
    bResult := TRUE;
END_IF