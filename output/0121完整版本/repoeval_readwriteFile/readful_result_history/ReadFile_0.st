FUNCTION_BLOCK ReadFile
VAR_INPUT
	bExec	:	BOOL;//功能块触发变量
	fileName	:	STRING;//文件的路径
END_VAR
VAR
	nState	:	BYTE;
	fileHandle	:	UDINT;//文件句柄
	i	:	BYTE;//定义循环变量
	
	fbRtrig	:	R_TRIG;//实例化上升沿触发功能块
END_VAR
VAR_OUTPUT
	ReadBuffer	:	ARRAY[0..255] OF BYTE;//读数缓冲区
	nNumRead	:	UDINT;//读取文件的字节数
	bDone	:	BOOL;//写入成功
	bBusy	:	BOOL;//写入忙
	bErr	:	BOOL;//写入出错
	nErrId	:	UDINT;//错误代码
END_VAR

CASE nState OF
	0:
		fbRtrig(CLK := bExec);//等待用户触发调用
		IF fbRtrig.Q THEN
			nState := 1;
			nNumRead := 0;
			bBusy := TRUE;
			bErr := FALSE;
			nErrId := 0;
			bDone := FALSE;
		END_IF
	1:
		//打开文件
		fileHandle := SysFileOpen(szFile := fileName, am := 'r');
		IF fileHandle = UDINT_TO_DINT(-1) THEN
			bErr := TRUE;
			nErrId := SysFileGetLastError();
			nState := 0;
			bBusy := FALSE;
		ELSE
			nState := 2;
		END_IF
	2:
		//读取文件
		nNumRead := SysFileRead(hFile := fileHandle, pbyBuffer := ADR(ReadBuffer), uiSize := SIZEOF(ReadBuffer));
		IF nNumRead = UDINT_TO_DINT(-1) THEN
			bErr := TRUE;
			nErrId := SysFileGetLastError();
			nState := 3;
		ELSE
			nState := 3;
		END_IF
	3:
		//关闭文件
		IF SysFileClose(hFile := fileHandle) THEN
			nState := 0;
			bBusy := FALSE;
			bDone := TRUE;
		ELSE
			bErr := TRUE;
			nErrId := SysFileGetLastError();
			nState := 0;
			bBusy := FALSE;
		END_IF
END_CASE
END_FUNCTION_BLOCK
