VAR
    // String field to store the description of the object
    sDescription : STRING;
    // Real field to store the value of the object
    rValue : REAL;
END_VAR

METHOD Initialize : BOOL
VAR_INPUT
    sInitDescription : STRING;
    rInitValue : REAL;
END_VAR
VAR_OUTPUT
END_VAR
VAR
END_VAR

// Method to initialize the ConcreteComponent with a description and value
Initialize := TRUE;
sDescription := sInitDescription;
rValue := rInitValue;

METHOD GetDescription : STRING
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
END_VAR

// Method to retrieve the description of the component
GetDescription := sDescription;

METHOD GetValue : REAL
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
END_VAR

// Method to retrieve the value of the component
GetValue := rValue;

METHOD SetDescription : BOOL
VAR_INPUT
    sNewDescription : STRING;
END_VAR
VAR_OUTPUT
END_VAR
VAR
END_VAR

// Method to set a new description for the component
SetDescription := TRUE;
sDescription := sNewDescription;

METHOD SetValue : BOOL
VAR_INPUT
    rNewValue : REAL;
END_VAR
VAR_OUTPUT
END_VAR
VAR
END_VAR

// Method to set a new value for the component
SetValue := TRUE;
rValue := rNewValue;