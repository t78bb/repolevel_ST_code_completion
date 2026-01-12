# Simulating the Tank function block in Python
class Tank:
    def __init__(self, process_in, process_out, sample_time, lower_limit, upper_limit):
        """
        Initialize the Tank object with the given parameters.
        
        :param process_in: Flow rate into the tank per second (e.g., 100).
        :param process_out: Flow rate out of the tank per second (e.g., 90).
        :param sample_time: Update time in seconds (e.g., 0.1 for 100ms).
        :param lower_limit: Minimum level of the tank (e.g., 0).
        :param upper_limit: Maximum level of the tank (e.g., 500).
        """
        self.process_in = process_in
        self.process_out = process_out
        self.sample_time = sample_time
        self.lower_limit = lower_limit
        self.upper_limit = upper_limit
        self.level = 0  # Initial tank level

    def update(self):
        """
        Update the tank level based on the input and output flow rates.
        """
        # Calculate the net flow into the tank
        net_flow = self.process_in - self.process_out

        # Update the tank level based on the net flow and sample time
        self.level += net_flow * self.sample_time

        # Ensure the tank level stays within the defined limits
        if self.level < self.lower_limit:
            self.level = self.lower_limit
        elif self.level > self.upper_limit:
            self.level = self.upper_limit

        return self.level


# Example usage of the Tank class
if __name__ == "__main__":
    # Initialize the tank with example parameters
    tank = Tank(
        process_in=100,  # Flow rate into the tank
        process_out=90,  # Flow rate out of the tank
        sample_time=0.1,  # Update time in seconds (100ms)
        lower_limit=0,  # Minimum tank level
        upper_limit=500  # Maximum tank level
    )

    # Simulate the tank for 60 seconds
    simulation_time = 60  # Total simulation time in seconds
    time_elapsed = 0

    while time_elapsed < simulation_time:
        # Update the tank level
        current_level = tank.update()

        # Print the current tank level
        print(f"Time: {time_elapsed:.1f}s, Tank Level: {current_level:.2f}")

        # Increment the elapsed time by the sample time
        time_elapsed += tank.sample_time