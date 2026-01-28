VAR
	nState	:	BYTE;
	fileHandle	:	UDINT;//文件句柄
	readBuffer	:	ARRAY[0..255] OF BYTE;//读取数据缓冲区
	nNumRead	:	UDINT;//读取文件的字节数
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
		// 打开文件
		fileHandle := FileOpen(fileName := fileName, mode := 'READ');
		IF fileHandle = 0 THEN
			bErr := TRUE;
			nErrId := 1; // 文件打开失败
			nState := 0;
			bBusy := FALSE;
		ELSE
			nState := 2;
		END_IF;

	2:
		// 读取文件内容
		nNumRead := FileRead(fileHandle := fileHandle, buffer := readBuffer, size := SIZEOF(readBuffer));
		IF nNumRead = 0 THEN
			bErr := TRUE;
			nErrId := 2; // 文件读取失败
			nState := 0;
			bBusy := FALSE;
		ELSE
			readData := readBuffer; // 将读取的数据存储到输出变量
			nState := 3;
		END_IF;

	3:
		// 关闭文件
		IF FileClose(fileHandle := fileHandle) THEN
			bDone := TRUE;
			bBusy := FALSE;
			nState := 0;
		ELSE
			bErr := TRUE;
			nErrId := 3; // 文件关闭失败
			nState := 0;
			bBusy := FALSE;
		END_IF;

ELSE
	nState := 0;
END_CASE;