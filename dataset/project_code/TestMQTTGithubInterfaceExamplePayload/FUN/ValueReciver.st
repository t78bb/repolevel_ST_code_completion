//this FB makes a lreal var out of MQTT payload
//this is needed for FBinstance name in Variable
{attribute 'reflection'}
FUNCTION_BLOCK ValueReciver IMPLEMENTS MQTT.MQTT_SUBSCRIBE_CALLBACK
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
	//from this instance i can get my value...
	MQTTValue:MQTT.ReceiveValue;
	init: BOOL;
	{attribute 'instance-path'}
	{attribute 'noinit'}
	instanceName: STRING(255);//this string contains the instance name of the FB
	//here we get the "lowest" element of the name...
	LastTreeName:STRING;
	StringPointer:POINTER TO STRING;
END_VAR

IF NOT init THEN
	init := TRUE;
	StringPointer := CommonTypesAndFunctions.FindLastDot(ADR(instanceName));
	
	StringPointer := StringPointer + SIZEOF(BYTE);
	
	LastTreeName := StringPointer^;
	MQTTValue.initAsFindPayload(compString:=ADR(LastTreeName), returnHit:= TRUE, ValueTyp:= IBaseLibrary.TYPE_LREAL, splitChar:= ':');
END_IF