VAR
    publisher: MQTT.MQTTPublish;
    init: BOOL;
END_VAR

IF NOT init THEN
    init := TRUE;
    publisher.SetMqttInOut(MQTT_IN_OUT:= HowTo.MQTT_IN_OUT);
END_IF

publisher(
    Publish:= TRUE,
    Topic:= ADR('TestTopic/FromCodesys'),
    Message:= ADR('Hello from Codesys!'),
    QoSPublish:= MQTT.QoS.ExactlyOnce);
```

This code defines a `FirstPublish` function block that initializes an MQTT publisher and publishes a message to a specified topic. The `init` variable ensures that the publisher is set up only once. The `publisher` function block is configured to publish a message with a quality of service level of "ExactlyOnce" to the topic `'TestTopic/FromCodesys'`.