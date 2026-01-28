The provided code fragments are written in Structured Text (ST), a programming language commonly used in PLC (Programmable Logic Controller) programming. Below is a breakdown of the code and its functionality:

---

### **Code Fragment 1: `FB_Counter`**
This is a **Function Block** definition named `FB_Counter`. It is designed to handle counting operations based on three input signals: `bUp`, `bDown`, and `bReset`. Here's how it works:

#### **Inputs (`VAR_INPUT`)**
- `bUp: BOOL`: A Boolean input signal that triggers an increment in the counter value (`nValue`).
- `bDown: BOOL`: A Boolean input signal that triggers a decrement in the counter value (`nValue`).
- `bReset: BOOL`: A Boolean input signal that resets the counter value (`nValue`) to zero.

#### **Outputs (`VAR_OUTPUT`)**
- `nValue: INT`: An integer output representing the current value of the counter.

#### **Logic**
- If `bUp` is `TRUE`, the counter (`nValue`) is incremented by 1.
- If `bDown` is `TRUE`, the counter (`nValue`) is decremented by 1.
- If `bReset` is `TRUE`, the counter (`nValue`) is reset to 0.

---

### **Code Fragment 2: `PLC_PRG`**
This is a **Program** definition named `PLC_PRG`. It demonstrates how the `FB_Counter` function block is instantiated and used within a PLC program.

#### **Variables (`VAR`)**
- `FB_Counter_0: FB_Counter`: An instance of the `FB_Counter` function block.
- `bUp, bDown, bReset: BOOL`: Boolean variables used to control the behavior of the `FB_Counter_0` instance.
- `ActuallyValue: INT`: An integer variable that stores the current value of the counter (`nValue`).

#### **Logic**
- The inputs (`bUp`, `bDown`, `bReset`) are passed to the `FB_Counter_0` instance.
- The output (`nValue`) of the `FB_Counter_0` instance is assigned to the `ActuallyValue` variable.

---

### **How It Works Together**
1. The `FB_Counter` function block defines the counting logic.
2. The `PLC_PRG` program creates an instance of the `FB_Counter` function block (`FB_Counter_0`) and connects it to external input signals (`bUp`, `bDown`, `bReset`).
3. The current counter value (`nValue`) is accessible via the `ActuallyValue` variable.

---

### **Example Usage**
Assume the following input signals:
- `bUp = TRUE`
- `bDown = FALSE`
- `bReset = FALSE`

The counter (`nValue`) will increment by 1. If `bReset` is set to `TRUE`, the counter will reset to 0.

This modular design allows the counter logic to be reused across different parts of the PLC program by creating multiple instances of the `FB_Counter` function block.