VAR
    subscriber: MQTT.MQTTSubscribe;
    init: BOOL;
    receivedPayload: STRING(255);
    newMessage: BOOL;
END_VAR

IF NOT init THEN
    init := TRUE;
    subscriber.SetMqttInOut(MQTT_IN_OUT := HowTo.MQTT_IN_OUT);
END_IF;

subscriber(
    Topic := ADR('TestTopic/FromCodesys'),
    QoSIn := MQTT.QoS.ExactlyOnce,
    Subscribe := TRUE,
    MessageReceived := newMessage,
    PayloadString := ADR(receivedPayload)
);