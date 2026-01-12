//This method is going to be called by the client when a new Product object must be built
METHOD Construct : Product  
VAR_INPUT
	//Reference to the builder that is going to be building the final product object.
	inputConcreteBuilder : ConcreteBuilder(specs := inputConcreteBuilder.specifications);
END_VAR
VAR_OUTPUT
END_VAR

//Stores the specifications, sent by the client, of the final product to be built.
specifications : ARRAY [1..4] OF STRING;
END_VAR

//The Get_Result method returns the final product built by the ConcreteBuilder
METHOD Get_Result : Product
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
    //Returns the localProduct, which is the final product built based on the specifications
    localProduct : Product;
END_VAR

//Implementation of Get_Result
Get_Result := THIS^.localProduct;

//--------------------------------------------------
// Continuation of the Construct method in the Director
//--------------------------------------------------

//Finally, the concreteBuilder instance in the Director object delivers the final result as a Product object
Construct := THIS^.concreteBuilder.Get_Result();