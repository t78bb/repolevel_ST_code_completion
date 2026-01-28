// AJ Jaworowski 2015-02-22
// Following the recipe by  Peter Nachtwey
// http://www.controlguru.com/wp/p80.html
FUNCTION_BLOCK HeatExchanger
VAR_INPUT
	Kp: REAL; //System gain
	Tp: REAL; //Process time
	CO: REAL; //Output from controller
	Dead_t: REAL; //The time before the system responds to the disturbance
	C: REAL; //Initial steady state value
	Sample_time: TIME;
END_VAR
VAR_OUTPUT
	PV: REAL; //Process value at t1
END_VAR

# Based on the provided code fragments, it seems you are working with a PID controller and heat exchanger models.
# To continue writing the code, let's implement a Python function that simulates the behavior of the HeatExchanger2 model.

import time

class HeatExchanger2:
    def __init__(self, heat_in, u, tc, temp_in, temp_out, sample_time):
        self.heat_in = heat_in  # Radiator heat input [W]
        self.u = u  # Thermal conductance [W/K]
        self.tc = tc  # Thermal capacity [J/K]
        self.temp_in = temp_in  # Initial room temperature [K]
        self.temp_out = temp_out  # Outside temperature [K]
        self.sample_time = sample_time  # Sampling time [seconds]
        self.temp = temp_in  # Resulting room temperature [K]
        self.last_time = time.time()  # Last update time
        self.millis = 1000  # Constant for time conversion

    def update_temperature(self):
        now = time.time()
        delta_t = now - self.last_time

        if delta_t > self.sample_time:
            heat_flow = self.u * (self.temp_out - self.temp_in) + self.heat_in
            self.temp += (heat_flow / self.tc) * delta_t
            self.last_time = now

        return self.temp


# Example usage:
heat_exchanger = HeatExchanger2(
    heat_in=500,  # Example heat input [W]
    u=0.1,  # Example thermal conductance [W/K]
    tc=1000,  # Example thermal capacity [J/K]
    temp_in=293,  # Example initial room temperature [K]
    temp_out=283,  # Example outside temperature [K]
    sample_time=1  # Example sampling time [seconds]
)

# Simulate the heat exchanger behavior over time
for _ in range(10):  # Simulate 10 updates
    current_temp = heat_exchanger.update_temperature()
    print(f"Current Temperature: {current_temp:.2f} K")
    time.sleep(1)  # Wait for 1 second (simulate real-time updates)
END_FUNCTION_BLOCK