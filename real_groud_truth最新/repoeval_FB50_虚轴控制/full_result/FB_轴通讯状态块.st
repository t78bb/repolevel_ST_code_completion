FUNCTION_BLOCK FB_轴通讯状态块
VAR_INPUT
	Axis_bCommunication: BOOL;
	Axis_wCommunicationState: WORD;
END_VAR
VAR_OUTPUT
	EtherCATBusOK: BOOL;
END_VAR

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
END_FUNCTION_BLOCK