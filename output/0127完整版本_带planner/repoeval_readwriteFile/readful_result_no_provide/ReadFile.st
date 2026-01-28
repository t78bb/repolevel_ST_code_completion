VAR
	nState	:	BYTE;
	fileHandle	:	UDINT;//文件句柄
	readResult	:	UDINT;//读取结果
	fbRtrig	:	R_TRIG;//实例化上升沿触发功能块
END_VAR
VAR_OUTPUT
	ReadBuffer	:	ARRAY[0..255] OF BYTE;//读数缓冲区
	nNumRead	:	UDINT;//读取文件的字节数
	bDone	:	BOOL;//读取成功
	bBusy	:	BOOL;//读取忙
	bErr	:	BOOL;//读取出错
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
		//尝试打开文件
fileHandle := SysFileOpen(szFile := fileName, am := AM_READ, pResult := nErrId);
		IF fileHandle = 0 THEN
			bErr := TRUE;
			bBusy := FALSE;
			nState := 0;
		ELSE
			nState := 2;
		END_IF
	2:
		//读取文件内容
		readResult := SysFileRead(hFile := fileHandle, pbyBuffer := ADR(ReadBuffer), ulSize := SIZEOF(ReadBuffer), pResult := nErrId);
		IF nErrId <> 0 THEN
			bErr := TRUE;
			nState := 3;
		ELSE
			nNumRead := readResult;
			nState := 3;
		END_IF
	3:
		//关闭文件
		SysFileClose(hFile := fileHandle);
		bDone := NOT bErr;
		bBusy := FALSE;
		nState := 0;
END_CASE
END_FUNCTION_BLOCK