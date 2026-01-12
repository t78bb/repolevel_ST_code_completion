VAR
    // Holds a reference to the concrete builder object to send the specifications of the final product to it.
    concreteBuilder : ConcreteBuilder(specs := inputConcreteBuilder.specifications);
END_VAR

// The Director tells its concreteBuilder instance to build the final product step by step passing the specifications stored in the 
// concreteBuilder array inputConcreteBuilder.specifications[1..4]

// Step 1 "Main Part"
concreteBuilder.Set_Main_Part(inputConcreteBuilder.specifications[1]);
// Step 2 "Part 1"
concreteBuilder.Set_Part1(inputConcreteBuilder.specifications[2]);
// Step 3 "Part 2"
concreteBuilder.Set_Part2(inputConcreteBuilder.specifications[3]);
// Step 4 "Part 3"
concreteBuilder.Set_Part3(inputConcreteBuilder.specifications[4]);

// Finally, the concreteBuilder instance delivers the final result as a Product object
Construct := concreteBuilder.Get_Result();
RETURN;