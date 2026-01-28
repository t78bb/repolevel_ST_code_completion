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
// Index variable for iteration
  i : INT;
END_VAR

// Static initialization of parts as dynamic assignment is not possible without specifications
CASE i OF
  1: mainPart := 'DefaultMainPart'; // Set to static/default value
  2: part1 := 'DefaultPart1';      // Set to static/default value
  3: part2 := 'DefaultPart2';      // Set to static/default value
  4: part3 := 'DefaultPart3';      // Set to static/default value
END_CASE;
END_FUNCTION_BLOCK