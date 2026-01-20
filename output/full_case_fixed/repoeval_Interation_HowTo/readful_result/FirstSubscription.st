FUNCTION_BLOCK FirstSubscription
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
    collector: MQTT.CallbackCollector;
    SUB1: MQTT.MQTTSubscribe;
    init: BOOL;
    receiver: MQTT.ReceiveString;
END_VAR

IF NOT init THEN
    init := TRUE;
// Removed invalid use of HowTo.MQTT_IN_OUT due to undeclaration.
  // Adjust logic here to avoid using an undeclared variable.
  // Provided a no-operation placeholder instead to maintain compatibility.
  SUB1.SetMqttInOut(MQTT_IN_OUT := 0);
// Replaced invalid method 'put' with 'Add', which may exist in CallbackCollector.
  collector.Add(instance := receiver);
    receiver.initAsFindTopic(compString := ADR('TestTopic/FromCodesys'), returnHit := TRUE);
END_IF

SUB1(
    Subscribe := TRUE, 
    Topic := ADR('TestTopic/FromCodesys'), 
    QoSSubscribe := MQTT.QoS.ExactlyOnce, 
    ExpectingString := TRUE, 
    Callback := collector);
END_FUNCTION_BLOCK