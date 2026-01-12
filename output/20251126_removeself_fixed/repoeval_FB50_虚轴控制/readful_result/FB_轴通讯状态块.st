FUNCTION_BLOCK FB_轴通讯状态块
VAR_INPUT
	Axis_bCommunication: BOOL;
	Axis_wCommunicationState: WORD;
END_VAR
VAR_OUTPUT
	EtherCATBusOK: BOOL;
END_VAR

VAR
	CommunicationError: BOOL;
END_VAR

IF Axis_bCommunication THEN
    IF Axis_wCommunicationState = 0 THEN
        EtherCATBusOK := TRUE;
        CommunicationError := FALSE;
    ELSE
        EtherCATBusOK := FALSE;
        CommunicationError := TRUE;
    END_IF
ELSE
    EtherCATBusOK := FALSE;
    CommunicationError := TRUE;
END_IF