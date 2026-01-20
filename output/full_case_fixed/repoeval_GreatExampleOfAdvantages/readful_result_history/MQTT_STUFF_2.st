FUNCTION_BLOCK MQTT_STUFF
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
    Subscriber: MQTT.MQTTSubscribe;
    init: BOOL;
    InstanceName: CommonTypesAndFunctions.GetInstanceName;
    SubscribeTopic: STRING(255);
    birthTopic: STRING(255);
    found: DINT;
    pt: POINTER TO STRING;
    birthMessage: MQTT.MQTTPublish;
    connectRising: R_TRIG;
    xxx: POINTER TO STRING;
END_VAR

IF NOT init THEN
    init := TRUE;
    Subscriber.SetMqttInOut(MQTT_IN_OUT := GVL_MQTT.MQTT_IN_OUT);
    SubscribeTopic := InstanceName.GetInstanceTopic();
    birthTopic := SubscribeTopic;
    found := CommonTypesAndFunctions.find(str1 := ADR(SubscribeTopic), str2 := ADR('/'));
    found := found + 1 + CommonTypesAndFunctions.find(str1 := ADR(SubscribeTopic[found + 1]), str2 := ADR('/'));
// Use the CONCAT function to modify SubscribeTopic directly
  SubscribeTopic := CONCAT(LEFT(SubscribeTopic, found), 'Receive/#');
// Ensure proper concatenation of ClientID with a valid string conversion for the tick value
  GVL_MQTT.MQTT_IN_OUT.ClientID := CONCAT('CodesysMqtt', TO_STRING(TICKS.GetTick()));
END_IF

GVL_MQTT.MQTT_IN_OUT.clientFB(
    MQTT_IN_OUT := GVL_MQTT.MQTT_IN_OUT,
    xConnect := TRUE
);

connectRising(CLK := GVL_MQTT.MQTT_IN_OUT.xConnected);

IF connectRising.Q THEN
    birthMessage.SetMqttInOut(MQTT_IN_OUT := GVL_MQTT.MQTT_IN_OUT);
    birthMessage.Topic := CONCAT(birthTopic, '/Birth');
    birthMessage.Payload := 'Connected';
    birthMessage.QoS := 0;
    birthMessage.Retain := FALSE;
    birthMessage.Publish();
    Subscriber.Topic := SubscribeTopic;
    Subscriber.QoS := 0;
    Subscriber.Subscribe();
END_IF
END_FUNCTION_BLOCK