It seems like you've shared code fragments from a repository related to motion control or automation systems, written in Structured Text (ST), a programming language commonly used in PLC (Programmable Logic Controller) programming. The fragments include functionality for stopping an axis (`FB_轴停止触发块`) and controlling the output of a swing arm (`FB_摆杆输出`).

Here’s a summary of the provided code fragments:

---

### **Fragment 1: FB_轴停止触发块**
This function block (`FB_轴停止触发块`) is designed to trigger the stopping of an axis. It uses a timer (`TON`) to delay the stop execution for 0.3 seconds.

#### Key Points:
- **Input/Output Variable:**
  - `StopExcute`: A boolean variable that indicates whether the stop execution is active.
- **Internal Variable:**
  - `TON0`: A timer (`TON`) instance.
- **Logic:**
  - The timer (`TON0`) is activated when `StopExcute` is `TRUE`.
  - After 0.3 seconds (`PT:= T#0.3S`), if the timer's output (`Q`) is `TRUE`, the `StopExcute` variable is reset to `FALSE`.

---

### **Fragment 2: FB_摆杆输出**
This function block (`FB_摆杆输出`) controls the output of a swing arm based on its current position and predefined thresholds.

#### Key Points:
- **Input Variables:**
  - `Enable`: A boolean variable to enable the function block.
  - `摆臂的当前值`: Current value of the swing arm position.
  - `摆臂最小值`: Minimum value of the swing arm position.
  - `摆臂中间停止时最小值` and `摆臂中间停止时最大值`: Thresholds for intermediate stop positions.
  - `摆臂位置最大值`: Maximum value of the swing arm position.
  - `放卷的比例系数`: Coefficient for unwinding.
  - `收卷比例K值`: Coefficient for winding.
- **Output Variables:**
  - `摆臂超过最大值报警`: Alarm for exceeding the maximum swing arm position.
  - `放卷的输出值`: Output value for unwinding.
- **Internal Variables:**
  - Various intermediate calculations related to swing arm positions and winding/unwinding logic.
- **Logic:**
  - When `Enable` is `TRUE`, the block calculates intermediate values like `摆臂收卷中间最大值`.
  - Depending on the current swing arm position (`摆臂的当前值`), it adjusts the output (`放卷的输出值`) or triggers alarms (`摆臂超过最大值报警`).

---

### Observations:
1. **FB_轴停止触发块**:
   - This block is straightforward and primarily focuses on stopping an axis with a delay.
   - The timer ensures that the stop execution is not immediate but delayed by 0.3 seconds.

2. **FB_摆杆输出**:
   - This block is more complex and involves calculations based on the swing arm's position and predefined thresholds.
   - It includes logic for handling edge cases, such as when the swing arm position is below the minimum or exceeds the maximum.

---

### Suggestions:
If you are trying to integrate or debug these function blocks:
1. **FB_轴停止触发块**:
   - Ensure that `StopExcute` is properly set by the calling program or function block.
   - Verify the timer's behavior and ensure the delay is appropriate for your application.

2. **FB_摆杆输出**:
   - Carefully review the thresholds (`摆臂最小值`, `摆臂中间停止时最小值`, etc.) to ensure they align with the physical constraints of the swing arm.
   - Test the block with various input values to confirm the unwinding and winding logic works as expected.

Let me know if you need further assistance with these blocks or their integration!