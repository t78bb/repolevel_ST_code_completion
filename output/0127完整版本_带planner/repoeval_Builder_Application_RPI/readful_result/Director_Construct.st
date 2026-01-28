//This method is going to be called by the client when a new Product object must be built
METHOD Construct : Product  
VAR_INPUT
	//Reference to the builder that is going to be building the final product object.
	inputConcreteBuilder : ConcreteBuilder(specs := inputConcreteBuilder.specifications);
END_VAR
VAR_OUTPUT
END_VAR
VAR
    specifications : ARRAY [1..4] OF STRING;
    finalProduct : Product;
END_VAR

// Step 1: Retrieve specifications from inputConcreteBuilder
specifications := inputConcreteBuilder.specifications;

// Step 2: Initialize a new Product object using inputConcreteBuilder
inputConcreteBuilder.Initialize_Product();

// Step 3: Build the Product step by step based on specifications
inputConcreteBuilder.Set_Main_Part(specifications[1]);
inputConcreteBuilder.Set_Part1(specifications[2]);
inputConcreteBuilder.Set_Part2(specifications[3]);
inputConcreteBuilder.Set_Part3(specifications[4]);

// Step 4: Confirm Product construction is complete and return the final Product
finalProduct := inputConcreteBuilder.Get_Result();
Construct := finalProduct;
RETURN;
END_OTHER
