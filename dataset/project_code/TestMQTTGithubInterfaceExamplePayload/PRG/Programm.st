PROGRAM Programm
VAR
	//first reciver for MQTT String
	String1:StringReciver;
	//second
	String2:StringReciver;
	//....
	String3:StringReciver;
	String4:StringReciver;
	String5:StringReciver;
	
	//a Array of recivers...
	
	Strings:ARRAY[0..9] OF StringReciver;
	
	var1:ValueReciver;
	
	//the collector
	Collector:MQTT.CallbackCollector;
	MQTT_IN_OUT:MQTT.MQTT_IN_OUT;
	//your special client id
	ClientID:STRING;
	
	
	//some FBs for publishing data
	states:ARRAY[0..20] OF MQTT.MQTTState;
	
	subscriber:MQTT.MQTTSubscribe;
	
	init: BOOL;
	i:UINT;
	t1:ton;
	t2:ton;
END_VAR

IF NOT init THEN
	init := TRUE;
	//collect all callbacks...
	
	Collector.put(String1);
	Collector.put(String2);
	Collector.put(String3);
	Collector.put(String4);
	Collector.put(String5);
	Collector.put(var1);
	FOR i := 0 TO 9 DO
		Collector.put(Strings[i]);
	END_FOR
	//now Collector can be passed do a subscription FB
	
	ClientID := CONCAT('CodesysMqtt',TO_STRING(TICKS.GetTick(xDummy:= TRUE)));
	MQTT_IN_OUT.ClientID := ClientID;
	subscriber.SetMqttInOut(MQTT_IN_OUT:= MQTT_IN_OUT);
	
	//no init the send State FB with some useles stuff to send
	
	(*Target String1()*)
	states[0].Init(
	State:= ADR(t1.Q), 
	Topic:= ADR('SD-MQTT-TestInterface/Interfaces/Vars'), (*here place the name of you instance*) 
	StateValueOn:= ADR('String1:Payload on instance String 1'), 
	StateValueOff:= ADR('String1:Payload off instance String 1'), 
	MQTT_IN_OUT:= MQTT_IN_OUT, 
	QoS:= MQTT.QoS.ExactlyOnce,
	RetainMqtt:= FALSE,
	StateName:= ADR(''));
	(*Target String2()*)
	states[1].Init(
	State:= ADR(t1.Q), 
	Topic:= ADR('SD-MQTT-TestInterface/Interfaces/Vars'), (*here place the name of you instance*) 
	StateValueOn:= ADR('String2:Payload high instance String 2'), 
	StateValueOff:= ADR('String2:Payload low instance String 2'), 
	MQTT_IN_OUT:= MQTT_IN_OUT, 
	QoS:= MQTT.QoS.ExactlyOnce,
	RetainMqtt:= FALSE,
	StateName:= ADR(''));
	(*Target String3()*)
	states[2].Init(
	State:= ADR(t1.Q), 
	Topic:= ADR('SD-MQTT-TestInterface/Interfaces/Vars'), (*here place the name of you instance*) 
	StateValueOn:= ADR('String3:Payload true instance String 3'), 
	StateValueOff:= ADR('String3:Payload false instance String 3'), 
	MQTT_IN_OUT:= MQTT_IN_OUT, 
	QoS:= MQTT.QoS.ExactlyOnce,
	RetainMqtt:= FALSE,
	StateName:= ADR(''));
	(*Target String4()*)
	states[3].Init(
	State:= ADR(t1.Q), 
	Topic:= ADR('SD-MQTT-TestInterface/Interfaces/Vars'), (*here place the name of you instance*) 
	StateValueOn:= ADR('String4:Payload RUN instance String 4'), 
	StateValueOff:= ADR('String4:Payload STOP instance String 4'), 
	MQTT_IN_OUT:= MQTT_IN_OUT, 
	QoS:= MQTT.QoS.ExactlyOnce,
	RetainMqtt:= FALSE,
	StateName:= ADR(''));
	(*Target String4()*)
	states[4].Init(
	State:= ADR(t1.Q), 
	Topic:= ADR('SD-MQTT-TestInterface/Interfaces/Vars'), (*here place the name of you instance*) 
	StateValueOn:= ADR('String5:Payload Walk instance String 5'), 
	StateValueOff:= ADR('String5:Payload dont walk instance String 5'), 
	MQTT_IN_OUT:= MQTT_IN_OUT, 
	QoS:= MQTT.QoS.ExactlyOnce,
	RetainMqtt:= FALSE,
	StateName:= ADR(''));
	
	
	(*Target Strings[0]()*)
	states[5].Init(
	State:= ADR(t1.Q), 
	Topic:= ADR('SD-MQTT-TestInterface/Interfaces/Vars'), (*here place the name of you instance*) 
	StateValueOn:= ADR('Strings[0]:Payload on instance Strings [0]'), 
	StateValueOff:= ADR('Strings[0]:Payload off instance Strings [0]'), 
	MQTT_IN_OUT:= MQTT_IN_OUT, 
	QoS:= MQTT.QoS.ExactlyOnce,
	RetainMqtt:= FALSE,
	StateName:= ADR(''));
	(*Target Strings[1]*)
	states[6].Init(
	State:= ADR(t1.Q), 
	Topic:= ADR('SD-MQTT-TestInterface/Interfaces/Vars'), (*here place the name of you instance*) 
	StateValueOn:= ADR('Strings[1]:Payload true instance Strings [1]'), 
	StateValueOff:= ADR('Strings[1]:Payload false instance Strings [1]'), 
	MQTT_IN_OUT:= MQTT_IN_OUT, 
	QoS:= MQTT.QoS.ExactlyOnce,
	RetainMqtt:= FALSE,
	StateName:= ADR(''));
	(*Target Strings[2]*)
	states[7].Init(
	State:= ADR(t1.Q), 
	Topic:= ADR('SD-MQTT-TestInterface/Interfaces/Vars'), (*here place the name of you instance*) 
	StateValueOn:= ADR('Strings[2]:Payload one instance Strings [2]'), 
	StateValueOff:= ADR('Strings[2]:Payload zero instance Strings [2]'), 
	MQTT_IN_OUT:= MQTT_IN_OUT, 
	QoS:= MQTT.QoS.ExactlyOnce,
	RetainMqtt:= FALSE,
	StateName:= ADR(''));
	
	(*Target var1*)
	states[8].Init(
	State:= ADR(t1.Q), 
	Topic:= ADR('SD-MQTT-TestInterface/Interfaces/Vars'), (*here place the name of you instance*) 
	StateValueOn:= ADR('var1:1234.5678'), 
	StateValueOff:= ADR('var1:8765.4321'), 
	MQTT_IN_OUT:= MQTT_IN_OUT, 
	QoS:= MQTT.QoS.ExactlyOnce,
	RetainMqtt:= FALSE,
	StateName:= ADR(''));
	
	
END_IF

MQTT_IN_OUT.clientFB(
	MQTT_IN_OUT:= MQTT_IN_OUT, 
	ENABLE:= TRUE, 
	URL:= 'test.mosquitto.org', 
	TIMEOUT:= T#5S);


	
subscriber(
	Subscribe:= TRUE, 
	Topic:= ADR('SD-MQTT-TestInterface/Interfaces/Vars'), 
	QoSSubscribe:= MQTT.QoS.ExactlyOnce, 
	ExpectingString:= TRUE, 
	Callback:= Collector,
	);
//make a clock pulse...
t1(IN := NOT t2.Q, PT:= T#2S);
t2(IN := t1.Q, PT:= T#2S);

//here call of your FBs implementing the interface...
String1();
String2();
String3();
String4();
String5();
var1();
FOR i := 0 TO 9 DO
	Strings[i]();
END_FOR


//herre just call all states
FOR i := 0 TO 20 DO
	states[i]();
END_FOR