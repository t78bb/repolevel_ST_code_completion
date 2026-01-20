//Illustrative method of the pattern
METHOD getValue : REAL
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
  rPlainValue : REAL;
END_VAR

rPlainValue := THIS^.rValue;
getValue := rPlainValue;
END_METHOD