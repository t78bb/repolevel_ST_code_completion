VAR
	AxisCommunicationStatus: BOOL;
END_VAR

IF Axis_bCommunication THEN
	IF Axis_wCommunicationState = 16#0008 THEN
		EtherCATBusOK := TRUE;
	ELSE
		EtherCATBusOK := FALSE;
	END_IF;
ELSE
	EtherCATBusOK := FALSE;
END_IF;