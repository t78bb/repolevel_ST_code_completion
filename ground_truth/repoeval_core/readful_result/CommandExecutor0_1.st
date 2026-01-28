It seems like you've provided code fragments from two function blocks, `CommandExecutor` and `CommandExecutor0`, which are part of a repository. Both function blocks appear to handle the control of some kind of actuator system (likely involving proportional valves) based on the input parameters `level`, `idx`, `direct`, and `percent`.

Here’s a summary of the differences and similarities between the two function blocks:

---

### **CommandExecutor**
1. **Input Parameters:**
   - `level`: Specifies the type of track (地轨 or 天轨).
   - `idx`: Index of the actuator or flap.
   - `percent`: A proportional valve percentage, which can range from **-100 to +100**.

2. **Logic:**
   - If `percent > 0`, it sets the `extendPercent` and clears `retractPercent`.
   - If `percent <= 0`, it sets the `retractPercent` and clears `extendPercent`.

3. **Behavior:**
   - Handles both positive and negative values for `percent`, which likely correspond to extending and retracting the actuator/flap.

---

### **CommandExecutor0**
1. **Input Parameters:**
   - `level`: Specifies the type of track (地轨 or 天轨).
   - `idx`: Index of the actuator or flap.
   - `direct`: Specifies the direction (`TargetDirect.extend` or `TargetDirect.retract`).
   - `percent`: A proportional valve percentage, which ranges from **0 to 100**.

2. **Logic:**
   - Uses the `direct` parameter to determine whether to extend or retract.
   - For `TargetDirect.extend`, it sets the `extendPercent` and clears `retractPercent`.
   - For `TargetDirect.retract`, it sets the `retractPercent` and clears `extendPercent`.

3. **Behavior:**
   - Does not handle negative values for `percent`.
   - Relies on the `direct` parameter to determine the direction of movement.

---

### **Key Differences**
1. **Input Range for `percent`:**
   - `CommandExecutor` accepts values from **-100 to +100**, where negative values likely indicate retraction.
   - `CommandExecutor0` accepts values from **0 to 100**, and the direction is explicitly specified using the `direct` parameter.

2. **Direction Handling:**
   - `CommandExecutor` infers the direction based on the sign of `percent`.
   - `CommandExecutor0` explicitly uses the `direct` parameter to determine the direction.

3. **Flexibility:**
   - `CommandExecutor` combines direction and percentage into a single parameter (`percent`), making it simpler but less explicit.
   - `CommandExecutor0` separates direction (`direct`) and percentage (`percent`), making it more explicit but requiring additional input.

---

### **Potential Use Cases**
- **CommandExecutor** might be used in scenarios where the direction can be inferred directly from the `percent` value, simplifying the input requirements.
- **CommandExecutor0** might be used in scenarios where the direction needs to be explicitly specified, providing more control and clarity.

---

If you need further clarification or have specific questions about these function blocks, feel free to ask!