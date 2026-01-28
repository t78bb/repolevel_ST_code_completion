FUNCTION F_iScaleOutput : INT
VAR_INPUT
	rOutput: REAL; (* [] Physical output *)
	rPhyMin: REAL; (* [] Physical minimum *)
	rPhyMax: REAL; (* [] Physical maximum *)
	eTerminal: E_Ctrl_TerminalType; (* [] Terminal type. *)
END_VAR
VAR
	rTerMin: REAL;
	rTerMax: REAL;
	rPhyRange: REAL;
	rTerRange: REAL;
	rTerOutput: REAL;
	iScaledOutput: INT;
END_VAR

(* Step 1: Clamp rOutput to the range [rPhyMin, rPhyMax] *)
IF rOutput < rPhyMin THEN
	rOutput := rPhyMin;
ELSIF rOutput > rPhyMax THEN
	rOutput := rPhyMax;
END_IF;

(* Step 2: Determine terminal-specific range *)
rTerMax := 32768.0;
CASE eTerminal OF
	eTerminal_0mA_20mA: rTerMin := 0.0;
	eTerminal_4mA_20mA: rTerMin := 0.0;
	eTerminal_0V_10V: rTerMin := 0.0;
	eTerminal_m10V_10V: rTerMin := -32768.0;
ELSE
	rTerMin := -32768.0;
END_CASE;

(* Step 3: Calculate physical and terminal ranges *)
rPhyRange := rPhyMax - rPhyMin;
rTerRange := rTerMax - rTerMin;

(* Step 4: Perform scaling calculation if ranges are valid *)
IF rPhyRange > 0.0 AND rTerRange > 0.0 THEN
	rTerOutput := rTerMin + (rTerRange * (rOutput - rPhyMin) / rPhyRange);
ELSE
	rTerOutput := 0.0;
END_IF;

(* Step 5: Round the result and return as integer *)
iScaledOutput := ROUND(rTerOutput);
RETURN iScaledOutput;
END_FUNCTION
