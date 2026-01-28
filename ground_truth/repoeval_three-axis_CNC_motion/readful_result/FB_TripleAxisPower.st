It seems like you've provided multiple fragments of the same or similar code from a file named `FB_TripleAxisPower.st` in a project directory called `三轴CNC运动实训-FUN`. The code defines a function block (`FUNCTION_BLOCK`) named `FB_TripleAxisPower` for controlling the power of three axes (X, Y, and Z) in a CNC system. Here's a summary of the key components of the code:

---

### **Key Components of `FB_TripleAxisPower`**

1. **Inputs (`VAR_INPUT`)**:
   - `AxisX`, `AxisY`, `AxisZ`: These are references to the X, Y, and Z axes, respectively, of type `SM3_Basic.AXIS_REF_SM3`.
   - `bServoEnable`: A boolean input that acts as the servo enable signal.

2. **Outputs (`VAR_OUTPUT`)**:
   - `bReady`: Indicates whether all three axes are ready.
   - `bAxisXReady`, `bAxisYReady`, `bAxisZReady`: Indicate whether the X, Y, and Z axes are ready individually.
   - `bError`: A boolean flag indicating if there is an error.
   - `sErrorString`: A string output to provide error information.

3. **Internal Variables (`VAR`)**:
   - `fbPowerX`, `fbPowerY`, `fbPowerZ`: Instances of the `MC_POWER` function block, used to control the power of the X, Y, and Z axes.

4. **Functionality**:
   - The function block uses the `MC_POWER` instances (`fbPowerX`, `fbPowerY`, `fbPowerZ`) to control the power of each axis.
   - For example, the X-axis power control is implemented as:
     ```st
     fbPowerX(
         Enable := bServoEnable,
         bRegulatorOn := bServoEnable,
         bDriveStart := bServoEnable,
         Axis := AxisX
     );
     ```
   - Similar logic is likely applied for the Y and Z axes.

---

### **Purpose of `FB_TripleAxisPower`**
The purpose of this function block is to manage the power control for a three-axis CNC system. It ensures that the power for each axis (X, Y, Z) is appropriately controlled based on the `bServoEnable` input signal. It also provides feedback on the readiness of each axis and the overall system, as well as error reporting.

---

### **Suggestions for Improvement**
1. **Error Handling**:
   - Ensure that the `bError` and `sErrorString` outputs are updated with meaningful information when an error occurs in any of the axes.

2. **Axis Readiness**:
   - The logic for setting `bAxisXReady`, `bAxisYReady`, and `bAxisZReady` should be clearly defined, possibly based on the status of the corresponding `MC_POWER` instances.

3. **Code Duplication**:
   - The code for controlling the power of each axis (X, Y, Z) appears to be repetitive. Consider refactoring to reduce duplication, such as by using a loop or a helper function if the programming environment supports it.

4. **Documentation**:
   - Add comments to explain the purpose of each input, output, and internal variable, as well as the overall functionality of the function block.

---

If you have specific questions or need further assistance with this code, feel free to ask!