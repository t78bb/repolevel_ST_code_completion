//This is the concrete builder class, reponsible for building the final product object
FUNCTION_BLOCK ConcreteBuilder IMPLEMENTS ITF_Builder
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
    // Holds an internal reference to how the final product should be so the builder class can build it on the fly
    // without any help from other classes excepting the Director class that is going to be passing the special
    // specifications to the builder.
    localProduct : Product;

    // Stores the specifications, sent by the client, of the final product to be built.
    specifications : ARRAY [1..4] OF STRING;
END_VAR

// Sets the main part of the product based on the specification
METHOD Set_Main_Part
VAR_INPUT
    mainPartSpec : STRING;
END_VAR
VAR_OUTPUT
END_VAR
VAR
END_VAR
localProduct.MainPart := mainPartSpec;

// Sets the first part of the product based on the specification
METHOD Set_Part1
VAR_INPUT
    part1Spec : STRING;
END_VAR
VAR_OUTPUT
END_VAR
VAR
END_VAR
localProduct.Part1 := part1Spec;

// Sets the second part of the product based on the specification
METHOD Set_Part2
VAR_INPUT
    part2Spec : STRING;
END_VAR
VAR_OUTPUT
END_VAR
VAR
END_VAR
localProduct.Part2 := part2Spec;

// Sets the third part of the product based on the specification
METHOD Set_Part3
VAR_INPUT
    part3Spec : STRING;
END_VAR
VAR_OUTPUT
END_VAR
VAR
END_VAR
localProduct.Part3 := part3Spec;
END_FUNCTION_BLOCK
