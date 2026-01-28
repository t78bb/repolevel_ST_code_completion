VAR
    tempString: STRING;
END_VAR

tempString := CONCAT(mainPart, part1);
tempString := CONCAT(tempString, part2);
tempString := CONCAT(tempString, part3);
toString := tempString;
RETURN;
END_OTHER
