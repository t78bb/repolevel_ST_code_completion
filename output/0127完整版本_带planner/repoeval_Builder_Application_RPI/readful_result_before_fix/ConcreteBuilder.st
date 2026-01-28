//This is the concrete builder class, reponsible for building the final product object
FUNCTION_BLOCK ConcreteBuilder IMPLEMENTS ITF_Builder
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
    isCompleted : BOOL := FALSE; // Indicates if the product construction is completed
    isValid : BOOL; // Indicates if the specifications are valid
    i : INT; // Loop variable
END_VAR

// Step 1: Initialize the product object
localProduct := Product();
localProduct.Initialize();

// Step 2: Validate client specifications
isValid := TRUE;
FOR i := 1 TO 4 DO
    IF specifications[i] = '' THEN
        isValid := FALSE;
        EXIT;
    END_IF;
END_FOR;

// Step 3: Update product attributes based on specifications and director guidance
IF isValid THEN
    localProduct.Set_Main_Part(specifications[1]);
    localProduct.Set_Part1(specifications[2]);
    localProduct.Set_Part2(specifications[3]);
    localProduct.Set_Part3(specifications[4]);
END_IF;

// Step 4: Mark product as completed if valid
IF isValid THEN
    isCompleted := TRUE;
    localProduct.Mark_As_Completed();
END_IF;

// Step 5: Return the constructed product object
IF isCompleted THEN
    RETURN localProduct;
ELSE
    RETURN Product(); // Return an empty product if construction failed
END_IF;
END_FUNCTION_BLOCK
