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

# --------------------------------------------------
# the below code fragment can be found in:
# Builder_Application_RPI-FUN\ConcreteBuilder_Set_Part1.st (continued)
# --------------------------------------------------
# //Illustrative method of the pattern to set the part1 (continued)
# VAR
# 	//Holds an internal reference to how the final product should be so the builder class can build it on the fly 
# 	// without any help from other classes excepting the Director class that is going to be passing the special
# 	// specifications to the builder.
# 	localProduct : Product;
# 	
# 	//Stores the specifications, sent by the client, of the final product to be built.
# 	specifications : ARRAY [1..4] OF STRING;
# END_VAR
# 
# //Sets the passed value to its corresponding field. 
# //We can say that the final product is in process of being built.
# //So this is a step into building the final product done by the builder.
# THIS^.localProduct.part1 := part1;

# --------------------------------------------------
# the below code fragment can be found in:
# Builder_Application_RPI-FUN\ConcreteBuilder_Build_Product.st
# --------------------------------------------------
# //Illustrative method of the pattern to build the final product
METHOD Build_Product
VAR_INPUT
END_VAR
VAR_OUTPUT
	//Returns the final product object built by the builder
	finalProduct : Product;
END_VAR
VAR
	//Holds an internal reference to how the final product should be so the builder class can build it on the fly 
	// without any help from other classes excepting the Director class that is going to be passing the special
	// specifications to the builder.
	localProduct : Product;
END_VAR

//Builds the final product based on the specifications provided by the client
IF THIS^.specifications[1] <> '' THEN
	THIS^.localProduct.mainPart := THIS^.specifications[1];
END_IF

IF THIS^.specifications[2] <> '' THEN
	THIS^.localProduct.part1 := THIS^.specifications[2];
END_IF

IF THIS^.specifications[3] <> '' THEN
	THIS^.localProduct.part2 := THIS^.specifications[3];
END_IF

IF THIS^.specifications[4] <> '' THEN
	THIS^.localProduct.part3 := THIS^.specifications[4];
END_IF

//Returns the fully built product
finalProduct := THIS^.localProduct;
END_FUNCTION_BLOCK