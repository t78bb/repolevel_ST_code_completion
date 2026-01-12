VAR
    // Local variable to store the base value of the component
    rBaseValue : REAL;
END_VAR

// Obtain the base value of the component
rBaseValue := THIS^.rValue;

// Return the base value as the result
getValue := rBaseValue;