VAR
END_VAR

METHOD getDescription : STRING
VAR
    tempDescription : STRING;
END_VAR

tempDescription := THIS^.tempComponent.getDescription();
getDescription := CONCAT(tempDescription, THIS^.sDescription);