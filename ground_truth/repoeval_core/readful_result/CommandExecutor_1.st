It seems like you've provided fragments of code from a repository, specifically from files named `CommandExecutor.st` and `CommandExecutor0.st`. These fragments define a `FUNCTION_BLOCK` named `CommandExecutor` (and `CommandExecutor0`), which appears to control some kind of actuator system based on input parameters like `level`, `idx`, and `percent`.

From the provided code:

1. **Purpose of the `CommandExecutor` Function Block**:
   - The `CommandExecutor` function block is responsible for controlling actuators (likely proportional valves) based on the input parameters.
   - The `level` input determines whether the control is for "地轨" (ground track) or "天轨" (sky track).
   - The `idx` input specifies the index of the actuator to control.
   - The `percent` input specifies the percentage of the proportional valve to open or close, ranging from -100 to +100.

2. **Behavior Based on `percent`**:
   - If `percent > 0`, the function block sets the `extendPercent` for the specified actuator and resets `retractPercent` to 0.
   - If `percent <= 0`, the function block sets the `retractPercent` for the specified actuator and resets `extendPercent` to 0.
   - The percentage values are scaled to a 16-bit range (0 to 65535) using the formula `REAL_TO_WORD(percent * 65535 / 100)`.

3. **Differences Between Fragments**:
   - The fragments from `CommandExecutor.st` are mostly identical, with the same logic repeated multiple times.
   - The fragment from `CommandExecutor0.st` is incomplete, but it seems to follow a similar structure.

4. **Potential Improvements**:
   - **Code Repetition**: The same logic is repeated multiple times in `CommandExecutor.st`. This could be refactored into a reusable function or procedure to improve maintainability.
   - **Error Handling**: There is no error handling for invalid `level` or `idx` values. Adding checks for valid ranges could make the code more robust.
   - **Comments**: While there are some comments, additional explanations (e.g., what "地轨" and "天轨" represent) could make the code easier to understand for others.

If you have specific questions or need help with a particular aspect of this code, feel free to ask!