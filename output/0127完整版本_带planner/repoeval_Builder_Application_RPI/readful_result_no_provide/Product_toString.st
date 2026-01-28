VAR
    tempString : STRING := ''; // Initialize an empty string for the final result
END_VAR

IF mainPart <> '' THEN
    tempString := CONCAT(tempString, mainPart); // Add mainPart if not empty
END_IF;

IF part1 <> '' THEN
    tempString := CONCAT(tempString, part1); // Add part1 if not empty
END_IF;

IF part2 <> '' THEN
    tempString := CONCAT(tempString, part2); // Add part2 if not empty
END_IF;

IF part3 <> '' THEN
    tempString := CONCAT(tempString, part3); // Add part3 if not empty
END_IF;

toString := tempString; // Return the concatenated result
END_OTHER
