{attribute 'enable_dynamic_creation'}
//The class Product is just a plain bluprint of the components of the object to be built.
//The final Product may ot may not contain the all the Parts listed on the Product declaration
// rather only the parts in the specifications sent by the client.
FUNCTION_BLOCK Product
VAR_INPUT
	//List of possible parts to be build in a final Product object
	mainPart 	: STRING;
	part1 		: STRING;
	part2 		: STRING;
	part3 		: STRING;
END_VAR
VAR_OUTPUT
END_VAR

FUNCTION_BLOCK ConcreteBuilder IMPLEMENTS ITF_Builder
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
    localProduct : Product;
    specifications : ARRAY [1..4] OF STRING;
END_VAR

METHOD Set_Part1
VAR_INPUT
    part1 : STRING;
END_VAR
VAR_OUTPUT
END_VAR
VAR
END_VAR
THIS^.localProduct.part1 := part1;

METHOD Set_Part2
VAR_INPUT
    part2 : STRING;
END_VAR
VAR_OUTPUT
END_VAR
VAR
END_VAR
THIS^.localProduct.part2 := part2;

METHOD Set_Part3
VAR_INPUT
    part3 : STRING;
END_VAR
VAR_OUTPUT
END_VAR
VAR
END_VAR
THIS^.localProduct.part3 := part3;

METHOD Build
VAR_INPUT
END_VAR
VAR_OUTPUT
    finalProduct : Product;
END_VAR
VAR
END_VAR
finalProduct := THIS^.localProduct;
RETURN;
