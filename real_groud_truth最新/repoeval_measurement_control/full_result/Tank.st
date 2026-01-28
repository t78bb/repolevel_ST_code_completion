FUNCTION_BLOCK Tank
VAR_INPUT
	stName: STRING;
	nMaxLevel	: INT;
	nMinLevel	: INT;
	nMaxTemp	: INT;
	nMinTemp	: INT;
	nUnitLevel							:INT:=0;
	nUnitTemp							:INT:=0;
END_VAR
VAR_OUTPUT
END_VAR

# Based on the provided code fragments, we can create a Python representation of the Tank functionality.
# Below is an implementation of a Tank class in Python:

class Tank:
    def __init__(self, st_name, n_max_level, n_min_level, n_max_temp, n_min_temp, n_unit_level=0, n_unit_temp=0):
        self.st_name = st_name
        self.n_max_level = n_max_level
        self.n_min_level = n_min_level
        self.n_max_temp = n_max_temp
        self.n_min_temp = n_min_temp
        self.n_unit_level = n_unit_level
        self.n_unit_temp = n_unit_temp

    def display_tank_info(self):
        return {
            "Name": self.st_name,
            "Max Level": self.n_max_level,
            "Min Level": self.n_min_level,
            "Max Temperature": self.n_max_temp,
            "Min Temperature": self.n_min_temp,
            "Unit Level": self.n_unit_level,
            "Unit Temperature": self.n_unit_temp,
        }

# Example usage:
tank01 = Tank(st_name="Tank01", n_max_level=99, n_min_level=0, n_max_temp=55, n_min_temp=44)
print(tank01.display_tank_info())
END_FUNCTION_BLOCK