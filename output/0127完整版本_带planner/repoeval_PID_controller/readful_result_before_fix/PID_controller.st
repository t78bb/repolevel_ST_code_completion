//***************************************************************
//* A simple PID controller for Codesys.
//* by Alexander Jaworowski
//* Inspiration from https://github.com/br3ttb/Arduino-PID-Library
//* https://github.com/alexjaw/PID_controller
//* This Library is licensed under a MIT License
//
// 2015-02-22	Bug fix in the calculation of CO_I.
//				Added derivative term (d(err)/dt = -d(PV)/dt, i.e.
//				derivative on measurements
//***************************************************************
FUNCTION_BLOCK PID_controller
VAR_INPUT
	SP : REAL;
	PV : REAL;
	Kc : REAL;
	Ti : REAL;
	Td : REAL;
	SampleTime: TIME; //Should be ~0.1 * Tp, Tp : the process time [http://www.controlguru.com/2007/012807.html]
	LowerLimit: REAL;
	UpperLimit: REAL;
END_VAR
VAR_OUTPUT
	CO: REAL; //Controller Output
	CO_P: REAL; //Prportional term
	CO_I: REAL; //Integral term
	CO_D: REAL; //Derivative term
END_VAR
VAR CONSTANT
	millis: UINT := 1000;
END_VAR
VAR
    e: REAL; // Error
    deltaPV: REAL; // Change in process variable
    SampleTimeSec: REAL; // Sample time in seconds
    CO_temp: REAL; // Temporary control output
END_VAR

// Convert SampleTime from TIME to seconds
SampleTimeSec := REAL_TO_TIME(SampleTime) / millis;

// Step 1: Calculate error
e := SP - PV;

// Step 2: Calculate proportional term
CO_P := Kc * e;

// Step 3: Update and limit integral term
CO_I := CO_I + (Kc * e * (SampleTimeSec / Ti));
IF CO_I > UpperLimit THEN
    CO_I := UpperLimit;
ELSIF CO_I < LowerLimit THEN
    CO_I := LowerLimit;
END_IF

// Step 4: Calculate derivative term
deltaPV := PV - lastTime;
CO_D := -Kc * Td * (deltaPV / SampleTimeSec);

// Step 5: Calculate total control output and limit it
CO_temp := CO_P + CO_I + CO_D;
IF CO_temp > UpperLimit THEN
    CO := UpperLimit;
ELSIF CO_temp < LowerLimit THEN
    CO := LowerLimit;
ELSE
    CO := CO_temp;
END_IF

// Step 6: Save current PV for next cycle
lastTime := PV;
END_FUNCTION_BLOCK
