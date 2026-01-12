FUNCTION_BLOCK MQTT_STUFF
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR

VAR
    HomeInstance: Home;
    MQTTClient: MQTT.MQTTClient;
    MQTTState: MQTT.MQTTState;
    InitDone: BOOL;
END_VAR

// Initialization of MQTT client and Home instance
IF NOT InitDone THEN
    InitDone := TRUE;

    // Initialize MQTT client
    MQTTClient.Init(
        ClientID := ADR('HomeAutomationClient'),
        BrokerAddress := ADR('mqtt://broker.hivemq.com'),
        Port := 1883,
        KeepAlive := T#60S,
        CleanSession := TRUE
    );

    // Connect to MQTT broker
    MQTTClient.Connect();

    // Initialize Home instance
    HomeInstance();
END_IF

// Publish the state of the home to the MQTT broker
MQTTState.Init(
    State := ADR(HomeInstance),
    Topic := ADR('home/automation/state'),
    MQTT_IN_OUT := GVL_MQTT.MQTT_IN_OUT,
    QoS := SD_MQTT.QoS.AtLeastOnce,
    RetainMqtt := TRUE
);

// Process MQTT client communication
MQTTClient.Cyclic();