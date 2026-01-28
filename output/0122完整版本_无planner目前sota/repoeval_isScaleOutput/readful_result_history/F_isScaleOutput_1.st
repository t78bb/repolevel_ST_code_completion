FUNCTION F_iScaleOutput : INT
VAR_INPUT
  rOutput: REAL; (* [] Physical output *)
  rPhyMin: REAL; (* [] Physical minimum *)
  rPhyMax: REAL; (* [] Physical maximum *)
  eTerminal: INT; (* [] Terminal type now using INT. *)
END_VAR
VAR
  rTerMin: REAL;
  rTerMax: REAL;
  rPhyRange: REAL;
  rTerRange: REAL;
  rTerOutput: REAL;
END_VAR

rTerMax := 32768.0;
CASE eTerminal OF
  0: rTerMin := 0.0; // Corresponds to eTerminal_0mA_20mA
  1: rTerMin := 0.0; // Corresponds to eTerminal_4mA_20mA
  2: rTerMin := 0.0; // Corresponds to eTerminal_0V_10V
  3: rTerMin := -32768.0; // Corresponds to eTerminal_m10V_10V
ELSE
  rTerMin := -32768.0; // Default case
END_CASE;

rPhyRange := rPhyMax - rPhyMin;
rTerRange := rTerMax - rTerMin;

IF rPhyRange > 0.0 AND rTerRange > 0.0 THEN
  rTerOutput := rTerMin + (rTerRange * (rOutput - rPhyMin) / rPhyRange);
ELSE
  rTerOutput := 0.0;
END_IF;

RETURN TO_INT(rTerOutput);
END_FUNCTION