It seems you are sharing code fragments from a PLC (Programmable Logic Controller) project, specifically from function blocks `FB_ModeController` and `FB_ManualControl`. These function blocks are part of a system that likely controls a mixing tank, and they handle mode switching and manual control logic.

Here’s a summary of the functionality described in the code fragments:

---

### **FB_ModeController**
This function block is responsible for managing the mode of operation (e.g., Auto or Manual) for the mixing tank system.

#### **Inputs:**
- `bSetToAuto`: Command to switch to Auto mode.
- `bSetToManual`: Command to switch to Manual mode.

#### **Outputs:**
- `eCurrentMode`: The current mode of operation (Auto or Manual).
- `bModeChanged`: A flag indicating whether the mode has changed.

#### **Internal Variables:**
- `eLastMode`: Stores the previous mode for comparison.

#### **Logic:**
1. **Mode Switching:**
   - If the current mode is `AUTO` and the `bSetToManual` command is received, the mode switches to `MANUAL`.
   - If the current mode is `MANUAL` and the `bSetToAuto` command is received, the mode switches to `AUTO`.

2. **Mode Change Detection:**
   - The `bModeChanged` flag is set to `TRUE` if the current mode (`eCurrentMode`) is different from the last mode (`eLastMode`).
   - The `eLastMode` variable is updated to the current mode.

---

### **FB_ManualControl**
This function block handles manual control of the mixing tank system, allowing operators to control devices directly via HMI (Human-Machine Interface) commands.

#### **Inputs:**
- **HMI Commands:**
  - `bMixerRunCmd`: Command to start the mixer.
  - `bMixerStopCmd`: Command to stop the mixer.
  - `bMedium1OpenCmd`: Command to open Medium 1 valve.
  - `bMedium1CloseCmd`: Command to close Medium 1 valve.
  - `bMedium2OpenCmd`: Command to open Medium 2 valve.
  - `bMedium2CloseCmd`: Command to close Medium 2 valve.
  - `bDrainOpenCmd`: Command to open the drain valve.
  - `bDrainCloseCmd`: Command to close the drain valve.

- **Device Feedback:**
  - `bMixerRunning`: Indicates whether the mixer is running.
  - `bMedium1Opened`: Indicates whether Medium 1 valve is open.
  - `bMedium2Opened`: Indicates whether Medium 2 valve is open.
  - `bDrainOpened`: Indicates whether the drain valve is open.

#### **Outputs:**
- **Device Control Outputs:**
  - `bMixerRunCmdOut`: Output command to start the mixer.
  - `bMedium1OpenCmdOut`: Output command to open Medium 1 valve.
  - `bMedium2OpenCmdOut`: Output command to open Medium 2 valve.
  - `bDrainOpenCmdOut`: Output command to open the drain valve.

#### **Logic:**
- The manual control logic uses latch mechanisms to control devices based on HMI commands and device feedback.
- For example, the mixer control logic might look like this:
  - The mixer starts if the `bMixerRunCmd` is pressed OR the mixer is already running (`bMixerRunning`), AND the `bMixerStopCmd` is NOT pressed.

---

### Observations:
1. **Mode Switching:**
   - The `FB_ModeController` function block ensures smooth transitions between Auto and Manual modes, with a flag (`bModeChanged`) to indicate mode changes.

2. **Manual Control:**
   - The `FB_ManualControl` function block provides direct control over devices, allowing operators to override automatic operations when necessary.

3. **Integration:**
   - These function blocks likely work together in the mixing tank system. For example, the `FB_ModeController` determines whether the system is in Auto or Manual mode, and the `FB_ManualControl` handles manual operations when the system is in Manual mode.

---

If you have specific questions about the code or need help with implementation, debugging, or optimization, feel free to ask!