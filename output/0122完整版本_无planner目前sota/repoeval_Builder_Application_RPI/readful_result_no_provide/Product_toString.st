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
