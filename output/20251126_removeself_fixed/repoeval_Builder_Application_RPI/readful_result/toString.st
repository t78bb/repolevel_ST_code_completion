//Method to be used in the visualization element for an easier String handling
METHOD toString : STRING
VAR_INPUT
	//List of possible parts to be build in a final Product object
	mainPart 	: STRING;
	part1 		: STRING;
	part2 		: STRING;
	part3 		: STRING;
END_VAR
VAR_OUTPUT
END_VAR

python
class Product:
    """
    Represents the final product with multiple parts.
    """
    def __init__(self):
        self.main_part = ""
        self.part1 = ""
        self.part2 = ""
        self.part3 = ""

    def to_string(self):
        """
        Combines all parts into a single string representation.
        """
        temp_string = self.main_part
        temp_string += self.part1
        temp_string += self.part2
        temp_string += self.part3
        return temp_string


class Builder:
    """
    Abstract builder class defining the interface for building parts of the product.
    """
    def __init__(self):
        self.product = Product()

    def set_main_part(self, main_part):
        self.product.main_part = main_part

    def set_part1(self, part1):
        self.product.part1 = part1

    def set_part2(self, part2):
        self.product.part2 = part2

    def set_part3(self, part3):
        self.product.part3 = part3

    def get_product(self):
        return self.product


class ConcreteBuilder(Builder):
    """
    Concrete implementation of the Builder class.
    """
    def __init__(self):
        super().__init__()

    def build_main_part(self, main_part):
        self.set_main_part(main_part)

    def build_part1(self, part1):
        self.set_part1(part1)

    def build_part2(self, part2):
        self.set_part2(part2)

    def build_part3(self, part3):
        self.set_part3(part3)


class Director:
    """
    Director class to manage the construction process.
    """
    def __init__(self, builder):
        self.builder = builder

    def construct_product(self, main_part, part1, part2, part3):
        self.builder.build_main_part(main_part)
        self.builder.build_part1(part1)
        self.builder.build_part2(part2)
        self.builder.build_part3(part3)
        return self.builder.get_product()


# Example usage
if __name__ == "__main__":
    # Create a builder instance
    builder = ConcreteBuilder()

    # Create a director instance
    director = Director(builder)

    # Construct a product
    product = director.construct_product("MainPart-", "Part1-", "Part2-", "Part3")

    # Print the product's string representation
    print(product.to_string())