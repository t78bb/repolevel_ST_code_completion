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

// Initialize the temporary product object
tempProduct.mainPart := '';
tempProduct.part1 := '';
tempProduct.part2 := '';
tempProduct.part3 := '';

// Iterate through the specifications array to dynamically set parts of the product
FOR i := 1 TO SIZEOF(specifications) DO
    CASE specifications[i] OF
        'mainPart':
            tempProduct.mainPart := specifications[i];
        'part1':
            tempProduct.part1 := specifications[i];
        'part2':
            tempProduct.part2 := specifications[i];
        'part3':
            tempProduct.part3 := specifications[i];
        ELSE
            // Do nothing for unspecified parts
    END_CASE;
END_FOR;

// Assign the dynamically created product to the localProduct field
localProduct := tempProduct;
END_FUNCTION_BLOCK
