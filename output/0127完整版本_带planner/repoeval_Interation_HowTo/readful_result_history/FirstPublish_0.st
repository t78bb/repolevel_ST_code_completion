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
    publishTopic: STRING := 'TestTopic/FromCodesys';
    publishQoS: MQTT.QoS := MQTT.QoS.ExactlyOnce;
    publishResult: BOOL;
END_VAR

IF NOT init THEN
    init := TRUE;
    publisher.SetMqttInOut(MQTT_IN_OUT := HowTo.MQTT_IN_OUT);
END_IF

IF MQTT_IN_OUT.clientFB.Connected THEN
    IF MQTT_IN_OUT.clientFB.ENABLE THEN
        publisher(
            Topic := ADR(publishTopic), 
            PayloadString := ADR(sendPayload), 
            PublishAsString := TRUE, 
            QoSIn := publishQoS, 
            MRetain := FALSE, 
            send := doPublish
        );
        publishResult := publisher.Done;
        IF NOT publishResult THEN
            // Handle publish failure (e.g., set an error flag or trigger error handling logic)
        END_IF
    END_IF
END_IF
END_FUNCTION_BLOCK
