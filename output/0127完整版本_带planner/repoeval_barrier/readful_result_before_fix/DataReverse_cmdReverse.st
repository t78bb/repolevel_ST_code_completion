FUNCTION cmdReverse : TargetDirect
VAR_INPUT
	input		:TargetDirect;
END_VAR
IF input = TargetDirect.extend THEN
	cmdReverse := TargetDirect.retract;
ELSIF input = TargetDirect.retract THEN
	cmdReverse := TargetDirect.extend;
ELSE
	cmdReverse := input; // Return the input unchanged if it's not a valid TargetDirect value
END_IF;
RETURN;
END_FUNCTION
