FUNCTION_BLOCK ReadFile
VAR_INPUT
	bExec	:	BOOL;//功能块触发变量
	fileName	:	STRING;//文件的路径
END_VAR

VAR
	nState	:	BYTE;
	fileHandle	:	UDINT;//文件句柄
	readBuffer	:	ARRAY[0..255] OF BYTE;//读取数据缓冲区
	nNumRead	:	UDINT;//读取的字节数
	fbRtrig	:	R_TRIG;//实例化上升沿触发功能块
END_VAR
VAR_OUTPUT
	bDone	:	BOOL;//读取成功
	bBusy	:	BOOL;//读取忙
	bErr	:	BOOL;//读取出错
	nErrId	:	UDINT;//错误代码
	readData	:	ARRAY[0..255] OF BYTE;//读取的数据
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
		fileHandle := FILE.Open(FileName := fileName, Mode := 'READ');//打开文件
		IF fileHandle = 0 THEN
			nState := 4;
			bErr := TRUE;
			nErrId := FILE.GetLastError();
		ELSE
			nState := 2;
		END_IF;
	2:
		nNumRead := FILE.Read(FileHandle := fileHandle, pBuffer := ADR(readBuffer), Size := SIZEOF(readBuffer));//读取文件
		IF nNumRead > 0 THEN
			readData := readBuffer;
			nState := 3;
		ELSE
			nState := 4;
			bErr := TRUE;
			nErrId := FILE.GetLastError();
		END_IF;
	3:
		FILE.Close(FileHandle := fileHandle);//关闭文件
		bDone := TRUE;
		bBusy := FALSE;
		nState := 0;
	4:
		FILE.Close(FileHandle := fileHandle);//关闭文件
		bBusy := FALSE;
		nState := 0;
END_CASE;

END_FUNCTION_BLOCK
