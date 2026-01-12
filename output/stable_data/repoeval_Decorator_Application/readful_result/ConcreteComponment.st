VAR
    //String field to store the description of the object
    sDescription : STRING := 'Basic Component';
    //Real field to store the value of the object
    rValue : REAL := 0.0;
END_VAR

METHOD PUBLIC GetDescription : STRING
VAR
END_VAR
GetDescription := sDescription;

METHOD PUBLIC GetValue : REAL
VAR
END_VAR
GetValue := rValue;

METHOD PUBLIC SetValue
VAR_INPUT
    newValue : REAL;
END_VAR
VAR
END_VAR
rValue := newValue;

METHOD PUBLIC SetDescription
VAR_INPUT
    newDescription : STRING;
END_VAR
VAR
END_VAR
sDescription := newDescription;