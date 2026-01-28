{attribute 'enable_dynamic_creation'}
//The director class is responsible to delegate the construction of the final product object 
// to a concrete builder object.
FUNCTION_BLOCK Director
VAR_INPUT
  //Reference to the builder that is going to be building the final product object.
  inputConcreteBuilder : ConcreteBuilder;
END_VAR
VAR_OUTPUT
END_VAR
VAR
  //Holds a reference to the concrete builder object to send the specifications of the final product to it.
  concreteBuilder : ConcreteBuilder;
END_VAR

//Stores the reference to which builder will be building the final product object in its own field THIS^.concreteBuilder
concreteBuilder := inputConcreteBuilder; // Removed the `THIS^.` prefix since it's unnecessary in a FUNCTION_BLOCK for accessing local variables

//The Director tells its concreteBuilder instance to build the final product step by step passing the specifications stored in the 
// concreteBuilder array THIS^.specifications[1..4]

//Step 1 "Main Part"
IF concreteBuilder.specifications[1] >= 0 THEN // Adjusted condition to ensure compatibility with valid numeric comparisons
 concreteBuilder.Set_Main_Part(concreteBuilder.specifications[1]);
END_IF
//Step 2 "Part 1"
IF concreteBuilder.specifications[2] >= 0 THEN // Adjusted condition to ensure compatibility with valid numeric comparisons
 concreteBuilder.Set_Part1(concreteBuilder.specifications[2]);
END_IF
//Step 3 "Part 2"
IF concreteBuilder.specifications[3] >= 0 THEN // Adjusted condition to ensure compatibility with valid numeric comparisons
 concreteBuilder.Set_Part2(concreteBuilder.specifications[3]);
END_IF
//Step 4 "Part 3"
IF concreteBuilder.specifications[4] >= 0 THEN // Adjusted condition to ensure compatibility with valid numeric comparisons
 concreteBuilder.Set_Part3(concreteBuilder.specifications[4]);
END_IF

//Finally the concreteBuilder instance in the Director object delivers the final result as a Product object
concreteBuilder.Get_Result(); // Removed `THIS^.` prefix to match the local variable context of the FUNCTION_BLOCK
END_FUNCTION_BLOCK