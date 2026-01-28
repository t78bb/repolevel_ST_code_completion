It seems like you've provided code fragments from a repository related to an elevator control system. The fragments include two main components:

1. **`F_UpdateDoorAnimation` Function**:
   - This function is responsible for updating the door animation of the elevator.
   - It takes inputs such as whether to open or close the door (`bOpenDoor`, `bCloseDoor`), whether the current floor has a call (`bCallFloor`), the current animation value (`nCurrentAni`), and the maximum animation value (`nMaxAni`).
   - The function increases or decreases the animation value (`nNewAni`) based on the inputs and returns the updated animation value.

2. **`FB_ElevatorMovement` Function Block**:
   - This function block handles the movement of the elevator.
   - It takes inputs like the current floor (`CurrentFloor`) and whether the door is ready (`bDoorReady`).
   - It also manages target floors (`TargetFloors`), movement direction (`bMovingUp`, `bMovingDown`), and whether the elevator has arrived at the target floor (`bArrivedAtTarget`).
   - The logic includes checking if the elevator has reached the target floor and clearing the request for that floor.

---

### Observations:
- The `F_UpdateDoorAnimation` function appears multiple times in your provided code fragments, but the content is identical in each instance. This might be redundant or a copy-paste issue in the repository.
- The `FB_ElevatorMovement` function block is partially shown, and it seems to handle the movement logic of the elevator, including requests for upper and lower floors.

---

### Suggestions:
1. **Avoid Redundancy**:
   - If the `F_UpdateDoorAnimation` function is repeated in multiple files, ensure it is defined only once in a shared module or library to avoid redundancy and potential maintenance issues.

2. **Code Organization**:
   - Consider organizing the code into separate modules for door animation, elevator movement, and other functionalities. This will improve readability and maintainability.

3. **Testing**:
   - Test the integration of `F_UpdateDoorAnimation` with `FB_ElevatorMovement` to ensure smooth operation, especially when the door animation and movement logic interact (e.g., doors should not open while the elevator is moving).

4. **Documentation**:
   - Add comments or documentation to explain the purpose of each variable and function. This will help future developers understand the code more easily.

If you have specific questions or need help with any part of the code, feel free to ask!