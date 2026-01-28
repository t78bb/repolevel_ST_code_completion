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
    //Local variable to join together and store the pieces of String
    tempString: STRING;
END_VAR

//Concatenate "mainPart" and "part1"
tempString := CONCAT(mainPart, part1);
//Concatenate the current value of "tempString" with "part2"
tempString := CONCAT(tempString, part2);
//Concatenate the current value of "tempString" with "part3"
tempString := CONCAT(tempString, part3);
//Return the final concatenated string
toString := tempString;
RETURN;
END_OTHER
