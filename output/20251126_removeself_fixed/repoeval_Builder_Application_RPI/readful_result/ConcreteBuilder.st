//This is the concrete builder class, reponsible for building the final product object
FUNCTION_BLOCK ConcreteBuilder IMPLEMENTS ITF_Builder
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR

//This is the concrete builder class, responsible for building the final product object
FUNCTION_BLOCK ConcreteBuilder IMPLEMENTS ITF_Builder
VAR_INPUT
    // Necessary fields for the builder
    specs : ARRAY [1..4] OF STRING; // Specifications for the product
END_VAR
VAR_OUTPUT
    // Output the final product once built
    finalProduct : Product;
END_VAR
VAR
    // Internal reference to the product being built
    localProduct : Product;

    // Internal specifications for building the product
    specifications : ARRAY [1..4] OF STRING;
END_VAR

// Initialization method for the builder
METHOD fb_init
VAR_INPUT
    bInitRetains : BOOL; // TRUE: Retain variables are initialized
    bInCopyCode : BOOL;  // TRUE: Instance will be copied to copy-code afterward
    specs : ARRAY [1..4] OF STRING; // Specifications for the product
END_VAR
VAR
END_VAR

// Store the specifications in the builder
THIS^.specifications := specs;

// Reset the local product to a new instance
THIS^.localProduct := Product();

// End of initialization
END_METHOD

// Method to set the main part of the product
METHOD Set_Main_Part
VAR_INPUT
    mainPart : STRING; // Main part of the product
END_VAR
VAR
END_VAR

// Assign the main part to the local product
THIS^.localProduct.mainPart := mainPart;

// End of method
END_METHOD

// Method to set Part 1 of the product
METHOD Set_Part1
VAR_INPUT
    part1 : STRING; // Part 1 of the product
END_VAR
VAR
END_VAR

// Assign Part 1 to the local product
THIS^.localProduct.part1 := part1;

// End of method
END_METHOD

// Method to set Part 2 of the product
METHOD Set_Part2
VAR_INPUT
    part2 : STRING; // Part 2 of the product
END_VAR
VAR
END_VAR

// Assign Part 2 to the local product
THIS^.localProduct.part2 := part2;

// End of method
END_METHOD

// Method to set Part 3 of the product
METHOD Set_Part3
VAR_INPUT
    part3 : STRING; // Part 3 of the product
END_VAR
VAR
END_VAR

// Assign Part 3 to the local product
THIS^.localProduct.part3 := part3;

// End of method
END_METHOD

// Method to get the final product
METHOD Get_Result : Product
VAR_INPUT
END_VAR
VAR
END_VAR

// Return the built product
Get_Result := THIS^.localProduct;

// End of method
END_METHOD