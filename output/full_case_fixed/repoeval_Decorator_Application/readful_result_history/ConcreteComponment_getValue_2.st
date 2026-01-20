//Illustrative method of the pattern
METHOD getValue : REAL
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
 rPlainValue : REAL;
END_VAR

// Ensure rValue is a valid member of the current instance being referenced by THIS
rPlainValue := THIS^.rValue; 
getValue := rPlainValue;
END_METHOD