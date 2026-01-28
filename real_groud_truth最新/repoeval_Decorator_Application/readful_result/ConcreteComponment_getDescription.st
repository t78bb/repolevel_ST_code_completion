VAR
    // Variable to store the description of the component
    sDescription : STRING;
    // Variable to store the reference to the component being decorated
    tempComponent : Component_Interface;
END_VAR

// Check if the component exists and has a description
IF tempComponent <> NULL THEN
    // Obtain the description of the component and concatenate additional decoration
    getDescription := CONCAT(tempComponent.getDescription(), ' Additional Decoration');
ELSE
    // If no component exists, return a default description
    getDescription := 'Default Description';
END_IF;