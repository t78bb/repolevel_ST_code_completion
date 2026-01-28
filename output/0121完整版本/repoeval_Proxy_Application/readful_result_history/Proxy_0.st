{attribute 'enable_dynamic_creation'}
FUNCTION_BLOCK Proxy IMPLEMENTS  Subject_Interface
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
	refToRealSubject : POINTER TO Realsubject;
	iTempPassword : INT;
END_VAR
VAR_STAT
	iRealPassword : INT := 1234;
END_VAR

METHOD fb_init
VAR_INPUT
	bInitRetains : BOOL;
	bInCopyCode : BOOL;
	ptrToRealSubject : POINTER TO Realsubject;
	iTempPassword : INT;
	iSetValue : INT;
	bReadWrite : BOOL;
END_VAR
VAR_OUTPUT
END_VAR
VAR
	refToRealSubject : POINTER TO Realsubject;
	iTempPassword : INT;
END_VAR

IF ptrToRealSubject <> 0 THEN
	refToRealSubject := ptrToRealSubject;
END_IF;

IF iTempPassword = iRealPassword THEN
	IF bReadWrite THEN
		refToRealSubject^.iProp := iSetValue;
	ELSE
		iSetValue := refToRealSubject^.iProp;
	END_IF;
END_IF;
END_FUNCTION_BLOCK
