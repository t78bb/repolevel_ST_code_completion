FUNCTION_BLOCK MQTT_STUFF
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
    connectionStatus: BOOL;
    reconnectTimer: TON;
    messageReceived: BOOL;
    receivedMessage: STRING(255);
END_VAR

IF NOT init THEN
    init := TRUE;
    Subscriber.SetMqttInOut(MQTT_IN_OUT := GVL_MQTT.MQTT_IN_OUT);
    SubscribeTopic := InstanceName.GetInstanceTopic();
    birthTopic := SubscribeTopic;
    found := CommonTypesAndFunctions.find(str1 := ADR(SubscribeTopic), str2 := ADR('/'));
    found := found + 1 + CommonTypesAndFunctions.find(str1 := ADR(SubscribeTopic[found + 1]), str2 := ADR('/'));
    pt := ADR(SubscribeTopic[found + 1]);
    pt^ := 'Receive/#';
    GVL_MQTT.MQTT_IN_OUT.ClientID := CONCAT('CodesysMqtt', TO_STRING(TICKS.GetTick(xDummy := TRUE)));
END_IF

GVL_MQTT.MQTT_IN_OUT.clientFB(
    MQTT_IN_OUT := GVL_MQTT.MQTT_IN_OUT,
    xConnect := TRUE,
    xDisconnect := FALSE,
    xPublish := FALSE,
    xSubscribe := TRUE,
    xUnsubscribe := FALSE
);

connectionStatus := GVL_MQTT.MQTT_IN_OUT.clientFB.xConnected;

connectRising(CLK := connectionStatus);

IF connectRising.Q THEN
    birthMessage.SetMqttInOut(MQTT_IN_OUT := GVL_MQTT.MQTT_IN_OUT);
    birthMessage.SetTopic(Topic := birthTopic);
    birthMessage.SetPayload(Payload := 'Device Online');
    birthMessage.Publish();
END_IF

Subscriber.Subscribe(Topic := SubscribeTopic);

messageReceived := Subscriber.GetMessage(Topic := SubscribeTopic, Payload := receivedMessage);

IF messageReceived THEN
    // Handle received message (e.g., pass to Collector callback mechanism)
    xxx := ADR(receivedMessage);
END_IF

reconnectTimer(IN := NOT connectionStatus, PT := T#10S);

IF reconnectTimer.Q THEN
    GVL_MQTT.MQTT_IN_OUT.clientFB.xConnect := TRUE;
END_IF
END_FUNCTION_BLOCK
