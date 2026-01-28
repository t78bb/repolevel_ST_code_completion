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
