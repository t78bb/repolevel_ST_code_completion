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
	lastErr: REAL := 0; //Previous error
	integral: REAL := 0; //Integral accumulator
	deltaTime: REAL := 0; //Time difference in seconds
	deltaPV: REAL := 0; //Change in process variable
END_VAR

now := TIME(); //Get current time
deltaTime := REAL_TO_TIME((now - lastTime)) / millis; //Calculate elapsed time in seconds

IF deltaTime >= REAL_TO_TIME(SampleTime) THEN
	// Calculate error
	err := SP - PV;

	// Proportional term
	CO_P := Kc * err;

	// Integral term with anti-windup
	integral := integral + (err * deltaTime);
	IF integral > UpperLimit THEN
		integral := UpperLimit;
	ELSIF integral < LowerLimit THEN
		integral := LowerLimit;
	END_IF;
	CO_I := (Kc / Ti) * integral;

	// Derivative term
	deltaPV := PV - lastErr;
	CO_D := -(Kc * Td * deltaPV / deltaTime);

	// Compute total output
	CO := CO_P + CO_I + CO_D;

	// Apply output limits
	IF CO > UpperLimit THEN
		CO := UpperLimit;
	ELSIF CO < LowerLimit THEN
		CO := LowerLimit;
	END_IF;

	// Update last values
	lastErr := PV;
	lastTime := now;
END_IF;
END_FUNCTION_BLOCK
