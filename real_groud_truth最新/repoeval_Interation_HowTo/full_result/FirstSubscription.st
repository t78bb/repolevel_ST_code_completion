FUNCTION_BLOCK FirstSubscription
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR

VAR
    subscriber: MQTT.MQTTSubscribe;
    init: BOOL;
    receivedPayload: STRING;
    doSubscribe: BOOL;
END_VAR

IF NOT init THEN
    init := TRUE;
    subscriber.SetMqttInOut(MQTT_IN_OUT := HowTo.MQTT_IN_OUT);
END_IF

subscriber(
    Topic := ADR('TestTopic/FromCodesys'),
    PayloadString := ADR(receivedPayload),
    SubscribeAsString := TRUE,
    QoSIn := MQTT.QoS.ExactlyOnce,
    send := doSubscribe);
END_FUNCTION_BLOCK