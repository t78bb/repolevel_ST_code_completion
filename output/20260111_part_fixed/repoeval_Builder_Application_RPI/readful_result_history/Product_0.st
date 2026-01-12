VAR
END_VAR

// Implementation of the Product FUNCTION_BLOCK
// This FUNCTION_BLOCK serves as a blueprint for the components of the object to be built.
// It does not contain any specific logic as it is primarily used for data representation.

METHOD Initialize
VAR_INPUT
	mainPartInit : STRING;
	part1Init    : STRING;
	part2Init    : STRING;
	part3Init    : STRING;
END_VAR
VAR_OUTPUT
END_VAR
VAR
END_VAR

// Assign initial values to the parts of the product
THIS^.mainPart := mainPartInit;
THIS^.part1 := part1Init;
THIS^.part2 := part2Init;
THIS^.part3 := part3Init;