VAR
    selectedParts : ARRAY [1..4] OF STRING := ['', '', '', ''];
    index         : INT := 1;
END_VAR

IF mainPart <> '' THEN
    selectedParts[index] := mainPart;
    index := index + 1;
END_IF;

IF part1 <> '' THEN
    selectedParts[index] := part1;
    index := index + 1;
END_IF;

IF part2 <> '' THEN
    selectedParts[index] := part2;
    index := index + 1;
END_IF;

IF part3 <> '' THEN
    selectedParts[index] := part3;
    index := index + 1;
END_IF;

// Direct assignment to localProduct was invalid and has been removed.
END_FUNCTION_BLOCK
END_FUNCTION_BLOCK