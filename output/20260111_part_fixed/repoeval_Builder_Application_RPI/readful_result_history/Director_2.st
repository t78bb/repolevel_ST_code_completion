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

// Ensure concreteBuilder is initialized and valid before assignments
IF inputConcreteBuilder <> NULL THEN
 concreteBuilder := inputConcreteBuilder;

 // Ensure specifications array is properly indexed and initialized before operations
 IF concreteBuilder.specifications[1] <> NULL THEN
  //Step 1 "Main Part"
  concreteBuilder.Set_Main_Part(concreteBuilder.specifications[1]);
 END_IF;

 IF concreteBuilder.specifications[2] <> NULL THEN
  //Step 2 "Part 1"
  concreteBuilder.Set_Part1(concreteBuilder.specifications[2]);
 END_IF;

 IF concreteBuilder.specifications[3] <> NULL THEN
  //Step 3 "Part 2"
  concreteBuilder.Set_Part2(concreteBuilder.specifications[3]);
 END_IF;

 IF concreteBuilder.specifications[4] <> NULL THEN
  //Step 4 "Part 3"
  concreteBuilder.Set_Part3(concreteBuilder.specifications[4]);
 END_IF;
END_IF;

// Return to exit function block
RETURN;
END_FUNCTION_BLOCK