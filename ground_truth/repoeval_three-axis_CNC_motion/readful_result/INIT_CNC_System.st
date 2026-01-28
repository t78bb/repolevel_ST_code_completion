It seems like you've provided a code fragment from a Structured Text (ST) file, which is commonly used in PLC programming, specifically for initializing a CNC system. The code defines a function `INIT_CNC_System` that initializes various functional blocks related to CNC operations, such as reading NC files, decoding NC programs, checking velocities, interpolating movements, and controlling axes.

The function uses the following:

1. **Functional Blocks (FBs):**
   - `SMC_ReadNCFile`: Reads NC files.
   - `SMC_NCDecoder`: Decodes NC programs.
   - `SMC_CheckVelocities`: Checks velocity constraints.
   - `SMC_Interpolator`: Interpolates movements.
   - `SMC_ControlAxisByPos`: Controls axis positions for X, Y, and Z axes.
   - `SMC_HOMING`: Handles homing operations for X, Y, and Z axes.
   - `MC_STOP`: Stops the motion of X, Y, and Z axes.

2. **Inputs:**
   - `AxisX`, `AxisY`, `AxisZ`: These are references to the axes of the CNC system, defined as `SM3_Basic.AXIS_REF_SM3`.

3. **Implementation Notes:**
   - The code includes comments indicating that input variables (`VAR_INPUT`) should not be directly modified within the function.
   - Functional blocks are reset by setting their `bExecute` parameter to `FALSE`.

### Observations:
- The function appears to be part of a larger CNC control system, likely used for initializing or resetting the system to a known state.
- The repeated code fragments in your message seem to be duplicates, but they reinforce the structure and purpose of the function.

### Suggestions:
If you are looking to enhance or debug this function:
1. Ensure that all functional blocks are properly initialized before use.
2. Verify that the `AxisX`, `AxisY`, and `AxisZ` inputs are correctly mapped to the physical axes of the CNC machine.
3. Add error handling to check the status of each functional block after execution.
4. Consider modularizing the initialization process further if additional functionality is required.

If you have specific questions or need further assistance with this code, feel free to ask!