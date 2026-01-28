VAR
	result : BOOL := FALSE;
END_VAR

CASE SWMC_ID OF
	1:
		gCan.C1TxMsg.TXMsg[1].TxMsg_CobId := 8 + 32 * id;
		gCan.C1TxMsg.TXMsg[1].TxMsg_Byte := data;
		gCan.C1TxMsg.NoOfTxMessages := 1;
		gCan.C1TxMsg.TxCounter := gCan.C1TxMsg.TxCounter + 1;
		result := TRUE;
	2:
		gCan.C2TxMsg.TXMsg[1].TxMsg_CobId := 8 + 32 * id;
		gCan.C2TxMsg.TXMsg[1].TxMsg_Byte := data;
		gCan.C2TxMsg.NoOfTxMessages := 1;
		gCan.C2TxMsg.TxCounter := gCan.C2TxMsg.TxCounter + 1;
		result := TRUE;
	3:
		gCan.C3TxMsg.TXMsg[1].TxMsg_CobId := 8 + 32 * id;
		gCan.C3TxMsg.TXMsg[1].TxMsg_Byte := data;
		gCan.C3TxMsg.NoOfTxMessages := 1;
		gCan.C3TxMsg.TxCounter := gCan.C3TxMsg.TxCounter + 1;
		result := TRUE;
	4:
		gCan.C4TxMsg.TXMsg[1].TxMsg_CobId := 8 + 32 * id;
		gCan.C4TxMsg.TXMsg[1].TxMsg_Byte := data;
		gCan.C4TxMsg.NoOfTxMessages := 1;
		gCan.C4TxMsg.TxCounter := gCan.C4TxMsg.TxCounter + 1;
		result := TRUE;
ELSE
result := FALSE; // Ensure the statement ends with a semicolon.
END_CASE

RETURN result;
END_FUNCTION