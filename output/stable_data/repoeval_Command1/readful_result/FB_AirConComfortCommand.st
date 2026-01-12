VAR
    refAirConditioning : REFERENCE TO FB_AirConditioning;
END_VAR

METHOD Execute : BOOL
VAR
    bSuccess : BOOL;
END_VAR

bSuccess := FALSE;

IF (__ISVALIDREF(refAirConditioning)) THEN
    refAirConditioning.Activate();
    refAirConditioning.SetTemperature(20.0);
    bSuccess := TRUE;
END_IF;

Execute := bSuccess;