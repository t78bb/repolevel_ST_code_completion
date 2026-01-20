//Method to be used in the visualization element for an easier String handling
METHOD toString : STRING
VAR_INPUT
	//List of possible parts to be build in a final Product object
	mainPart 	: STRING;
	part1 		: STRING;
	part2 		: STRING;
	part3 		: STRING;
END_VAR
VAR_OUTPUT
END_VAR
VAR
    tempString: STRING;
END_VAR

tempString := CONCAT(mainPart, part1);
tempString := CONCAT(tempString, part2);
tempString := CONCAT(tempString, part3);
toString := tempString;
RETURN;
END_OTHER
