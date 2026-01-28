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
    product : Product; // Local variable to store the final product object.
END_VAR

IF inputConcreteBuilder <> 0 THEN
    // Assign the input concrete builder to the Director's concreteBuilder field.
    THIS^.concreteBuilder := inputConcreteBuilder;

    // Step-by-step construction of the product using the concrete builder.
    THIS^.concreteBuilder.Set_Main_Part(THIS^.concreteBuilder.specifications[1]);
    THIS^.concreteBuilder.Set_Part1(THIS^.concreteBuilder.specifications[2]);
    THIS^.concreteBuilder.Set_Part2(THIS^.concreteBuilder.specifications[3]);
    THIS^.concreteBuilder.Set_Part3(THIS^.concreteBuilder.specifications[4]);

    // Retrieve the final product object from the concrete builder.
    product := THIS^.concreteBuilder.Get_Result();
    
    // Return the constructed product object.
    RETURN product;
ELSE
    // If the input concrete builder is invalid, return an empty product object.
    RETURN Product();
END_IF;
END_FUNCTION_BLOCK
