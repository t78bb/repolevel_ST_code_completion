//Holds an internal reference to how the final product should be so the builder class can build it on the fly 
//without any help from other classes excepting the Director class that is going to be passing the special specifications.
localProduct : Product;

//Stores the specifications, sent by the client, of the final product to be built.
specifications : ARRAY [1..4] OF STRING;

//Method to set the main part of the product
METHOD Set_Main_Part : VOID
VAR_INPUT
    mainPartSpec : STRING; // Specification for the main part
END_VAR
VAR_OUTPUT
END_VAR
VAR
END_VAR
THIS^.localProduct.mainPart := mainPartSpec;

//Method to set Part 1 of the product
METHOD Set_Part1 : VOID
VAR_INPUT
    part1Spec : STRING; // Specification for Part 1
END_VAR
VAR_OUTPUT
END_VAR
VAR
END_VAR
THIS^.localProduct.part1 := part1Spec;

//Method to set Part 2 of the product
METHOD Set_Part2 : VOID
VAR_INPUT
    part2Spec : STRING; // Specification for Part 2
END_VAR
VAR_OUTPUT
END_VAR
VAR
END_VAR
THIS^.localProduct.part2 := part2Spec;

//Method to set Part 3 of the product
METHOD Set_Part3 : VOID
VAR_INPUT
    part3Spec : STRING; // Specification for Part 3
END_VAR
VAR_OUTPUT
END_VAR
VAR
END_VAR
THIS^.localProduct.part3 := part3Spec;

//Method to get the final product
METHOD Get_Result : Product
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
END_VAR
Get_Result := THIS^.localProduct;