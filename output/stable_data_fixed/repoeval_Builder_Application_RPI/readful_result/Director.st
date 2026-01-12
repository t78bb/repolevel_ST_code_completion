{attribute 'enable_dynamic_creation'}
//The director class is responsible to delegate the construction of the final product object 
// to a concrete builder object.
FUNCTION_BLOCK Director
VAR_INPUT
	//Reference to the builder that is going to be building the final product object.
	inputConcreteBuilder : ConcreteBuilder(specs := inputConcreteBuilder.specifications);
END_VAR
VAR_OUTPUT
END_VAR

VAR
	//Holds a reference to the concrete builder object to send the specifications of the final product to it.
	concreteBuilder : ConcreteBuilder(specs := THIS^.inputConcreteBuilder.specifications);
	//Default specifications array used for initialization.
	defaultArray : ARRAY [1..4] OF STRING := ['Default', 'Default', 'Default', 'Default'];
END_VAR

//Initialization logic for the Director instance.
METHOD fb_init
VAR_INPUT
	bInitRetains : BOOL; // TRUE: the Retain-variables are initialized (reset warm / reset cold)
	bInCopyCode : BOOL;  // TRUE: the instance will be copied to the copy-code afterward (online change)
END_VAR
VAR_OUTPUT
END_VAR

//Set the concreteBuilder instance with default specifications if not provided.
IF inputConcreteBuilder.specifications = '' THEN
	concreteBuilder := ConcreteBuilder(specs := defaultArray);
ELSE
	concreteBuilder := inputConcreteBuilder;
END_IF;

//Return initialization status.
RETURN;
