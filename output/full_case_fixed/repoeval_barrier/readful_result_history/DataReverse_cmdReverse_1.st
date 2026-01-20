FUNCTION cmdReverse : TargetDirect
VAR_INPUT
  input		:TargetDirect;
END_VAR
IF input = TargetDirect.extend THEN
  cmdReverse := TargetDirect.retract;
ELSIF input = TargetDirect.retract THEN
  cmdReverse := TargetDirect.extend;
ELSE
  cmdReverse := input; // Default case if input is neither extend nor retract
END_IF;
END_FUNCTION