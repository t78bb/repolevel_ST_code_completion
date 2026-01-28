// AJ Jaworowski 2015-02-22
// Following the recipe by  Peter Nachtwey
// http://www.controlguru.com/wp/p80.html
FUNCTION_BLOCK HeatExchanger
VAR_INPUT
	Kp: REAL; //System gain
	Tp: REAL; //Process time
	CO: REAL; //Output from controller
	Dead_t: REAL; //The time before the system responds to the disturbance
	C: REAL; //Initial steady state value
	Sample_time: TIME;
END_VAR
VAR_OUTPUT
	PV: REAL; //Process value at t1
END_VAR
VAR
	now: TIME;
	lastTime: TIME;
	lastPV: REAL := 140;
	A: REAL;
	B: REAL;
	delta_t: REAL;
	SampleTimeSec: REAL;
	DeadTimeIndex: INT;
	DelayQueue: ARRAY[0..99] OF REAL; // Circular buffer for delay
	QueueHead: INT := 0;
	QueueTail: INT := 0;
	QueueSize: INT := 100;
	QueueCount: INT := 0;
	DelayedCO: REAL := 0.0;
END_VAR

now := TIME();
IF ((now - lastTime) > Sample_time) THEN
delta_t := TIME_TO_REAL(Sample_time) / 1000.0; // Convert milliseconds to seconds
  SampleTimeSec := delta_t;

	IF Dead_t <= SampleTimeSec THEN
		DelayedCO := CO; // Skip delay if Dead_t is less than or equal to Sample_time
	ELSE
		DeadTimeIndex := REAL_TO_INT(Dead_t / SampleTimeSec);
		
		// Store CO in delay queue
		DelayQueue[QueueHead] := CO;
		QueueHead := (QueueHead + 1) MOD QueueSize;
		IF QueueCount < QueueSize THEN
			QueueCount := QueueCount + 1;
		ELSE
			QueueTail := (QueueTail + 1) MOD QueueSize;
		END_IF;

		// Retrieve delayed CO from queue
		IF QueueCount > DeadTimeIndex THEN
			DelayedCO := DelayQueue[(QueueTail + DeadTimeIndex) MOD QueueSize];
		ELSE
			DelayedCO := 0.0; // Default value if delay queue is not yet filled
		END_IF;
	END_IF;

	A := EXP(-delta_t / Tp);
	B := 1 - A;

	PV := A * lastPV + B * Kp * DelayedCO + C;
	lastPV := PV;
	lastTime := now;
END_IF;
END_FUNCTION_BLOCK