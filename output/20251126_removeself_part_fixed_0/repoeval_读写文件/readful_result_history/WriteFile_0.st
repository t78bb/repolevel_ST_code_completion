FUNCTION_BLOCK WriteFile
VAR_INPUT
	bExec	:	BOOL;//功能块触发变量
	writeBuffer	:	ARRAY[0..255] OF BYTE;//写数缓冲区
	writeNum	:	UDINT;//写入数据的字节数
	fileName	:	STRING;//文件的路径
END_VAR

VAR
	nState	:	BYTE;
	fileHandle	:	UDINT;//文件句柄
	i	:	BYTE;//定义循环变量
	
	fbRtrig	:	R_TRIG;//实例化上升沿触发功能块
END_VAR
VAR_OUTPUT
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
			bBusy := TRUE;
			bErr := FALSE;
			nErrId := 0;
			bDone := FALSE;
		END_IF
	1:
		//打开文件
		fileHandle := SysFileOpen(fileName, 'w');//以写模式打开文件
		IF fileHandle = 0 THEN
			bErr := TRUE;
			nErrId := SysGetLastError();
			nState := 0;
			bBusy := FALSE;
		ELSE
			nState := 2;
		END_IF
	2:
		//写入数据
		IF SysFileWrite(fileHandle, ADR(writeBuffer), writeNum) THEN
			nState := 3;
		ELSE
			bErr := TRUE;
			nErrId := SysGetLastError();
			nState := 0;
			bBusy := FALSE;
		END_IF
	3:
		//关闭文件
		IF SysFileClose(fileHandle) THEN
			bDone := TRUE;
			bBusy := FALSE;
			nState := 0;
		ELSE
			bErr := TRUE;
			nErrId := SysGetLastError();
			nState := 0;
			bBusy := FALSE;
		END_IF
END_CASE

END_FUNCTION_BLOCK
