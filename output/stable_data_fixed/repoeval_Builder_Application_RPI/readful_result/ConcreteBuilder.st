//This is the concrete builder class, reponsible for building the final product object
FUNCTION_BLOCK ConcreteBuilder IMPLEMENTS ITF_Builder
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR

VAR
    // Internal variables for the ConcreteBuilder
    localProduct : Product; // Holds the final product being built
    specifications : ARRAY [1..4] OF STRING; // Stores the specifications for the product
END_VAR

// Implementation of the ConcreteBuilder methods

METHOD fb_init
VAR_INPUT
    bInitRetains : BOOL; // TRUE: Retain variables are initialized
    bInCopyCode : BOOL;  // TRUE: Instance will be copied to the copy-code afterward
    specs : ARRAY [1..4] OF STRING; // Specifications for the product
END_VAR
VAR
END_VAR

// Initialize the specifications
THIS^.specifications := specs;

// Initialize the localProduct object
THIS^.localProduct := Product();

// Return success
fb_init := TRUE;

METHOD Set_Main_Part
VAR_INPUT
    mainPart : STRING; // Main part of the product
END_VAR
VAR
END_VAR

// Set the main part of the product
THIS^.localProduct.MainPart := mainPart;

METHOD Set_Part1
VAR_INPUT
    part1 : STRING; // First part of the product
END_VAR
VAR
END_VAR

// Set the first part of the product
THIS^.localProduct.Part1 := part1;

METHOD Set_Part2
VAR_INPUT
    part2 : STRING; // Second part of the product
END_VAR
VAR
END_VAR

// Set the second part of the product
THIS^.localProduct.Part2 := part2;

METHOD Set_Part3
VAR_INPUT
    part3 : STRING; // Third part of the product
END_VAR
VAR
END_VAR

// Set the third part of the product
THIS^.localProduct.Part3 := part3;

METHOD Get_Result : Product
VAR_INPUT
END_VAR
VAR
END_VAR

// Return the final product
Get_Result := THIS^.localProduct;
