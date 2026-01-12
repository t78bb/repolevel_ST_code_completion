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
    Error: REAL;
    PrevError: REAL := 0;
    Integral: REAL := 0;
    Derivative: REAL;
    DeltaTime: REAL;
    PrevPV: REAL := 0;
END_VAR

DeltaTime := TO_REAL(SampleTime) / TO_REAL(millis);

Error := SP - PV;

// Proportional term
CO_P := Kc * Error;

// Integral term
Integral := Integral + (Error * DeltaTime);
CO_I := (Kc / Ti) * Integral;

// Derivative term
Derivative := -(PV - PrevPV) / DeltaTime;
CO_D := Kc * Td * Derivative;

// Calculate Controller Output
CO := CO_P + CO_I + CO_D;

// Apply output limits
IF CO > UpperLimit THEN
    CO := UpperLimit;
ELSIF CO < LowerLimit THEN
    CO := LowerLimit;
END_IF;

// Update previous values
PrevError := Error;
PrevPV := PV;
