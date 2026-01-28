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
VAR
    selectedParts : ARRAY [1..4] OF STRING := ['', '', '', ''];
    index         : INT := 1;
END_VAR

IF mainPart <> '' THEN
    selectedParts[index] := mainPart;
    index := index + 1;
END_IF;

IF part1 <> '' THEN
    selectedParts[index] := part1;
    index := index + 1;
END_IF;

IF part2 <> '' THEN
    selectedParts[index] := part2;
    index := index + 1;
END_IF;

IF part3 <> '' THEN
    selectedParts[index] := part3;
    index := index + 1;
END_IF;

localProduct.mainPart := selectedParts[1];
localProduct.part1 := selectedParts[2];
localProduct.part2 := selectedParts[3];
localProduct.part3 := selectedParts[4];
END_FUNCTION_BLOCK
