VAR
	collector: MQTT.CallbackCollector;
	SUB1: MQTT.MQTTSubscribe;
	init: BOOL;
	receiver: MQTT.ReceiveString;
	subscriptionFailed: BOOL;
	retryTimer: TON;
END_VAR

IF NOT init THEN
	init := TRUE;
	SUB1.SetMqttInOut(MQTT_IN_OUT := HowTo.MQTT_IN_OUT);
	collector.put(instance := receiver);
	receiver.initAsFindTopic(compString := ADR('TestTopic/FromCodesys'), returnHit := TRUE);
	retryTimer(IN := FALSE, PT := T#5S);
END_IF

SUB1(
	Subscribe := TRUE, 
	Topic := ADR('TestTopic/FromCodesys'), 
	QoSSubscribe := MQTT.QoS.ExactlyOnce, 
	ExpectingString := TRUE, 
	Callback := collector);

IF NOT SUB1.Success THEN
	subscriptionFailed := TRUE;
	retryTimer(IN := TRUE);
ELSE
	subscriptionFailed := FALSE;
	retryTimer(IN := FALSE);
END_IF

IF subscriptionFailed AND retryTimer.Q THEN
	SUB1(
		Subscribe := TRUE, 
		Topic := ADR('TestTopic/FromCodesys'), 
		QoSSubscribe := MQTT.QoS.ExactlyOnce, 
		ExpectingString := TRUE, 
		Callback := collector);
	retryTimer(IN := FALSE);
END_IF
END_FUNCTION_BLOCK
