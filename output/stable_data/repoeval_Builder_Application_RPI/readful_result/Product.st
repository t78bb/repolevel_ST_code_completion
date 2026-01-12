FUNCTION_BLOCK ConcreteBuilder IMPLEMENTS ITF_Builder
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
    localProduct : Product;
    specifications : ARRAY [1..4] OF STRING;
END_VAR

METHOD Set_Part1
VAR_INPUT
    part1 : STRING;
END_VAR
VAR_OUTPUT
END_VAR
VAR
END_VAR
THIS^.localProduct.part1 := part1;

METHOD Set_Part2
VAR_INPUT
    part2 : STRING;
END_VAR
VAR_OUTPUT
END_VAR
VAR
END_VAR
THIS^.localProduct.part2 := part2;

METHOD Set_Part3
VAR_INPUT
    part3 : STRING;
END_VAR
VAR_OUTPUT
END_VAR
VAR
END_VAR
THIS^.localProduct.part3 := part3;

METHOD Build
VAR_INPUT
END_VAR
VAR_OUTPUT
    finalProduct : Product;
END_VAR
VAR
END_VAR
finalProduct := THIS^.localProduct;
RETURN;