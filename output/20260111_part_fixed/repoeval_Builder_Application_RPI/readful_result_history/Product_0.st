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
    i : INT; // Loop index
END_VAR

FOR i := 1 TO 4 DO
    CASE specifications[i] OF
        'mainPart' : 
            localProduct.mainPart := specifications[i];
        'part1' : 
            localProduct.part1 := specifications[i];
        'part2' : 
            localProduct.part2 := specifications[i];
        'part3' : 
            localProduct.part3 := specifications[i];
    END_CASE;
END_FOR;
END_FUNCTION_BLOCK
