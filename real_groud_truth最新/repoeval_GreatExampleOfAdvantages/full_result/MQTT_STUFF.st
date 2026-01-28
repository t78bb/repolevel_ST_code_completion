FUNCTION_BLOCK MQTT_STUFF
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR

VAR
    MQTTClient: MQTTClientBase;
    Topic: STRING;
    Payload: STRING;
    Connected: BOOL;
END_VAR

// Initialize MQTT client
MQTTClient(
    BrokerAddress := 'mqtt://broker.hivemq.com',
    Port := 1883,
    ClientID := 'HomeAutomationSystem',
    Connected => Connected
);

// Publish a message to a topic
IF Connected THEN
    Topic := 'home/automation/status';
    Payload := 'System is online';
    MQTTClient.Publish(Topic := Topic, Payload := Payload);
END_IF;

// Subscribe to a topic
MQTTClient.Subscribe(Topic := 'home/automation/commands');

// Handle incoming messages
IF MQTTClient.NewMessage THEN
    Topic := MQTTClient.ReceivedTopic;
    Payload := MQTTClient.ReceivedPayload;

    // Process the received message
    CASE Topic OF
        'home/automation/commands/lights':
            // Handle light control commands
        'home/automation/commands/temperature':
            // Handle temperature control commands
        ELSE
            // Handle other commands
    END_CASE;
END_IF;
END_FUNCTION_BLOCK