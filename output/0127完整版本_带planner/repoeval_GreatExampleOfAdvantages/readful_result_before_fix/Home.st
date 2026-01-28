FUNCTION_BLOCK Home
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
    InternalState: INT;
    GroundFloorState: INT;
    TopFloorState: INT;
    MQTTMessage: STRING;
END_VAR

GroundFloor();
TopFloor();

IF InternalState = 0 THEN
    GroundFloorState := GroundFloor.LivingRoom.Lamp1Out + GroundFloor.LivingRoom.Lamp2Out + GroundFloor.LivingRoom.Lamp3Out;
    TopFloorState := TopFloor.MainBath.Lamp1Out + TopFloor.SleepingRoom.Lamp1Out;
    InternalState := 1;
END_IF

IF InternalState = 1 THEN
    IF GroundFloorState > 0 THEN
        MQTTMessage := 'Ground Floor Active';
    ELSIF TopFloorState > 0 THEN
        MQTTMessage := 'Top Floor Active';
    ELSE
        MQTTMessage := 'No Activity';
    END_IF
    InternalState := 2;
END_IF

IF InternalState = 2 THEN
    // Simulate sending MQTT message
    MQTT.CallbackCollector(MQTTMessage);
    InternalState := 3;
END_IF

IF InternalState = 3 THEN
    // Reset states for next operation
    GroundFloorState := 0;
    TopFloorState := 0;
    InternalState := 0;
END_IF
END_FUNCTION_BLOCK
