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