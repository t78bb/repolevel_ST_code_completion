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
 // Initialization is complete without using publisher.SetMqttInOut
END_IF

// Execution logic proceeds without publisher function call
END_FUNCTION_BLOCK