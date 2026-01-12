# Based on the provided code fragments, we can implement a Python function that simulates the tank level logic.
# This function will mimic the behavior of the PLC logic in the FB_TankLevelSimulator and F_UpdateLimitSwitches.

class TankLevelSimulator:
    def __init__(self, initial_level=25.0, fill_rate1=0.1, fill_rate2=0.1, drain_rate=0.2, min_level=0.0, max_level=100.0):
        self.initial_level = initial_level
        self.fill_rate1 = fill_rate1
        self.fill_rate2 = fill_rate2
        self.drain_rate = drain_rate
        self.min_level = min_level
        self.max_level = max_level
        self.current_level = initial_level

    def reset(self):
        """Reset the tank level to the initial level."""
        self.current_level = self.initial_level

    def update_level(self, medium1_opened, medium2_opened, drain_opened):
        """Update the tank level based on the valve states."""
        self.current_level += self.fill_rate1 * int(medium1_opened)
        self.current_level += self.fill_rate2 * int(medium2_opened)
        self.current_level -= self.drain_rate * int(drain_opened)

        # Ensure the level stays within the min and max bounds
        self.current_level = max(self.min_level, min(self.current_level, self.max_level))

    def get_current_level(self):
        """Return the current tank level."""
        return self.current_level


class LimitSwitches:
    def __init__(self, full_threshold=85.0, empty_threshold=5.0):
        self.full_threshold = full_threshold
        self.empty_threshold = empty_threshold
        self.level_full = False
        self.level_empty = False

    def update_switches(self, tank_level):
        """Update the limit switches based on the current tank level."""
        self.level_full = tank_level >= self.full_threshold
        self.level_empty = tank_level <= self.empty_threshold

    def get_switch_states(self):
        """Return the states of the limit switches."""
        return {"level_full": self.level_full, "level_empty": self.level_empty}


# Example usage:
if __name__ == "__main__":
    # Initialize the tank simulator and limit switches
    tank_simulator = TankLevelSimulator()
    limit_switches = LimitSwitches()

    # Simulate some operations
    tank_simulator.update_level(medium1_opened=True, medium2_opened=False, drain_opened=False)
    print(f"Current Level: {tank_simulator.get_current_level()}")

    # Update limit switches based on the current level
    limit_switches.update_switches(tank_simulator.get_current_level())
    print(f"Limit Switch States: {limit_switches.get_switch_states()}")

    # Reset the tank level
    tank_simulator.reset()
    print(f"Level after reset: {tank_simulator.get_current_level()}")