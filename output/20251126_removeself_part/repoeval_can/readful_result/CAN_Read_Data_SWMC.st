VAR
	CanFrame : Can_baseframe; //定义CAN帧结构
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
		CanFrame := Can_baseframe(); //返回空帧结构
END_CASE;

RETURN CanFrame;