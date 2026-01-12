VAR
    PUB1: MQTT.MQTTPublish;
    init: BOOL;
END_VAR

IF NOT init THEN
    init := TRUE;
    PUB1.SetMqttInOut(MQTT_IN_OUT := HowTo.MQTT_IN_OUT);
END_IF

PUB1(
    Publish := TRUE,
    Topic := ADR('TestTopic/FromCodesys'),
    QoSPublish := MQTT.QoS.ExactlyOnce,
    Payload := ADR('Hello from Codesys'),
    PayloadSize := SIZEOF('Hello from Codesys'),
    Retain := FALSE);