It seems like you are sharing fragments of a Structured Text (ST) program for a PLC (Programmable Logic Controller). The code defines a function block `FB_DualAxisPower` that manages the power control of two axes (Axis1 and Axis2). Below is a consolidated and cleaned-up version of the code based on the fragments provided:

```pascal
FUNCTION_BLOCK FB_DualAxisPower
VAR_INPUT
	Axis1			:	AXIS_REF;		// Axis 1 reference
	Axis2			:	AXIS_REF;		// Axis 2 reference
	bEnable			:	BOOL := TRUE;	// Enable signal
END_VAR
VAR_OUTPUT
	bAxis1Ready		:	BOOL;			// Axis 1 ready
	bAxis2Ready		:	BOOL;			// Axis 2 ready
	bBothReady		:	BOOL;			// Both axes ready
	bError			:	BOOL;			// Error flag
END_VAR
VAR
	fbPower1		:	MC_Power;		// Power control for Axis 1
	fbPower2		:	MC_Power;		// Power control for Axis 2
END_VAR

// Execute power control for Axis 1
fbPower1(
	Axis := Axis1,
	Enable := bEnable,
	bDriveStart := TRUE,
	bRegulatorOn := TRUE
);

// Execute power control for Axis 2
fbPower2(
	Axis := Axis2,
	Enable := bEnable,
	bDriveStart := TRUE,
	bRegulatorOn := TRUE
);

// Set output flags based on the status of the axes
bAxis1Ready := fbPower1.Status;
bAxis2Ready := fbPower2.Status;
bBothReady := bAxis1Ready AND bAxis2Ready;
bError := fbPower1.Error OR fbPower2.Error;
END_FUNCTION_BLOCK
```

### Explanation of the Code:
1. **Inputs (`VAR_INPUT`)**:
   - `Axis1` and `Axis2`: References to the two axes being controlled.
   - `bEnable`: A boolean input to enable or disable the power control.

2. **Outputs (`VAR_OUTPUT`)**:
   - `bAxis1Ready` and `bAxis2Ready`: Indicate whether each axis is ready.
   - `bBothReady`: Indicates whether both axes are ready.
   - `bError`: Indicates if there is an error in either axis.

3. **Internal Variables (`VAR`)**:
   - `fbPower1` and `fbPower2`: Instances of the `MC_Power` function block for controlling the power of Axis1 and Axis2.

4. **Functionality**:
   - The function block enables power control for both axes using the `MC_Power` function block.
   - It sets the output flags (`bAxis1Ready`, `bAxis2Ready`, `bBothReady`, and `bError`) based on the status and error flags of the `MC_Power` function blocks.

### Notes:
- The `MC_Power` function block is likely part of a motion control library and is used to manage the power state of an axis.
- The `Status` and `Error` properties of `fbPower1` and `fbPower2` are assumed to indicate the readiness and error state of the axes, respectively.
- The code assumes that enabling the power (`bEnable`) and setting `bDriveStart` and `bRegulatorOn` to `TRUE` are sufficient to prepare the axes.

If you have additional requirements or specific questions about this code, feel free to ask!