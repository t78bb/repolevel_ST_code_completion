//This is the concrete builder class, reponsible for building the final product object
FUNCTION_BLOCK ConcreteBuilder IMPLEMENTS ITF_Builder
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
    // Internal variables for building the product
    localProduct : Product;
    specifications : ARRAY [1..4] OF STRING;
END_VAR

// Method to set the main part of the product
METHOD Set_Main_Part : BOOL
VAR_INPUT
    mainPart : STRING;
END_VAR
VAR
END_VAR
IF mainPart <> '' THEN
    localProduct.mainPart := mainPart;
    RETURN TRUE;
ELSE
    RETURN FALSE;
END_IF

// Method to set Part1 of the product
METHOD Set_Part1 : BOOL
VAR_INPUT
    part1 : STRING;
END_VAR
VAR
END_VAR
IF part1 <> '' THEN
    localProduct.part1 := part1;
    RETURN TRUE;
ELSE
    RETURN FALSE;
END_IF

// Method to set Part2 of the product
METHOD Set_Part2 : BOOL
VAR_INPUT
    part2 : STRING;
END_VAR
VAR
END_VAR
IF part2 <> '' THEN
    localProduct.part2 := part2;
    RETURN TRUE;
ELSE
    RETURN FALSE;
END_IF

// Method to set Part3 of the product
METHOD Set_Part3 : BOOL
VAR_INPUT
    part3 : STRING;
END_VAR
VAR
END_VAR
IF part3 <> '' THEN
    localProduct.part3 := part3;
    RETURN TRUE;
ELSE
    RETURN FALSE;
END_IF

// Method to reset the builder to its initial state
METHOD Reset : BOOL
VAR
END_VAR
localProduct := (mainPart := '', part1 := '', part2 := '', part3 := '');
RETURN TRUE;
END_FUNCTION_BLOCK
