FUNCTION_BLOCK FirstPublish
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR

VAR
    publisher: MQTT.MQTTPublish;
    init: BOOL;
END_VAR

IF NOT init THEN
    init := TRUE;
    publisher.SetMqttInOut(MQTT_IN_OUT := HowTo.MQTT_IN_OUT);
END_IF

publisher(
    Publish := TRUE,
    Topic := ADR('TestTopic/FromCodesys'),
    Payload := ADR('Hello from Codesys!'),
    QoSPublish := MQTT.QoS.ExactlyOnce,
    Retain := FALSE);
END_FUNCTION_BLOCK