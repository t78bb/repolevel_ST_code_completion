VAR
    // Variable to store the description of the component
    sDescription : STRING;
    // Reference to the component to be decorated
    tempComponent : Component_Interface;
END_VAR

// Outputs the description of the component to be decorated
// If the component is decorated, it concatenates the current decoration description
sDescription := THIS^.tempComponent.getDescription();
getDescription := CONCAT(sDescription, THIS^.sDescription);