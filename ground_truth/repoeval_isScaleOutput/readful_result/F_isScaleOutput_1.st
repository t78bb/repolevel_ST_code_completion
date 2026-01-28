It seems like you have provided a partial code snippet for the `F_iScaleOutput` function, which appears to be a scaling function for converting physical output values into a terminal-specific range. However, the code snippet is incomplete, and it seems to repeat itself in parts.

From the provided fragments, here is a summary of what the function does:

### Function Purpose
The `F_iScaleOutput` function appears to scale a physical output value (`rOutput`) from a specified physical range (`rPhyMin` to `rPhyMax`) into a terminal-specific range (`rTerMin` to `rTerMax`). The terminal type is determined by the `eTerminal` input, which specifies the type of terminal (e.g., 0-20 mA, 4-20 mA, 0-10 V, etc.).

### Key Steps in the Function
1. **Set Terminal Range**:
   - `rTerMax` is set to a constant value of `32768.0`.
   - `rTerMin` is determined based on the `eTerminal` type using a `CASE` statement. For example:
     - For `eTerminal_0mA_20mA`, `rTerMin` is `0.0`.
     - For `eTerminal_m10V_10V`, `rTerMin` is `-32768.0`.

2. **Calculate Ranges**:
   - `rPhyRange` is the difference between `rPhyMax` and `rPhyMin`.
   - `rTerRange` is the difference between `rTerMax` and `rTerMin`.

3. **Scale the Output**:
   - If both `rPhyRange` and `rTerRange` are greater than `0.0`, the function calculates the scaled terminal output (`rTerOutput`) using the formula:
     ```
     rTerOutput := rTerMin + (rTerRange * (rOutput - rPhyMin) / rPhyRange);
     ```
   - If either range is invalid (e.g., `rPhyRange <= 0.0` or `rTerRange <= 0.0`), the function sets `rTerOutput` to `0.0`.

### Missing Code
The provided code fragments are incomplete, and the following parts are missing:
- The final `ELSE` block for the `IF` statement that handles invalid ranges.
- The return statement or assignment of the scaled value (`rTerOutput`) to the function's output.

### Complete Function (Reconstructed)
Here is a reconstructed version of the `F_iScaleOutput` function based on the provided fragments:

```pascal
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
END_VAR

rTerMax := 32768.0;

CASE eTerminal OF
	eTerminal_0mA_20mA: rTerMin := 0.0;
	eTerminal_4mA_20mA: rTerMin := 0.0;
	eTerminal_0V_10V: rTerMin := 0.0;
	eTerminal_m10V_10V: rTerMin := -32768.0;
ELSE
	rTerMin := -32768.0;
END_CASE;

rPhyRange := rPhyMax - rPhyMin;
rTerRange := rTerMax - rTerMin;

IF rPhyRange > 0.0 AND rTerRange > 0.0 THEN
	rTerOutput := rTerMin + (rTerRange * (rOutput - rPhyMin) / rPhyRange);
ELSE
	rTerOutput := 0.0;
END_IF;

F_iScaleOutput := INT(rTerOutput);
```

### Notes
1. **Input Validation**: The function does not validate the inputs (`rOutput`, `rPhyMin`, `rPhyMax`, etc.). You may want to add checks to ensure they are within expected ranges.
2. **Output Type**: The function returns an `INT`, but the scaled output (`rTerOutput`) is calculated as a `REAL`. The final value is cast to an `INT` before returning.
3. **Terminal Types**: The `eTerminal` enumeration should be defined elsewhere in your codebase. Ensure that all possible terminal types are handled in the `CASE` statement.

Let me know if you need further clarification or assistance!