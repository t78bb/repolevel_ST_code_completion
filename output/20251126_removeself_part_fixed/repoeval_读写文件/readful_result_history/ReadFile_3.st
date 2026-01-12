{attribute 'qualified_only'}
FUNCTION_BLOCK ReadFile
VAR_INPUT
  bExec	:	BOOL;//功能块触发变量
  fileName	:	STRING;//文件的路径
END_VAR

VAR
  nState	:	BYTE;
  fileHandle	:	UDINT;//文件句柄
  readBuffer	:	ARRAY[0..255] OF BYTE;//读取数据缓冲区
  nNumRead	:	UDINT;//读取文件的字节数
  i	:	BYTE;//定义循环变量
  fbRtrig	:	R_TRIG;//实例化上升沿触发功能块
END_VAR

VAR_EXTERNAL
  SysFileOpen : FUNCTION
    VAR_INPUT
      szFile : STRING; // File name with relative or absolute path
      am : ACCESS_MODE; // Requested access mode
      pResult : POINTER TO RTS_IEC_RESULT; // Runtime system error code
    END_VAR
    VAR_OUTPUT
      SysFileOpen : RTS_IEC_HANDLE; // File handle or invalid handle
    END_VAR
  END_FUNCTION;

  SysFileRead : FUNCTION
    VAR_INPUT
      hFile : RTS_IEC_HANDLE; // File handle
      pbyBuffer : POINTER TO BYTE; // Pointer to buffer where data will be written
      ulSize : __XWORD; // Number of bytes to read
      pResult : POINTER TO RTS_IEC_RESULT; // Runtime system error code
    END_VAR
    VAR_OUTPUT
      SysFileRead : __XWORD; // Number of bytes read or 0 if failed
    END_VAR
  END_FUNCTION;

  SysFileClose : FUNCTION
    VAR_INPUT
      hFile : RTS_IEC_HANDLE; // File handle to close
    END_VAR
    VAR_OUTPUT
      SysFileClose : RTS_IEC_RESULT; // Result of the close operation
    END_VAR
  END_FUNCTION;
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
    END_IF; // Properly close the IF statement

	1:
		// 打开文件
fileHandle := SysFileOpen(fileName := fileName, mode := 'r');
		IF fileHandle = 0 THEN
			bErr := TRUE;
			nErrId := 1; // 文件打开失败
			nState := 0;
		ELSE
			nState := 2;
		END_IF

	2:
		// 读取文件内容
nNumRead := SysFileRead(hFile := fileHandle, pBuffer := ADR(readBuffer), size := SIZEOF(readBuffer));
		IF nNumRead = 0 THEN
			bErr := TRUE;
			nErrId := 2; // 文件读取失败
			nState := 3;
		ELSE
			nState := 3;
		END_IF

	3:
		// 关闭文件
SysFileClose(hFile := fileHandle);
bDone := TRUE;
    bBusy := FALSE;
    nState := 0;
END_CASE; // Correctly aligned to close the CASE structure

END_FUNCTION_BLOCK