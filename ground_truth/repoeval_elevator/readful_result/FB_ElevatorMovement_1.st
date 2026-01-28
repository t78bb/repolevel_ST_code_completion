It seems like you are sharing code fragments from a repository related to an elevator control system. The code is written in Structured Text (ST), a programming language commonly used in industrial automation systems, such as PLCs (Programmable Logic Controllers).

The provided code defines a function block (`FB_ElevatorMovement`) that handles the movement logic of an elevator. Here's a breakdown of the key components:

### Inputs (`VAR_INPUT`)
- `CurrentFloor`: The current floor where the elevator is located.
- `bDoorReady`: A boolean indicating whether the elevator door is ready (e.g., closed and locked).

### In-Out Variables (`VAR_IN_OUT`)
- `TargetFloors`: An array of booleans representing the requested target floors. Each index corresponds to a floor, and a `TRUE` value indicates a request for that floor.

### Outputs (`VAR_OUTPUT`)
- `bMovingUp`: A boolean indicating whether the elevator is moving up.
- `bMovingDown`: A boolean indicating whether the elevator is moving down.
- `bArrivedAtTarget`: A boolean indicating whether the elevator has arrived at the target floor.

### Internal Variables (`VAR`)
- `fbMoveDelayTimer`: A timer used to introduce a delay in movement.
- `i`: A loop variable, likely used for iterating through the `TargetFloors` array.
- `bHasUpperRequest`: A boolean indicating whether there are requests for floors above the current floor.
- `bHasLowerRequest`: A boolean indicating whether there are requests for floors below the current floor.

### Key Logic
1. **Checking Target Floors**:
   - If the current floor (`CurrentFloor`) is a target floor (`TargetFloors[CurrentFloor]`), the elevator:
     - Sets `bArrivedAtTarget` to `TRUE`.
     - Clears the request for the current floor by setting `TargetFloors[CurrentFloor]` to `FALSE`.
     - Stops moving by setting both `bMovingUp` and `bMovingDown` to `FALSE`.

2. **Movement Logic**:
   - The code likely includes additional logic (not fully shown in the fragments) to determine whether the elevator should move up or down based on the requests in `TargetFloors`.

### Observations
- The code appears to be incomplete or repetitive in the fragments provided. For example, some sections are truncated or repeated.
- The logic for determining `bHasUpperRequest` and `bHasLowerRequest` is not shown but is likely implemented elsewhere in the function block.
- The `fbMoveDelayTimer` is declared but not used in the provided fragments. It might be used to introduce a delay between floor movements.

If you have specific questions or need help with a particular aspect of the code, feel free to ask!