//Illustrative method of the pattern
METHOD getDescription : STRING
VAR_INPUT
  //Reference to store the component to be decorated
  tempInputComponent : Component_Interface;
END_VAR
VAR_OUTPUT
END_VAR
VAR
  //Variable to save the state of the concrete component to be decorated
  tempComponent : Component_Interface;
  //String variable to save the Description of the component
  sDescription : STRING;
END_VAR

//Assign the input component to the local tempComponent variable
tempComponent := tempInputComponent;

//Concatenate the original description with the decorator description
getDescription := CONCAT(tempComponent.getDescription(), sDescription);
END_METHOD