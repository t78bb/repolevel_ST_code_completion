VAR
	// Holds a reference to the concrete builder object to send the specifications of the final product to it.
	concreteBuilder : ConcreteBuilder(specs := THIS^.concreteBuilder.specifications);
	// Variable to instantiate the concreteBuilder instance on the input section. It does not affect the Director's instantiation.
	defaultArray : ARRAY [1..4] OF STRING := ['Default', 'Default', 'Default', 'Default'];
END_VAR

// The Director class is responsible for delegating the construction of the final product object
// to a concrete builder object. The following methods define the behavior of the Director.

METHOD fb_init
VAR_INPUT
	// Reference to the builder that is going to be building the final product object.
	inputConcreteBuilder : ConcreteBuilder(specs := inputConcreteBuilder.specifications);
	// Necessary fields for the constructor
	bInitRetains : BOOL; // TRUE: the Retain-variables are initialized (reset warm / reset cold)
	bInCopyCode : BOOL;  // TRUE: the instance will be copied to the copy-code afterward (online change)
END_VAR
VAR_OUTPUT
END_VAR
VAR
	// Holds a reference to the concrete builder object to send the specifications of the final product to it.
	concreteBuilder : ConcreteBuilder(specs := THIS^.concreteBuilder.specifications);
END_VAR

// Initialize the Director instance by assigning the input concrete builder.
IF inputConcreteBuilder <> 0 THEN
	THIS^.concreteBuilder := inputConcreteBuilder;
ELSE
	// Assign default specifications if no input builder is provided.
	THIS^.concreteBuilder := ConcreteBuilder(specs := defaultArray);
END_IF;

// Ensure the Director is properly initialized.
fb_init := TRUE;

// Method to construct the product using the concrete builder.
METHOD Construct : Product
VAR_INPUT
	// Reference to the builder that is going to be building the final product object.
	inputConcreteBuilder : ConcreteBuilder(specs := inputConcreteBuilder.specifications);
END_VAR
VAR_OUTPUT
END_VAR
VAR
	// Holds a reference to the concrete builder object to send the specifications of the final product to it.
	concreteBuilder : ConcreteBuilder(specs := THIS^.concreteBuilder.specifications);
END_VAR

// Step-by-step construction process
// Step 1: Set the main part of the product.
THIS^.concreteBuilder.Set_Main_Part(THIS^.concreteBuilder.specifications[1]);

// Step 2: Set Part 1 of the product.
THIS^.concreteBuilder.Set_Part1(THIS^.concreteBuilder.specifications[2]);

// Step 3: Set Part 2 of the product.
THIS^.concreteBuilder.Set_Part2(THIS^.concreteBuilder.specifications[3]);

// Step 4: Set Part 3 of the product.
THIS^.concreteBuilder.Set_Part3(THIS^.concreteBuilder.specifications[4]);

// Deliver the final product.
Construct := THIS^.concreteBuilder.Get_Result();