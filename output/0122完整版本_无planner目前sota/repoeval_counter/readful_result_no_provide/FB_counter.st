VAR
    nPrevValue: INT;    (*存储之前的数值*)
END_VAR

IF bReset THEN
    nValue := 0;        (*数据清零*)
ELSIF bUp THEN
    nValue := nValue + 1; (*数据递增*)
ELSIF bDown THEN
    nValue := nValue - 1; (*数据递减*)
END_IF

nPrevValue := nValue;    (*更新之前的数值*)
END_FUNCTION_BLOCK
