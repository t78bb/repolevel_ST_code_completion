// AJ Jaworowski 2015-02-23
// Following the presentation on
// http://openenergymonitor.org/emon/node/2999
FUNCTION_BLOCK HeatExchanger2
VAR_INPUT
	Heat_In:		REAL;		//In principle a radiator in the room [W]
	U:				REAL;		//Thermal conductance [W/K]
	TC:				REAL;		//Thermal capacity [J/K], commonly cv, specific heat capacity [J/kgK]
								//we use a smaller value than in reality, so that we can see changes
								//during a life-time...
	Temp_In:		REAL;		//Start temperature in the room [K]
	Temp_Out:		REAL;		//Outside temperature [K] 
	Sample_time:	TIME;
END_VAR
VAR_OUTPUT
	Temp:			REAL;		//The resulting room temperature
END_VAR
VAR
	now: TIME;
	lastTime: TIME := T#0s;
	delta_t: REAL;
	heat_flow: REAL;
	lastTemp: REAL;
END_VAR
VAR CONSTANT
	millis: REAL := 1000;
END_VAR

now := SysTimeRtc.SysTimeGetms(); // Use SysTimeRtc library to get time in milliseconds
IF ((now - lastTime) > TO_LREAL(Sample_time)) THEN // Convert Sample_time to LREAL for comparison
  delta_t := LREAL_TO_REAL(TO_LREAL(now - lastTime) / millis);  // Ensure all arithmetic is consistent
  heat_flow := Heat_In + U * (Temp_Out - Temp_In);
  Temp := Temp_In + (heat_flow / TC) * delta_t;
  lastTime := now;
END_IF;
END_FUNCTION_BLOCK