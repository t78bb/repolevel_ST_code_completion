It seems like you've shared code fragments from a repository related to programming for a dual-axis winding machine. The fragments include two function blocks: `CheckF` and `StaDisplay`. Here's a summary of the code:

---

### **1. Function Block: `CheckF`**
- **Purpose:** Calculates a value `lF` based on the inputs `lM`, `lL`, and `lH`.
- **Inputs:**
  - `lM` (LREAL): Represents a mass or similar quantity.
  - `lL` (LREAL): Represents a length or similar quantity.
  - `lH` (LREAL): Represents a height or similar quantity.
- **Output:**
  - `lF` (LREAL): The calculated force or value.
- **Logic:**
  - If `lH` is not zero, `lF` is calculated using the formula:
    ```
    lF := 9.8 * lM / (2 * COS(ATAN(lL / lH)));
    ```
  - This formula seems to involve physics-related calculations, possibly for determining force or tension in the winding machine.

---

### **2. Function Block: `StaDisplay`**
- **Purpose:** Controls the state of six Boolean outputs (`Y1`, `Y2`, `Y3`, `Y4`, `Y5`, `Y6`) based on the input `iStatus`.
- **Inputs:**
  - `iStatus` (INT): Represents the status or mode of the machine.
- **Outputs:**
  - `Y1`, `Y2`, `Y3`, `Y4`, `Y5`, `Y6` (BOOL): Boolean outputs controlling different aspects of the machine.
- **Logic:**
  - The `CASE` statement maps specific `iStatus` values to corresponding output states.
  - Example mappings:
    - For `iStatus` values `2, 3, 4, ..., 222`:
      ```
      Y5 := FALSE;
      Y6 := TRUE;
      Y1 := TRUE;
      Y2 := FALSE;
      Y3 := FALSE;
      Y4 := FALSE;
      ```
    - For `iStatus` values `11, 12`:
      ```
      Y5 := FALSE;
      Y6 := TRUE;
      Y1 := FALSE;
      Y2 := TRUE;
      Y3 := FALSE;
      Y4 := FALSE;
      ```
    - For `iStatus` values `13, 14, ..., 22`:
      ```
      Y5 := TRUE;
      Y6 := FALSE;
      Y1 := FALSE;
      Y2 := FALSE;
      Y3 := TRUE;
      Y4 := FALSE;
      ```
    - For `iStatus` values `23, 24`:
      ```
      Y5 := TRUE;
      Y6 := FALSE;
      ```

---

### Observations:
1. **`CheckF` Function Block:**
   - The formula used in `CheckF` suggests it might be calculating a force or tension based on trigonometric principles.
   - The use of `COS` and `ATAN` indicates the calculation involves angles, likely derived from the ratio of `lL` to `lH`.

2. **`StaDisplay` Function Block:**
   - The `CASE` statement is used to map machine statuses (`iStatus`) to specific output states.
   - The outputs (`Y1` to `Y6`) likely control different components or indicators in the winding machine.

3. **Repetition in `StaDisplay`:**
   - The code fragments for `StaDisplay` appear to repeat, with slight variations in the mappings for certain `iStatus` values.
   - This could indicate different versions or updates of the same function block.

---

If you have specific questions or need further analysis, feel free to ask!