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
    // Temporary variable to hold the dynamically created product
// Index variable for iterating through specifications
  i : INT;
END_VAR

// Initialize the existing product fields directly without using tempProduct
mainPart := '';
part1 := '';
part2 := '';
part3 := '';

// Manually assign or override the product inputs if necessary based on existing logic
// For example, inputs may already provide sufficient data

// Use the existing input variables as-is without creating temporary objects
END_FUNCTION_BLOCK