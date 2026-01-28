FUNCTION CAN_Send_Data_SWMC : BOOL
VAR_INPUT
	SWMC_ID : UINT;
	id 		: UINT;
	data	: ARRAY[1..8] OF BYTE;
END_VAR

VAR
    result : BOOL;
END_VAR

result := FALSE;

// Simulate sending data to the CAN bus
IF (SWMC_ID > 0) AND (id > 0) THEN
    // Here you would typically call a hardware-specific function to send the data
    // For example: CAN_Write(SWMC_ID, id, data);
    result := TRUE; // Assume the data was sent successfully
END_IF;

RETURN result;
END_FUNCTION

// Additional code to handle the CAN communication logic
FUNCTION_BLOCK CAN_Controller
VAR
    sendCounter : UINT;
END_VAR

METHOD Initialize : BOOL
VAR
    success : BOOL;
END_VAR

success := FALSE;

// Initialize the CAN controller
// For example: CAN_Init();

sendCounter := 0;
success := TRUE;

RETURN success;
END_METHOD

METHOD SendData : BOOL
VAR
    success : BOOL;
    sendData : ARRAY[1..8] OF BYTE;
    swmcIdSwitch : UINT;
END_VAR

success := FALSE;

// Example logic for sending data
swmcIdSwitch := sendCounter MOD 2;

CASE swmcIdSwitch OF
    0:
        sendData[1] := WORD_TO_BYTE(gController.sky[3].extendPercent);
        sendData[2] := WORD_TO_BYTE(SHR(gController.sky[3].extendPercent, 8));
        sendData[3] := WORD_TO_BYTE(gController.sky[3].retractPercent);
        sendData[4] := WORD_TO_BYTE(SHR(gController.sky[3].retractPercent, 8));
        sendData[5] := WORD_TO_BYTE(gController.sky[4].extendPercent);
        sendData[6] := WORD_TO_BYTE(SHR(gController.sky[4].extendPercent, 8));
        sendData[7] := WORD_TO_BYTE(gController.sky[4].retractPercent);
        sendData[8] := WORD_TO_BYTE(SHR(gController.sky[4].retractPercent, 8));
        success := CAN_Send_Data_SWMC(1, 16#500, sendData);
    1:
        sendData[1] := WORD_TO_BYTE(gController.sky[5].extendPercent);
        sendData[2] := WORD_TO_BYTE(SHR(gController.sky[5].extendPercent, 8));
        sendData[3] := WORD_TO_BYTE(gController.sky[5].retractPercent);
        sendData[4] := WORD_TO_BYTE(SHR(gController.sky[5].retractPercent, 8));
        sendData[5] := WORD_TO_BYTE(gController.sky[6].extendPercent);
        sendData[6] := WORD_TO_BYTE(SHR(gController.sky[6].extendPercent, 8));
        sendData[7] := WORD_TO_BYTE(gController.sky[6].retractPercent);
        sendData[8] := WORD_TO_BYTE(SHR(gController.sky[6].retractPercent, 8));
        success := CAN_Send_Data_SWMC(1, 16#501, sendData);
END_CASE;

sendCounter := sendCounter + 1;

RETURN success;
END_METHOD
END_FUNCTION