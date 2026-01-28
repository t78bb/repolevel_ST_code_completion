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
nState := 4;//文件打开失败 (error handling)
    bErr := TRUE;
    nErrId := 1;//错误代码1：文件打开失败

	2:
nState := 4;//写入失败 (error handling)
    bErr := TRUE;
    nErrId := 2;//错误代码2：写入失败

	3:
bDone := TRUE;
    bBusy := FALSE;
    nState := 0;//重置状态

	4:
bBusy := FALSE;
    nState := 0;//重置状态

END_CASE;
END_FUNCTION_BLOCK