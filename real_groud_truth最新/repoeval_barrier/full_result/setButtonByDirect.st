FUNCTION setButtonByDirect : BOOL
VAR_INPUT
	level		:INT;	//1->地轨	2->天轨
	idx			:INT;	//挡板索引编号
	direct		:TargetDirect;
END_VAR

VAR
    success : BOOL;
END_VAR

CASE direct OF
    TargetDirect.extend:
        CASE level OF
            1: // 地轨
                gController.grd[idx].extendPercent := 65535; // 100% 伸出
                gController.grd[idx].retractPercent := 0;    // 缩回设为 0%
                success := TRUE;
            2: // 天轨
                gController.sky[idx].extendPercent := 65535; // 100% 伸出
                gController.sky[idx].retractPercent := 0;    // 缩回设为 0%
                success := TRUE;
            ELSE
                success := FALSE; // 无效的 level
        END_CASE
    TargetDirect.retract:
        CASE level OF
            1: // 地轨
                gController.grd[idx].extendPercent := 0;    // 伸出设为 0%
                gController.grd[idx].retractPercent := 65535; // 100% 缩回
                success := TRUE;
            2: // 天轨
                gController.sky[idx].extendPercent := 0;    // 伸出设为 0%
                gController.sky[idx].retractPercent := 65535; // 100% 缩回
                success := TRUE;
            ELSE
                success := FALSE; // 无效的 level
        END_CASE
    ELSE
        success := FALSE; // 无效的 direct
END_CASE

setButtonByDirect := success;
END_FUNCTION