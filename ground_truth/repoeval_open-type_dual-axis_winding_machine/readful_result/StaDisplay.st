It seems like you've shared multiple code fragments from the same file (`StaDisplay.st`) within the repository `开放式双轴卷绕机编程开发实训-FUN`. These fragments appear to define the behavior of a `FUNCTION_BLOCK` named `StaDisplay`, which uses the input variable `iStatus` to control the output variables `Y1`, `Y2`, `Y3`, `Y4`, `Y5`, and `Y6`.

From the fragments provided, the `CASE` statement is used to define specific behaviors based on the value of `iStatus`. Here's a summary of the patterns observed:

### Observed Behavior
1. **For `iStatus` values 2, 3, 4, 5, 6, 7, 8, 9, 10, 221, 222:**
   - `Y5 := FALSE`
   - `Y6 := TRUE`
   - `Y1 := TRUE`
   - `Y2 := FALSE`
   - `Y3 := FALSE`
   - `Y4 := FALSE`

2. **For `iStatus` values 11, 12:**
   - `Y5 := FALSE`
   - `Y6 := TRUE`
   - `Y1 := FALSE`
   - `Y2 := TRUE`
   - `Y3 := FALSE`
   - `Y4 := FALSE`

3. **For `iStatus` values 13, 14, 15, 16, 17, 18, 19, 20, 21, 22:**
   - `Y5 := TRUE`
   - `Y6 := FALSE`
   - `Y1 := FALSE`
   - `Y2 := FALSE`
   - `Y3 := TRUE` (in some fragments)
   - `Y4 := FALSE`

4. **For `iStatus` values 23, 24:**
   - `Y5 := TRUE`
   - `Y6 := FALSE`

### Missing Code
The last fragment seems incomplete, as the `CASE` statement for `iStatus` values 11, 12 is cut off. If you have additional details or need help completing or debugging this code, feel free to share more information.

### Suggestions
If you're trying to consolidate or debug these fragments:
- Ensure consistency in the behavior for each `iStatus` value across all fragments.
- Avoid redundancy by combining similar cases (e.g., `2..10, 221, 222`).
- Verify that all possible `iStatus` values are accounted for, or add a default case (`ELSE`) to handle unexpected values.

Let me know if you need further assistance!