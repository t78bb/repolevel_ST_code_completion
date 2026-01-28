//Illustrative method of the pattern
METHOD getValue : REAL
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
    rPlainValue : REAL; // Local variable to store the plain value
END_VAR

rPlainValue := THIS^.rValue; // Extract the core value of the object
getValue := rPlainValue; // Assign the extracted value to the return value
RETURN; // Return the result to the caller
END_OTHER
