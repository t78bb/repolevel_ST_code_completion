FUNCTION_BLOCK MQTT_STUFF
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR

VAR
    Lamp1: LampBase;
    Lamp2: LampBase;
    Switch1: BOOL;
    Switch2: BOOL;
    Lamp1Out: BOOL;
    Lamp2Out: BOOL;
    Temp: OSCAT_BASIC.GEN_SIN;
END_VAR

Lamp1(SwitchIn := Switch1, LampOut => Lamp1Out);
Lamp2(SwitchIn := Switch2, LampOut => Lamp2Out);

Temp(
    PT := T#30S,
    AM := 2.0
);

END_FUNCTION_BLOCK
