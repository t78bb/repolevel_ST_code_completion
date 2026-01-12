# --------------------------------------------------
# Continue writing the code for the Builder pattern implementation
# --------------------------------------------------

# The below code fragment can be found in:
# Builder_Application_RPI-FUN\ConcreteBuilder_Set_MainPart.st
# --------------------------------------------------
# //Illustrative method of the pattern to set the mainPart
METHOD Set_MainPart
VAR_INPUT
	//Illustrative value (object because it is a STRING) to be set as the main part of the product
	mainPart	: STRING;
END_VAR
VAR_OUTPUT
END_VAR
VAR
	//Holds an internal reference to how the final product should be so the builder class can build it on the fly 
	// without any help from other classes excepting the Director class that is going to be passing the special
	// specifications to the builder.
	localProduct : Product;
	
	//Stores the specifications, sent by the client, of the final product to be built.
	specifications : ARRAY [1..4] OF STRING;
END_VAR

// Sets the passed value to its corresponding field.
// We can say that the final product is in the process of being built.
// So this is a step into building the final product done by the builder.
THIS^.localProduct.mainPart := mainPart;

# --------------------------------------------------
# The below code fragment can be found in:
# Builder_Application_RPI-FUN\Director_Build_Product.st
# --------------------------------------------------
# //Illustrative method of the Director to build the final product using the builder
METHOD Build_Product
VAR_INPUT
	//Reference to the builder that is going to be building the final product object.
	builder	: ConcreteBuilder;
END_VAR
VAR_OUTPUT
	//The final product object built by the builder
	finalProduct : Product;
END_VAR
VAR
	//Temporary variable to hold the specifications for the product
	tempSpecifications : ARRAY [1..4] OF STRING;
END_VAR

// Pass the specifications to the builder
builder.specifications := tempSpecifications;

// Delegate the construction of each part to the builder
builder.Set_MainPart('Main Component');
builder.Set_Part1('Part 1 Component');
builder.Set_Part2('Part 2 Component');
builder.Set_Part3('Part 3 Component');

// Retrieve the final product from the builder
finalProduct := builder.localProduct;

# --------------------------------------------------
# The below code fragment can be found in:
# Builder_Application_RPI-FUN\Client.st
# --------------------------------------------------
# //Illustrative code for the client to use the Builder pattern
PROGRAM Client
VAR
	//Reference to the Director
	director : Director;
	
	//Reference to the ConcreteBuilder
	builder : ConcreteBuilder;
	
	//Final product built by the builder
	finalProduct : Product;
END_VAR

// Initialize the builder and director
builder := ConcreteBuilder();
director := Director(inputConcreteBuilder := builder);

// Use the director to build the product
finalProduct := director.Build_Product(builder);

// Output the final product details
PRINT(finalProduct.mainPart);
PRINT(finalProduct.part1);
PRINT(finalProduct.part2);
PRINT(finalProduct.part3);