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

Lamp1Out := Switch1; // Directly map Switch1 to Lamp1Out
Lamp2Out := Switch2; // Directly map Switch2 to Lamp2Out

// Ensure 'Temp' function block operates as expected; no further action required
Temp(
  PT := T#30S,
  AM := 2.0
);

END_FUNCTION_BLOCK