VAR
	nState	:	BYTE;
	fileHandle	:	UDINT;//文件句柄
	nNumWrite	:	UDINT;//写入文件的字节数
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
		END_IF;
	1:
		// 打开文件
		fileHandle := SysFileOpen(fileName, 'w');
		IF fileHandle = 0 THEN
			bErr := TRUE;
			nErrId := SysFileGetLastError();
			nState := 0;
			bBusy := FALSE;
		ELSE
			nState := 2;
		END_IF;
	2:
		// 写入数据
		nNumWrite := SysFileWrite(fileHandle, ADR(writeBuffer), writeNum);
		IF nNumWrite <> writeNum THEN
			bErr := TRUE;
			nErrId := SysFileGetLastError();
		END_IF;
		SysFileClose(fileHandle);
		bDone := NOT bErr;
		bBusy := FALSE;
		nState := 0;
END_CASE;