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
		fileHandle := SysFileOpen(fileName, ADR(nErrId), 16#1); // '16#1' represents READ_ONLY mode or equivalent in hex.
		IF fileHandle = 0 THEN
			bErr := TRUE;
			nErrId := 1; // 文件打开失败错误代码
			nState := 0;
			bBusy := FALSE;
		ELSE
			nState := 2;
		END_IF;
	2:
		// 读取文件内容
		nNumRead := SysFileRead(fileHandle, ADR(readBuffer), SIZEOF(readBuffer), ADR(nErrId)); // Replaced named inputs with positional ones.
		IF nNumRead = 0 THEN
			bErr := TRUE;
			nErrId := 2; // 文件读取失败错误代码
			nState := 0;
			bBusy := FALSE;
		ELSE
			nState := 3;
		END_IF;
	3:
		// 关闭文件
		SysFileClose(fileHandle); // Removed incorrect named input.
		bDone := TRUE;
		bBusy := FALSE;
		nState := 0;
END_CASE;

END_FUNCTION_BLOCK
