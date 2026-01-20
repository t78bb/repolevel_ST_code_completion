{attribute 'enable_dynamic_creation'}
//The director class is responsible to delegate the construction of the final product object 
// to a concrete builder object.
FUNCTION_BLOCK Director
VAR_INPUT
	//Reference to the builder that is going to be building the final product object.
	inputConcreteBuilder : ConcreteBuilder(specs := inputConcreteBuilder.specifications);
END_VAR
VAR_OUTPUT
END_VAR
VAR
	//Holds a reference to the concrete builder object to send the specifications of the final product to it.
	concreteBuilder : ConcreteBuilder;
END_VAR

// Initialize the concreteBuilder with the inputConcreteBuilder
concreteBuilder := inputConcreteBuilder;

// Delegate the construction process to the concreteBuilder
concreteBuilder.Set_Main_Part(concreteBuilder.specifications[1]);
concreteBuilder.Set_Part1(concreteBuilder.specifications[2]);
concreteBuilder.Set_Part2(concreteBuilder.specifications[3]);
concreteBuilder.Set_Part3(concreteBuilder.specifications[4]);

// Return the final product built by the concreteBuilder
RETURN concreteBuilder.Get_Result();
END_FUNCTION_BLOCK
