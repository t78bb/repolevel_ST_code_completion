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
