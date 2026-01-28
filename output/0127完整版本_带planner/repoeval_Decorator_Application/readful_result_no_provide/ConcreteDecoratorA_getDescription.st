VAR
    originalDescription : STRING; // Local variable to store the original description
    decoratorDescription : STRING; // Local variable to store the decorator's additional description
    finalDescription : STRING; // Local variable to store the final decorated description
END_VAR

// Step 1: Retrieve the original description of the component
originalDescription := tempInputComponent.getDescription();

// Step 2: Define the decorator's additional description
decoratorDescription := ' - Decorated by A';

// Step 3: Concatenate the original description with the decorator's additional description
finalDescription := CONCAT(originalDescription, decoratorDescription);

// Step 4: Return the final decorated description
getDescription := finalDescription;
END_OTHER
