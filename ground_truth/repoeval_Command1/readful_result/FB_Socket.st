The code fragment provided defines a **FUNCTION_BLOCK** named `FB_Socket`. This block has one output variable, `bActive`, which is of type `BOOL`. The `bActive` variable likely represents the active state of the socket (e.g., whether it is turned on or off).

Here is a summary of the relevant code fragments from the repository:

---

### **FB_Socket**
File: `Command1-FUN\FB_Socket.st`

```plaintext
FUNCTION_BLOCK PUBLIC FB_Socket
VAR_OUTPUT
	bActive		: BOOL;
END_VAR
```

This defines the `FB_Socket` function block with an output variable `bActive`.

---

### **FB_Socket_On**
File: `Command1-FUN\FB_Socket_On.st`

```plaintext
METHOD PUBLIC On
VAR_OUTPUT
	bActive		: BOOL;
END_VAR

bActive := true;
```

The `On` method sets the `bActive` variable to `true`, indicating that the socket is active (turned on).

---

### **FB_Socket_Off**
File: `Command1-FUN\FB_Socket_Off.st`

```plaintext
METHOD PUBLIC Off
VAR_OUTPUT
	bActive		: BOOL;
END_VAR

bActive := false;
```

The `Off` method sets the `bActive` variable to `false`, indicating that the socket is inactive (turned off).

---

### **FB_Lamp**
File: `Command1-FUN\FB_Lamp.st`

```plaintext
FUNCTION_BLOCK PUBLIC FB_Lamp
VAR_OUTPUT
	byLevel			: BYTE;
END_VAR
```

This defines the `FB_Lamp` function block with an output variable `byLevel`, which is of type `BYTE`. This likely represents the brightness level of the lamp.

---

### **FB_SocketOnCommand**
File: `Command1-FUN\FB_SocketOnCommand.st`

```plaintext
FUNCTION_BLOCK PUBLIC FB_SocketOnCommand IMPLEMENTS I_Command
VAR
	refSocket : REFERENCE TO FB_Socket;
END_VAR
```

This defines the `FB_SocketOnCommand` function block, which implements the `I_Command` interface. It contains a reference variable `refSocket` that refers to an instance of the `FB_Socket` function block. This block is likely used to execute the "On" command for the socket.

---

### Summary of Relationships:
1. **FB_Socket**: Represents a socket with an active state (`bActive`).
2. **FB_Socket_On**: Provides a method to turn the socket on (`bActive := true`).
3. **FB_Socket_Off**: Provides a method to turn the socket off (`bActive := false`).
4. **FB_Lamp**: Represents a lamp with a brightness level (`byLevel`).
5. **FB_SocketOnCommand**: Implements a command interface (`I_Command`) and interacts with the `FB_Socket` function block.

Let me know if you need further clarification or assistance!