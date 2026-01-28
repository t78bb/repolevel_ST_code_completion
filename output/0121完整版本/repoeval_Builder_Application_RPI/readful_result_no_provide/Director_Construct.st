VAR
	//Holds a reference to the concrete builder object to send the specifications of the final product to it.
	concreteBuilder : ConcreteBuilder(specs := THIS^.inputConcreteBuilder.specifications);
END_VAR

//Step 1 "Main Part"
concreteBuilder.Set_Main_Part(concreteBuilder.specifications[1]);
//Step 2 "Part 1"
concreteBuilder.Set_Part1(concreteBuilder.specifications[2]);
//Step 3 "Part 2"
concreteBuilder.Set_Part2(concreteBuilder.specifications[3]);
//Step 4 "Part 3"
concreteBuilder.Set_Part3(concreteBuilder.specifications[4]);

//Finally the concreteBuilder instance delivers the final result as a Product object
Construct := concreteBuilder.Get_Result();
RETURN;
END_OTHER
