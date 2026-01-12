FUNCTION CAN_Read_Data_SWMC : BYTE
VAR_INPUT
SWMC_ID	 :UINT;		//接收SWMC控制ID
I	 	 :UINT;      //接收缓冲区域
END_VAR

VAR
CanFrame : BYTE; //定义通用数据字节类型
END_VAR

CASE SWMC_ID OF
1:
 CanFrame := gCan.C1RxMsg.RXMsg[I]; //从C1接收缓冲区读取数据
2:
 CanFrame := gCan.C2RxMsg.RXMsg[I]; //从C2接收缓冲区读取数据
3:
 CanFrame := gCan.C3RxMsg.RXMsg[I]; //从C3接收缓冲区读取数据
4:
 CanFrame := gCan.C4RxMsg.RXMsg[I]; //从C4接收缓冲区读取数据
ELSE
 CanFrame := 0; //返回默认空值
END_CASE;

RETURN CanFrame;

END_FUNCTION