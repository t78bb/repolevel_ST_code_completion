VAR
    receivedFrame : Can_baseframe;
BEGIN
    CASE SWMC_ID OF
        1:
            receivedFrame := gCan.C1RxMsg.RXMsg[I];
        2:
            receivedFrame := gCan.C2RxMsg.RXMsg[I];
        3:
            receivedFrame := gCan.C3RxMsg.RXMsg[I];
        4:
            receivedFrame := gCan.C4RxMsg.RXMsg[I];
        ELSE
            receivedFrame := (CobId := 0, Data := [0,0,0,0,0,0,0,0], DLC := 0);
    END_CASE;

    RETURN receivedFrame;
END_FUNCTION