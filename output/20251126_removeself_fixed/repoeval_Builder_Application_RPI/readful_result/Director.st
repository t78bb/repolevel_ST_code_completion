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
	concreteBuilder : ConcreteBuilder(specs := THIS^.concreteBuilder.specifications);
	//Default specifications array for initialization.
	defaultArray : ARRAY [1..4] OF STRING := ['Default', 'Default', 'Default', 'Default'];
END_VAR

//Constructor method to initialize the Director instance.
METHOD fb_init
VAR_INPUT
	//Reference to the builder that is going to be building the final product object.
	inputConcreteBuilder : ConcreteBuilder(specs := inputConcreteBuilder.specifications);
	//Necessary fields for the constructor.
	bInitRetains : BOOL; // TRUE: the Retain-variables are initialized (reset warm / reset cold).
	bInCopyCode : BOOL;  // TRUE: the instance will be copied to the copy-code afterward (online change).
END_VAR
VAR_OUTPUT
END_VAR
VAR
	//Holds a reference to the concrete builder object to send the specifications of the final product to it.
	concreteBuilder : ConcreteBuilder(specs := defaultArray);
END_VAR

//Initialize the concreteBuilder with default specifications if no input is provided.
IF inputConcreteBuilder.specifications = '' THEN
	THIS^.concreteBuilder := ConcreteBuilder(specs := defaultArray);
ELSE
	THIS^.concreteBuilder := inputConcreteBuilder;
END_IF

//Return the initialization status.
fb_init := TRUE;

//Method to construct the final product step by step.
METHOD Construct : Product
VAR_INPUT
	//Reference to the builder that is going to be building the final product object.
	inputConcreteBuilder : ConcreteBuilder(specs := inputConcreteBuilder.specifications);
END_VAR
VAR_OUTPUT
END_VAR
VAR
	//Holds a reference to the concrete builder object to send the specifications of the final product to it.
	concreteBuilder : ConcreteBuilder(specs := THIS^.concreteBuilder.specifications);
END_VAR

//Step-by-step construction process.
THIS^.concreteBuilder.Set_Main_Part(THIS^.concreteBuilder.specifications[1]);
THIS^.concreteBuilder.Set_Part1(THIS^.concreteBuilder.specifications[2]);
THIS^.concreteBuilder.Set_Part2(THIS^.concreteBuilder.specifications[3]);
THIS^.concreteBuilder.Set_Part3(THIS^.concreteBuilder.specifications[4]);

//Return the final product object.
Construct := THIS^.concreteBuilder.Get_Result();