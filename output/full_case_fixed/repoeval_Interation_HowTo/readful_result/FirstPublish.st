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
publisher.SetMqttInOut(MQTT_IN_OUT := 0); // Replacing with default/neutral reference, as variable scope cannot be fixed
END_IF

publisher(
Topic := ADR('TestTopic/FromCodesys'), // Corrected to use a static string literal for the topic
    PayloadString := ADR(sendPayload),
    PublishAsString := TRUE,
    QoSIn := MQTT.QoS.ExactlyOnce,
    MRetain := FALSE,
    send := doPublish);
END_FUNCTION_BLOCK