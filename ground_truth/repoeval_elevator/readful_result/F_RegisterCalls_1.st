It seems like you've shared fragments of code from a project related to elevator control logic. The code snippets are written in Structured Text (ST), a programming language commonly used in industrial automation systems, particularly for programmable logic controllers (PLCs).

Here’s a summary of the provided code fragments:

---

### **Code Fragment 1: `F_RegisterCalls` Function**
This function is responsible for registering elevator calls from different floors. It takes boolean inputs (`CallGround`, `CallFloor1`, `CallFloor2`, `CallFloor3`) representing call requests from floors 0 to 3. It updates the `TargetFloors` array to indicate which floors have active requests.

Key points:
- If a call is made from a floor (e.g., `CallGround` is `TRUE`), the corresponding index in the `TargetFloors` array is set to `TRUE`.
- The `TargetFloors` array acts as a queue or list of floors that the elevator needs to visit.

---

### **Code Fragment 2: `FB_ElevatorMovement` Function Block**
This function block manages the movement of the elevator based on the `TargetFloors` array. It determines whether the elevator should move up, move down, or stop at a target floor.

Key points:
1. **Arrival at Target Floor:**
   - If the elevator reaches a floor with an active request (`TargetFloors[CurrentFloor]` is `TRUE`), it stops, clears the request, and sets `bArrivedAtTarget` to `TRUE`.
   - Movement flags (`bMovingUp`, `bMovingDown`) are reset to `FALSE`.

2. **Door Readiness:**
   - The elevator only moves if the doors are ready (`bDoorReady` is `TRUE`).

3. **Checking Requests:**
   - The function checks if there are requests for higher floors (`bHasUpperRequest`) or lower floors (`bHasLowerRequest`) relative to the current floor.

---

### Observations:
1. **Code Duplication:**
   - The `F_RegisterCalls` function appears to be duplicated in the provided fragments. Ensure that only one version exists in the repository to avoid confusion.

2. **Incomplete Logic:**
   - The `FB_ElevatorMovement` fragment ends abruptly (`// �`), suggesting that part of the code is missing. This could include logic for moving the elevator up or down based on requests.

3. **Potential Enhancements:**
   - Add error handling for invalid inputs or states.
   - Implement prioritization logic if needed (e.g., prioritize requests in the current direction of movement).

---

If you have specific questions or need assistance with a particular aspect of the code, feel free to ask!