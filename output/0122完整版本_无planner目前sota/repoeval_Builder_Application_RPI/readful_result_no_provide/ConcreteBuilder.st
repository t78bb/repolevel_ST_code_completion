VAR
  // Internal variables for building the product
  localProduct : Product; // Ensure 'Product' is a valid data type or function block
  specifications : ARRAY [1..4] OF STRING;
END_VAR

METHOD Set_Main_Part : BOOL // Removed erroneous VAR sections from method declarations
VAR_INPUT
  mainPart : STRING;
END_VAR
IF mainPart <> '' THEN
  localProduct.mainPart := mainPart;
  RETURN TRUE;
ELSE
  RETURN FALSE;
END_IF

METHOD Set_Part1 : BOOL // Removed erroneous VAR sections from method declarations
VAR_INPUT
  part1 : STRING;
END_VAR
IF part1 <> '' THEN
  localProduct.part1 := part1;
  RETURN TRUE;
ELSE
  RETURN FALSE;
END_IF

METHOD Set_Part2 : BOOL // Removed erroneous VAR sections from method declarations
VAR_INPUT
  part2 : STRING;
END_VAR
IF part2 <> '' THEN
  localProduct.part2 := part2;
  RETURN TRUE;
ELSE
  RETURN FALSE;
END_IF

METHOD Set_Part3 : BOOL // Removed erroneous VAR sections from method declarations
VAR_INPUT
  part3 : STRING;
END_VAR
IF part3 <> '' THEN
  localProduct.part3 := part3;
  RETURN TRUE;
ELSE
  RETURN FALSE;
END_IF

METHOD Reset : BOOL 
localProduct := (mainPart := '', part1 := '', part2 := '', part3 := ''); // Ensure initializer is valid for 'localProduct'
RETURN TRUE;

END_FUNCTION_BLOCK