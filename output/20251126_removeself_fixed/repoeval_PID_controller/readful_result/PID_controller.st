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
	err: REAL; // Error (SP - PV)
	prev_err: REAL; // Previous error
	integral: REAL; // Integral accumulator
	derivative: REAL; // Derivative term
	prev_PV: REAL; // Previous process variable
	dt: REAL; // Time step in seconds
END_VAR

// Initialization
IF NOT IS_INITIALIZED THEN
	prev_err := 0.0;
	integral := 0.0;
	prev_PV := PV;
	dt := REAL_TO_TIME(SampleTime) / millis;
	IS_INITIALIZED := TRUE;
END_IF

// Calculate error
err := SP - PV;

// Proportional term
CO_P := Kc * err;

// Integral term
integral := integral + (err * dt);
CO_I := (Kc / Ti) * integral;

// Derivative term
derivative := -(PV - prev_PV) / dt; // Derivative on measurement
CO_D := Kc * Td * derivative;

// Calculate controller output
CO := CO_P + CO_I + CO_D;

// Apply output limits
IF CO > UpperLimit THEN
	CO := UpperLimit;
ELSIF CO < LowerLimit THEN
	CO := LowerLimit;
END_IF

// Update previous values
prev_err := err;
prev_PV := PV;