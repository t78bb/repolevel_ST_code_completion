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
		fileHandle := FILE.Open(FileName := fileName, Mode := 'WRITE');//打开文件
		IF fileHandle = 0 THEN
			nState := 4;//文件打开失败
			bErr := TRUE;
			nErrId := 1;//错误代码1：文件打开失败
		ELSE
			nState := 2;
		END_IF;

	2:
		nNumWrite := FILE.Write(File := fileHandle, pBuffer := ADR(writeBuffer), Size := writeNum);//写入数据
		IF nNumWrite = writeNum THEN
			nState := 3;//写入成功
		ELSE
			nState := 4;//写入失败
			bErr := TRUE;
			nErrId := 2;//错误代码2：写入失败
		END_IF;

	3:
		FILE.Close(File := fileHandle);//关闭文件
		bDone := TRUE;
		bBusy := FALSE;
		nState := 0;//重置状态

	4:
		FILE.Close(File := fileHandle);//关闭文件
		bBusy := FALSE;
		nState := 0;//重置状态

END_CASE;
END_FUNCTION_BLOCK
