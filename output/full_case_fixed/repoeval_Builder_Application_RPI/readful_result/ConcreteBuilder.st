//This is the concrete builder class, reponsible for building the final product object
FUNCTION_BLOCK ConcreteBuilder IMPLEMENTS ITF_Builder
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
    localProduct : Product;
    specifications : ARRAY [1..4] OF STRING;
END_VAR

METHOD Set_Main_Part : BOOL
VAR_INPUT
    mainPart : STRING;
END_VAR
VAR_OUTPUT
END_VAR
VAR
END_VAR
    localProduct.mainPart := mainPart;
    RETURN TRUE;

METHOD Set_Part1 : BOOL
VAR_INPUT
    part1 : STRING;
END_VAR
VAR_OUTPUT
END_VAR
VAR
END_VAR
    localProduct.part1 := part1;
    RETURN TRUE;

METHOD Set_Part2 : BOOL
VAR_INPUT
    part2 : STRING;
END_VAR
VAR_OUTPUT
END_VAR
VAR
END_VAR
    localProduct.part2 := part2;
    RETURN TRUE;

METHOD Set_Part3 : BOOL
VAR_INPUT
    part3 : STRING;
END_VAR
VAR_OUTPUT
END_VAR
VAR
END_VAR
    localProduct.part3 := part3;
    RETURN TRUE;

METHOD Get_Result : Product
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
END_VAR
    RETURN localProduct;
END_FUNCTION_BLOCK
