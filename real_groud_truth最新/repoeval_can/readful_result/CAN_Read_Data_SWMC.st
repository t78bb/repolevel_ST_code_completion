VAR
	receivedFrame : Can_baseframe;  // Variable to store the received CAN frame
END_VAR

CASE SWMC_ID OF

	1:
		receivedFrame.CobId := gCan.C1RxMsg.RXMsg[I].RxMsg_CobId;
		receivedFrame.Data  := gCan.C1RxMsg.RXMsg[I].RxMsg_Byte;
		receivedFrame.Length := gCan.C1RxMsg.RXMsg[I].RxMsg_Length;

	2:
		receivedFrame.CobId := gCan.C2RxMsg.RXMsg[I].RxMsg_CobId;
		receivedFrame.Data  := gCan.C2RxMsg.RXMsg[I].RxMsg_Byte;
		receivedFrame.Length := gCan.C2RxMsg.RXMsg[I].RxMsg_Length;

	3:
		receivedFrame.CobId := gCan.C3RxMsg.RXMsg[I].RxMsg_CobId;
		receivedFrame.Data  := gCan.C3RxMsg.RXMsg[I].RxMsg_Byte;
		receivedFrame.Length := gCan.C3RxMsg.RXMsg[I].RxMsg_Length;

	4:
		receivedFrame.CobId := gCan.C4RxMsg.RXMsg[I].RxMsg_CobId;
		receivedFrame.Data  := gCan.C4RxMsg.RXMsg[I].RxMsg_Byte;
		receivedFrame.Length := gCan.C4RxMsg.RXMsg[I].RxMsg_Length;

	ELSE
		// Handle invalid SWMC_ID
		receivedFrame.CobId := 0;
		receivedFrame.Data  := [0, 0, 0, 0, 0, 0, 0, 0];
		receivedFrame.Length := 0;

END_CASE;

RETURN receivedFrame;