It seems like you've provided repeated code fragments from the same file, `三轴CNC运动实训-FUN\FB_TripleAxisStop.st`, which define a function block `FB_TripleAxisStop`. This function block is designed to stop the motion of three axes (X, Y, Z) in a CNC system, with deceleration and error handling.

Here’s a summary of the functionality:

### **Function Block: `FB_TripleAxisStop`**
#### **Inputs (`VAR_INPUT`):**
1. **`AxisX`**, **`AxisY`**, **`AxisZ`**:
   - References to the X, Y, and Z axes (`SM3_Basic.AXIS_REF_SM3`).
   - These are the axes that the function block will control.

2. **`bExecute`**:
   - A boolean signal to trigger the stop operation.

3. **`rDeceleration`**:
   - A real number specifying the deceleration rate (default value: `100.0`).

#### **Outputs (`VAR_OUTPUT`):**
1. **`bDone`**:
   - Indicates whether all three axes have successfully stopped.

2. **`bBusy`**:
   - Indicates that the stop operation is still in progress.

3. **`bError`**:
   - A flag indicating if an error occurred during the stop operation.

4. **`sErrorString`**:
   - A string containing error information, if any.

#### **Internal Variables (`VAR`):**
1. **`fbStopX`**, **`fbStopY`**, **`fbStopZ`**:
   - Instances of the `MC_STOP` function block for stopping the X, Y, and Z axes.

#### **Functionality:**
The function block uses the `MC_STOP` function block to stop each axis. The `Execute` input triggers the stop operation, and the `Deceleration` input specifies the rate at which the axes should decelerate.

### **Code Example:**
Here’s how the stop operation is implemented for the X axis:
```st
fbStopX(
	Execute := bExecute,
	Deceleration := rDeceleration,
	Axis := AxisX
);
```
Similar logic is applied for the Y and Z axes.

### **Purpose:**
This function block is likely part of a CNC control system, where precise control over the motion of multiple axes is required. The `FB_TripleAxisStop` ensures that all three axes can be stopped simultaneously, with error handling and feedback on the operation's status.

If you have specific questions about this code or need help with implementation, feel free to ask!