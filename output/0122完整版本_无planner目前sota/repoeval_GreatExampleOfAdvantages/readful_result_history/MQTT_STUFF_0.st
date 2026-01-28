FUNCTION_BLOCK MQTT_STUFF
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
    isConnected: BOOL;
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

connectRising(CLK := GVL_MQTT.MQTT_IN_OUT.IsConnected);
isConnected := connectRising.Q;

IF isConnected THEN
    birthMessage.SetMqttInOut(MQTT_IN_OUT := GVL_MQTT.MQTT_IN_OUT);
    birthMessage.Topic := CONCAT(birthTopic, '/Birth');
    birthMessage.Payload := 'Device Connected';
    birthMessage.QoS := 0;
    birthMessage.Retain := TRUE;
    birthMessage.Publish();
    Subscriber.Topic := SubscribeTopic;
    Subscriber.Enable := TRUE;
    Subscriber.Subscribe();
END_IF
END_FUNCTION_BLOCK
