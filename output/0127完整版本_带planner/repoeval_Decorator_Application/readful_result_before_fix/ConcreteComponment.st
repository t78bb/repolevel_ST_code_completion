{attribute 'enable_dynamic_creation'}
//This class creates the most basic object well called. This object is to be decorated
FUNCTION_BLOCK ConcreteComponent IMPLEMENTS Component_Interface
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
    // Internal variables for description and value
    sDescription : STRING := '';
    rValue : REAL := 0.0;
END_VAR

METHOD SetDescription : BOOL
VAR_INPUT
    newDescription : STRING;
END_VAR
VAR
END_VAR
    sDescription := newDescription;
    SetDescription := TRUE;

METHOD SetValue : BOOL
VAR_INPUT
    newValue : REAL;
END_VAR
VAR
END_VAR
    rValue := newValue;
    SetValue := TRUE;

METHOD GetInfo : STRING
VAR
    combinedInfo : STRING;
END_VAR
    combinedInfo := CONCAT(CONCAT(sDescription, ' - '), REAL_TO_STRING(rValue));
    GetInfo := combinedInfo;

METHOD InterfaceMethod : BOOL
VAR
END_VAR
    // Ensure compatibility with Component_Interface
    InterfaceMethod := TRUE;
END_FUNCTION_BLOCK
