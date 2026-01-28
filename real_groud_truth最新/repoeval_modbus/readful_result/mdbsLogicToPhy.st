# Python implementation of the logic described in the provided code fragments.

class ModbusMapping:
    def __init__(self):
        # Define mappings for groundExtend and groundRetract
        self.ground_extend_mapping = {
            1: 223,  # grd1e -> 横1
            2: 231,  # grd2e -> 纵1
            3: 224,  # grd3e -> 横2
            4: 225,  # grd4e -> 横3
            5: 226,  # grd5e -> 横4
            6: 227,  # grd6e -> 横5
            7: 232,  # grd7e -> 纵2
            8: 228,  # grd8e -> 横6
            9: 229,  # grd9e -> 横7
            10: 230  # grd10e -> 横8
        }

        self.ground_retract_mapping = {
            # Placeholder for groundRetract mappings
            # Add mappings here based on the logic in the original code
        }

    def phy_to_logic(self, section, phy_idx):
        """
        Maps physical index to logical index based on the section.
        :param section: int - The section identifier (1: groundExtend, 2: groundRetract, etc.)
        :param phy_idx: int - The physical index
        :return: int - The logical index or None if not found
        """
        if section == 1:  # groundExtend
            return self.ground_extend_mapping.get(phy_idx, None)
        elif section == 2:  # groundRetract
            return self.ground_retract_mapping.get(phy_idx, None)
        else:
            return None

    def logic_to_phy(self, section, lgc_idx):
        """
        Maps logical index to physical index based on the section.
        :param section: int - The section identifier (1: groundExtend, 2: groundRetract, etc.)
        :param lgc_idx: int - The logical index
        :return: tuple - (level, phy_idx, direction) or None if not found
        """
        if section == 1:  # groundExtend
            for phy_idx, logic in self.ground_extend_mapping.items():
                if logic == lgc_idx:
                    return (1, phy_idx, "Extend")  # Example: level=1 for ground
        elif section == 2:  # groundRetract
            for phy_idx, logic in self.ground_retract_mapping.items():
                if logic == lgc_idx:
                    return (1, phy_idx, "Retract")  # Example: level=1 for ground
        return None


# Example usage
modbus = ModbusMapping()

# Test phy_to_logic
section = 1  # groundExtend
phy_idx = 3
lgc_idx = modbus.phy_to_logic(section, phy_idx)
print(f"Logical index for section {section}, physical index {phy_idx}: {lgc_idx}")

# Test logic_to_phy
lgc_idx = 224  # Example logical index
result = modbus.logic_to_phy(section, lgc_idx)
print(f"Physical index for section {section}, logical index {lgc_idx}: {result}")
``` 

This Python implementation provides a way to map between physical and logical indices based on the section, following the logic described in the provided code fragments. You can extend the mappings and logic for other sections (e.g., `groundRetract`, `skyExtend`, etc.) as needed.