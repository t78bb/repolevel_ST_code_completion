VAR
	nState	:	BYTE;
	fileHandle	:	UDINT;//文件句柄
	readBuffer	:	ARRAY[0..255] OF BYTE;//读取数据缓冲区
	readNum	:	UDINT;//读取数据的字节数
	nNumRead	:	UDINT;//实际读取的字节数
	fbRtrig	:	R_TRIG;//实例化上升沿触发功能块
END_VAR
VAR_OUTPUT
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
			bBusy := TRUE;
			bErr := FALSE;
			nErrId := 0;
			bDone := FALSE;
		END_IF;

	1:
		fileHandle := FILE.Open(fileName := fileName, mode := FILE.MODE_READ);//打开文件
		IF fileHandle = 0 THEN
			bErr := TRUE;
			nErrId := FILE.GetLastError();
			nState := 0;
			bBusy := FALSE;
		ELSE
			nState := 2;
		END_IF;

	2:
		nNumRead := FILE.Read(fileHandle := fileHandle, pBuffer := ADR(readBuffer), size := SIZEOF(readBuffer));//读取文件
		IF nNumRead = 0 THEN
			bErr := TRUE;
			nErrId := FILE.GetLastError();
			nState := 4;
		ELSE
			readNum := nNumRead;
			nState := 3;
		END_IF;

	3:
		IF FILE.Close(fileHandle := fileHandle) THEN
			bDone := TRUE;
			bBusy := FALSE;
			nState := 0;
		ELSE
			bErr := TRUE;
			nErrId := FILE.GetLastError();
			nState := 4;
		END_IF;

	4:
		bBusy := FALSE;
		nState := 0;

END_CASE;