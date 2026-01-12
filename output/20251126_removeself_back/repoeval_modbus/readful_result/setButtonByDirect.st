VAR
    result      : BOOL; // Function result
    logicIdx    : INT;  // Logical index for Modbus mapping
BEGIN
    result := FALSE; // Default result

    CASE direct OF
        TargetDirect.extend:
            CASE level OF
                1: // 地轨
                    p2l(section := 1, phyIdx := idx, lgcIdx => logicIdx); // Map physical index to logical index
                    IF gDev.grd[idx].state = DevStatus.retracted THEN
                        gModbus.srv.response.data[logicIdx] := 1; // Update Modbus data
                        result := TRUE; // Operation successful
                    ELSE
                        gModbus.srv.response.data[logicIdx] := 0;
                    END_IF;
                2: // 天轨
                    p2l(section := 3, phyIdx := idx, lgcIdx => logicIdx); // Map physical index to logical index
                    IF gDev.sky[idx].state = DevStatus.retracted THEN
                        gModbus.srv.response.data[logicIdx] := 1; // Update Modbus data
                        result := TRUE; // Operation successful
                    ELSE
                        gModbus.srv.response.data[logicIdx] := 0;
                    END_IF;
            END_CASE;

        TargetDirect.retract:
            CASE level OF
                1: // 地轨
                    p2l(section := 2, phyIdx := idx, lgcIdx => logicIdx); // Map physical index to logical index
                    IF gDev.grd[idx].state = DevStatus.extended THEN
                        gModbus.srv.response.data[logicIdx] := 1; // Update Modbus data
                        result := TRUE; // Operation successful
                    ELSE
                        gModbus.srv.response.data[logicIdx] := 0;
                    END_IF;
                2: // 天轨
                    p2l(section := 4, phyIdx := idx, lgcIdx => logicIdx); // Map physical index to logical index
                    IF gDev.sky[idx].state = DevStatus.extended THEN
                        gModbus.srv.response.data[logicIdx] := 1; // Update Modbus data
                        result := TRUE; // Operation successful
                    ELSE
                        gModbus.srv.response.data[logicIdx] := 0;
                    END_IF;
            END_CASE;
    END_CASE;

    setButtonByDirect := result; // Return the result
END_FUNCTION