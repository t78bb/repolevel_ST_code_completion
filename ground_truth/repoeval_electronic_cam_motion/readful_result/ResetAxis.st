It seems like you've shared multiple fragments of code from the same file (`电子凸轮运动实训-FUN\ResetAxis.st`) that define a `FUNCTION_BLOCK` named `ResetAxis`. The code appears to be written in Structured Text (ST), a programming language commonly used in industrial automation and PLC programming.

The `ResetAxis` function block seems to implement a state machine for resetting axes in a motion control system. Here's a summary of the key components and functionality based on the provided code:

---

### Key Components:
1. **Inputs:**
   - `bExec`: A boolean input that triggers the execution of the reset process.

2. **Variables:**
   - `fbReset1`, `fbReset2`: Instances of the `MC_Reset` function block, likely used to reset two axes.
   - `fbReadAxisError1`, `fbReadAxisError2`: Instances of the `MC_ReadAxisError` function block, used to read error states of the axes.
   - `fbReadStatus1`, `fbReadStatus2`: Instances of the `MC_ReadStatus` function block, used to read the status of the axes.
   - `fbExecTrig`: An instance of the `R_TRIG` (rising edge trigger) function block, used to detect when `bExec` transitions from `FALSE` to `TRUE`.
   - `nState`: A `BYTE` variable representing the current state of the state machine.
   - `bErrorX`, `bErrorY`: Boolean variables to store error states for two axes.

3. **Outputs:**
   - `Done`: A boolean output indicating whether the reset process has completed.

---

### Functionality:
The `ResetAxis` function block implements a state machine to manage the reset process. Here's a breakdown of the states based on the provided fragments:

1. **State 0:**
   - The initial state.
   - If a rising edge is detected on `bExec` (via `fbExecTrig.Q`), the state transitions to `1`, and the `Done` output is set to `FALSE`.

2. **State 1:**
   - This state likely handles the actual reset process for the axes using the `MC_Reset` function blocks (`fbReset1` and `fbReset2`).
   - Additional logic (not shown in the fragments) would determine when the reset process is complete and transition to the next state.

3. **Other States:**
   - The fragments do not include the complete implementation of the state machine, but additional states would likely handle:
     - Checking for errors using `MC_ReadAxisError`.
     - Verifying the status of the axes using `MC_ReadStatus`.
     - Finalizing the reset process and setting `Done` to `TRUE`.

---

### Observations:
- The code is modular and uses function blocks (`MC_Reset`, `MC_ReadAxisError`, `MC_ReadStatus`, `R_TRIG`) to encapsulate specific functionality.
- The state machine design allows for clear and structured handling of the reset process.
- The repeated fragments seem to be incomplete or redundant copies of the same code.

If you have specific questions or need help with a particular aspect of this code, feel free to ask!