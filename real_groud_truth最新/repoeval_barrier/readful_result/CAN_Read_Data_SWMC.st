VAR
	receivedFrame : Can_baseframe; // Variable to store the received CAN frame
END_VAR

CASE SWMC_ID OF
	1:
		receivedFrame := gCan.C1RxMsg.RXMsg[I]; // Retrieve data from CAN channel 1
		gCan.C1RxMsg.RxCounter := gCan.C1RxMsg.RxCounter + 1; // Increment the receive counter
	2:
		receivedFrame := gCan.C2RxMsg.RXMsg[I]; // Retrieve data from CAN channel 2
		gCan.C2RxMsg.RxCounter := gCan.C2RxMsg.RxCounter + 1; // Increment the receive counter
	3:
		receivedFrame := gCan.C3RxMsg.RXMsg[I]; // Retrieve data from CAN channel 3
		gCan.C3RxMsg.RxCounter := gCan.C3RxMsg.RxCounter + 1; // Increment the receive counter
	4:
		receivedFrame := gCan.C4RxMsg.RXMsg[I]; // Retrieve data from CAN channel 4
		gCan.C4RxMsg.RxCounter := gCan.C4RxMsg.RxCounter + 1; // Increment the receive counter
	ELSE
		receivedFrame := Can_baseframe(); // Return an empty frame if SWMC_ID is invalid
END_CASE;

RETURN receivedFrame; // Return the received CAN frame