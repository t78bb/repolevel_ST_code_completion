FUNCTION_BLOCK FirstPublish
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
    publisher: MQTT.MQTTPublish;
    doPublish: BOOL;
    init: BOOL;
    sendPayload: STRING := 'testPayload';
END_VAR

IF NOT init THEN
  init := TRUE;
  // Removed publisher.SetMqttInOut as 'publisher' has an unrecognized type
END_IF

// Removed 'publisher' function call as 'publisher' is undefined and unusable
END_FUNCTION_BLOCK