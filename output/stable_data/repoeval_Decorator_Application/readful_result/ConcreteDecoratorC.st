VAR
END_VAR

METHOD getDescription : STRING
VAR_INPUT
END_VAR

getDescription := CONCAT(THIS^.tempComponent.getDescription(), THIS^.sDescription);