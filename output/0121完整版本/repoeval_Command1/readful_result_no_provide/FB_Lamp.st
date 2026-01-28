VAR
    byCurrentLevel : BYTE := 0;
END_VAR

IF byCurrentLevel <> byLevel THEN
    byCurrentLevel := byLevel;
END_IF
END_FUNCTION_BLOCK
