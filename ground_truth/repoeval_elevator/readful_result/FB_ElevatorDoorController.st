It seems like you've shared fragments of code from a function block named `FB_ElevatorDoorController`, which is part of an elevator control system. This function block appears to manage the elevator door's state and behavior based on inputs such as whether the elevator has arrived at the target floor (`bArrivedAtTarget`) and whether the door is closed (`bDoorClosed`). It also outputs commands and states related to the door, such as opening (`bOpenDoor`), closing (`bCloseDoor`), and readiness (`bDoorReady`).

Here’s a summary of the functionality described in the fragments:

### Inputs
1. **`bArrivedAtTarget`**: Indicates whether the elevator has arrived at the target floor.
2. **`bDoorClosed`**: Indicates whether the door is closed (sensor input).

### Outputs
1. **`bOpenDoor`**: Command to open the door.
2. **`bCloseDoor`**: Command to close the door.
3. **`bDoorOpen`**: Indicates whether the door is open.
4. **`bDoorReady`**: Indicates whether the door is ready (e.g., closed and the elevator can move).

### Internal Variables
1. **`fbDoorTimer`**: A timer used for the door opening delay.
2. **`fbCloseDoorTimer`**: A timer used for the door closing delay.
3. **`nState`**: Represents the current state of the door controller (state machine).

### State Machine Logic
The state machine (`nState`) governs the behavior of the door controller:
1. **State 0 (Idle)**:
   - The door is ready (`bDoorReady := TRUE`).
   - No commands are issued to open or close the door (`bOpenDoor := FALSE`, `bCloseDoor := FALSE`).
   - If the elevator arrives at the target floor (`bArrivedAtTarget`), the state transitions to **State 1** to begin the door opening process.

2. **State 1 (Door Opening Delay)**:
   - The door is not ready (`bDoorReady := FALSE`).
   - A timer (`fbDoorTimer`) starts to introduce a delay before opening the door.
   - Once the timer completes (`fbDoorTimer.Q`), the state transitions to **State 2**.

### Missing Code
The fragments you provided seem incomplete, as the logic for **State 2** and possibly other states is not included. Based on the naming and typical elevator door control logic, **State 2** might involve actually opening the door (`bOpenDoor := TRUE`), and subsequent states might handle closing the door and ensuring readiness for movement.

If you need help reconstructing the missing parts or understanding the logic further, feel free to provide additional details or clarify your requirements!