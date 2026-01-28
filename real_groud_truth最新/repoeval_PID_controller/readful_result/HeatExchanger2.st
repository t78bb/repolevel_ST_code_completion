# The code fragments provided above are written in Structured Text (ST), commonly used in industrial automation systems.
# To continue writing Python code that might interact with or simulate the behavior of the HeatExchanger function block, 
# we can create a Python class to model the same behavior.

class HeatExchanger:
    def __init__(self, Kp, Tp, CO, Dead_t, C, Sample_time):
        """
        Initialize the HeatExchanger model parameters.
        """
        self.Kp = Kp  # System gain
        self.Tp = Tp  # Process time
        self.CO = CO  # Output from controller
        self.Dead_t = Dead_t  # Time before system responds to disturbance
        self.C = C  # Initial steady state value
        self.Sample_time = Sample_time  # Sample time in seconds
        self.lastPV = 140  # Initial process value
        self.millis = 1000  # Conversion factor for milliseconds
        self.lastTime = 0  # Last time the system was updated

    def update(self, current_time):
        """
        Update the process value (PV) based on the current time and input parameters.
        """
        delta_t = (current_time - self.lastTime) / self.millis
        if delta_t > self.Sample_time:
            A = math.exp(-delta_t / self.Tp)
            B = 1 - A
            self.lastPV = A * self.lastPV + B * self.Kp * self.CO + self.C
            self.lastTime = current_time
        return self.lastPV


class HeatExchanger2:
    def __init__(self, Heat_In, U, TC, Temp_In, Temp_Out, Sample_time):
        """
        Initialize the HeatExchanger2 model parameters.
        """
        self.Heat_In = Heat_In  # Radiator heat input [W]
        self.U = U  # Thermal conductance [W/K]
        self.TC = TC  # Thermal capacity [J/K]
        self.Temp_In = Temp_In  # Initial room temperature [K]
        self.Temp_Out = Temp_Out  # Outside temperature [K]
        self.Sample_time = Sample_time  # Sample time in seconds
        self.Temp = Temp_In  # Current room temperature

    def update(self, current_time):
        """
        Update the room temperature based on the current time and input parameters.
        """
        delta_t = self.Sample_time
        heat_transfer = self.U * (self.Temp_Out - self.Temp)
        self.Temp += (self.Heat_In + heat_transfer) * delta_t / self.TC
        return self.Temp