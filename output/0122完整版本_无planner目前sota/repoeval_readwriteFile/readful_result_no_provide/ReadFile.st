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
fileHandle := SysFileOpen(szFile := fileName, am := AM_READ, pResult := ADR(nErrId));
		IF fileHandle = 0 THEN
			nState := 0;
			bErr := TRUE;
// The nErrId value is already updated via pResult in the previous SysFile function calls
    // No need to call SysFileGetLastError; leave the error value already handled through ADR(nErrId)
			bBusy := FALSE;
		ELSE
			nState := 2;
		END_IF
	2:
		//读取文件内容
nNumRead := SysFileRead(hFile := fileHandle, pbyBuffer := ADR(ReadBuffer), ulSize := SIZEOF(ReadBuffer), pResult := ADR(nErrId));
		IF nNumRead = 0 THEN
			nState := 3;
		ELSIF nNumRead < 0 THEN
			nState := 0;
			bErr := TRUE;
// Removed as nErrId is updated via pResult in previous function calls
			bBusy := FALSE;
		END_IF
	3:
		//关闭文件
		SysFileClose(hFile := fileHandle);
		nState := 0;
		bDone := TRUE;
		bBusy := FALSE;
END_CASE
END_FUNCTION_BLOCK