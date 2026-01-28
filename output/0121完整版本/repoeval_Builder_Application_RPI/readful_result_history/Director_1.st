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

//Stores the reference to which builder will be building the final product object in its own field concreteBuilder
concreteBuilder := inputConcreteBuilder;

//The Director tells its concreteBuilder instance to build the final product step by step passing the specifications stored in the 
// concreteBuilder array THIS^.specifications[1..4]

//Step 1 "Main Part"
THIS^.concreteBuilder.Set_Main_Part(THIS^.concreteBuilder.specifications[1]);
//Step 2 "Part 1"
THIS^.concreteBuilder.Set_Part1(THIS^.concreteBuilder.specifications[2]);
//Step 3 "Part 2"
THIS^.concreteBuilder.Set_Part2(THIS^.concreteBuilder.specifications[3]);
//Step 4 "Part 3"
THIS^.concreteBuilder.Set_Part3(THIS^.concreteBuilder.specifications[4]);

//Finally, the concreteBuilder instance in the Director object delivers the final result as a Product object
concreteBuilder.Get_Result();
END_FUNCTION_BLOCK