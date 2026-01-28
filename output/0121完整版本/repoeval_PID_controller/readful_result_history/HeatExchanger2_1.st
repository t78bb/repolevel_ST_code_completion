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

now := TIME();
IF ((now - lastTime) > Sample_time) THEN
delta_t := TO_REAL(DWORD_TO_TIME(DWORD(now - lastTime))) / 1000; // Convert TIME difference to seconds as REAL
	lastTime := now;

	// Calculate heat flow based on thermal conductance and temperature difference
	heat_flow := U * (Temp_Out - Temp_In);

	// Update temperature using heat input, heat flow, and thermal capacity
	Temp := Temp_In + ((Heat_In - heat_flow) * delta_t / TC);

	// Store the last temperature for reference
	lastTemp := Temp;
END_IF;
END_FUNCTION_BLOCK