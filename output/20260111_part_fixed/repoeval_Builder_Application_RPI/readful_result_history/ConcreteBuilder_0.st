VAR
    localProduct : Product;
    specifications : ARRAY [1..4] OF STRING;
END_VAR

METHOD fb_init
VAR_INPUT
    bInitRetains : BOOL;
    bInCopyCode : BOOL;
    specs : ARRAY [1..4] OF STRING;
END_VAR
VAR
END_VAR

THIS^.specifications := specs;

METHOD Get_Result : Product
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
END_VAR

Get_Result := THIS^.localProduct;

METHOD Set_Main_Part
VAR_INPUT
    mainPartSpec : STRING;
END_VAR
VAR_OUTPUT
END_VAR
VAR
END_VAR

THIS^.localProduct.MainPart := mainPartSpec;

METHOD Set_Part1
VAR_INPUT
    part1Spec : STRING;
END_VAR
VAR_OUTPUT
END_VAR
VAR
END_VAR

THIS^.localProduct.Part1 := part1Spec;

METHOD Set_Part2
VAR_INPUT
    part2Spec : STRING;
END_VAR
VAR_OUTPUT
END_VAR
VAR
END_VAR

THIS^.localProduct.Part2 := part2Spec;

METHOD Set_Part3
VAR_INPUT
    part3Spec : STRING;
END_VAR
VAR_OUTPUT
END_VAR
VAR
END_VAR

THIS^.localProduct.Part3 := part3Spec;