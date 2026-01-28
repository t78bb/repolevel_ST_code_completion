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
    tempProduct : Product;
    // Index variable for iterating through specifications
    i : INT;
END_VAR

// Initialize the product fields directly
  mainPart := '';
  part1 := '';
  part2 := '';
  part3 := '';

  // Manually assign specifications if applicable
  // The specification logic relying on an array is removed
  // Replace dynamic logic with static input verification if needed
  
  // Assign to corresponding parts explicitly
  // Example of replacement logic if inputs exist:
  // - mainPart already corresponds to input provided by external sources
  // - Direct mapping can be done based on existing inputs, without dynamic object creation
END_FUNCTION_BLOCK