FUNCTION setButtonByDirect : BOOL
VAR_INPUT
	level		:INT;	//1->地轨	2->天轨
	idx			:INT;	//挡板索引编号
	direct		:TargetDirect;
END_VAR
VAR
END_VAR
CASE level OF
    1: // 地轨
        IF idx = 0 OR idx > 10 THEN
            RETURN FALSE; // 参数校验失败
        END_IF
        CASE direct OF
            TargetDirect.extend:
                gUI.grd[idx].btnStop := FALSE;
                gUI.grd[idx].btnExtend := TRUE;
                gUI.grd[idx].btnRetract := FALSE;
            TargetDirect.retract:
                gUI.grd[idx].btnStop := FALSE;
                gUI.grd[idx].btnExtend := FALSE;
                gUI.grd[idx].btnRetract := TRUE;
            TargetDirect.stop:
                gUI.grd[idx].btnStop := TRUE;
                gUI.grd[idx].btnExtend := FALSE;
                gUI.grd[idx].btnRetract := FALSE;
        END_CASE
        gUI.grd[idx].btnLast := direct; // 更新最后操作方向
    2: // 天轨
        IF idx = 0 OR idx > 10 THEN
            RETURN FALSE; // 参数校验失败
        END_IF
        CASE direct OF
            TargetDirect.extend:
                gUI.sky[idx].btnStop := FALSE;
                gUI.sky[idx].btnExtend := TRUE;
                gUI.sky[idx].btnRetract := FALSE;
            TargetDirect.retract:
                gUI.sky[idx].btnStop := FALSE;
                gUI.sky[idx].btnExtend := FALSE;
                gUI.sky[idx].btnRetract := TRUE;
            TargetDirect.stop:
                gUI.sky[idx].btnStop := TRUE;
                gUI.sky[idx].btnExtend := FALSE;
                gUI.sky[idx].btnRetract := FALSE;
        END_CASE
        gUI.sky[idx].btnLast := direct; // 更新最后操作方向
    ELSE
        RETURN FALSE; // 无效的 level 参数
END_CASE
RETURN TRUE; // 成功更新状态
END_FUNCTION
