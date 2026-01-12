VAR
	bCouplePrev			:	BOOL;			// Previous state of bCouple
	fbStartRtrig		:	R_TRIG;			// Rising edge detection for bCouple
	fbStopRtrig			:	R_TRIG;			// Rising edge detection for decoupling
END_VAR

fbStartRtrig(CLK := bCouple);
fbStopRtrig(CLK := NOT bCouple);

IF fbStartRtrig.Q THEN
	// Start coupling process
	IF NOT bInGear THEN
		// Perform coupling
		Master.Axis := Master;
		Slave.Axis := Slave;
		Master.Acceleration := rAcceleration;
		Master.Deceleration := rDeceleration;
		Slave.Acceleration := rAcceleration;
		Slave.Deceleration := rDeceleration;
		Master.RatioNumerator := nRatioNumerator;
		Master.RatioDenominator := nRatioDenominator;
		bInGear := TRUE;
		bCouplingDone := TRUE;
		bDecouplingDone := FALSE;
		bError := FALSE;
		nErrorID := 0;
	END_IF;
ELSIF fbStopRtrig.Q THEN
	// Start decoupling process
	IF bInGear THEN
		// Perform decoupling
		bInGear := FALSE;
		bCouplingDone := FALSE;
		bDecouplingDone := TRUE;
		bError := FALSE;
		nErrorID := 0;
	END_IF;
END_IF;

IF bError THEN
	// Handle error condition
	bInGear := FALSE;
	bCouplingDone := FALSE;
	bDecouplingDone := FALSE;
	nErrorID := 16#0001; // Example error code
END_IF;