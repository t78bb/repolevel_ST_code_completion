It seems like you are working with a Modbus-related system and defining logic for mapping between physical and logical indices for different sections. Based on the provided code fragments, I will continue writing the `mdbsLogicToPhy` function block to complete the logic for mapping logical indices to physical indices.

```st
VAR
END_VAR

(**
 * 输入华中地址编号，返回本地索引编号
 *)
CASE section OF
    1: // 区域限定(1:skyExtend)
        CASE lgcIdx OF
            10: 
                phyIdx := 1;  // sky1e -> 横1
                level := 2;   // 天轨
                direct := TargetDirect.Horizontal;
            11: 
                phyIdx := 2;  // sky2e -> 横2
                level := 2;   // 天轨
                direct := TargetDirect.Horizontal;
            12: 
                phyIdx := 3;  // sky3e -> 横3
                level := 2;   // 天轨
                direct := TargetDirect.Horizontal;
            13: 
                phyIdx := 4;  // sky4e -> 横4
                level := 2;   // 天轨
                direct := TargetDirect.Horizontal;
            14: 
                phyIdx := 5;  // sky5e -> 横5
                level := 2;   // 天轨
                direct := TargetDirect.Horizontal;
            15: 
                phyIdx := 6;  // sky6e -> 横6
                level := 2;   // 天轨
                direct := TargetDirect.Horizontal;
            16: 
                phyIdx := 7;  // sky7e -> 横7
                level := 2;   // 天轨
                direct := TargetDirect.Horizontal;
            17: 
                phyIdx := 8;  // sky8e -> 横8
                level := 2;   // 天轨
                direct := TargetDirect.Horizontal;
            18: 
                phyIdx := 9;  // sky9e -> 横9
                level := 2;   // 天轨
                direct := TargetDirect.Horizontal;
            19: 
                phyIdx := 10; // sky10e -> 横10
                level := 2;   // 天轨
                direct := TargetDirect.Horizontal;
        END_CASE
    2: // 区域限定(2:skyRetract)
        CASE lgcIdx OF
            20: 
                phyIdx := 1;  // sky1r -> 纵1
                level := 2;   // 天轨
                direct := TargetDirect.Vertical;
            21: 
                phyIdx := 2;  // sky2r -> 纵2
                level := 2;   // 天轨
                direct := TargetDirect.Vertical;
            22: 
                phyIdx := 3;  // sky3r -> 纵3
                level := 2;   // 天轨
                direct := TargetDirect.Vertical;
            23: 
                phyIdx := 4;  // sky4r -> 纵4
                level := 2;   // 天轨
                direct := TargetDirect.Vertical;
            24: 
                phyIdx := 5;  // sky5r -> 纵5
                level := 2;   // 天轨
                direct := TargetDirect.Vertical;
            25: 
                phyIdx := 6;  // sky6r -> 纵6
                level := 2;   // 天轨
                direct := TargetDirect.Vertical;
            26: 
                phyIdx := 7;  // sky7r -> 纵7
                level := 2;   // 天轨
                direct := TargetDirect.Vertical;
            27: 
                phyIdx := 8;  // sky8r -> 纵8
                level := 2;   // 天轨
                direct := TargetDirect.Vertical;
            28: 
                phyIdx := 9;  // sky9r -> 纵9
                level := 2;   // 天轨
                direct := TargetDirect.Vertical;
            29: 
                phyIdx := 10; // sky10r -> 纵10
                level := 2;   // 天轨
                direct := TargetDirect.Vertical;
        END_CASE
    3: // 区域限定(3:groundExtend)
        CASE lgcIdx OF
            223: 
                phyIdx := 1;  // grd1e -> 横1
                level := 1;   // 地轨
                direct := TargetDirect.Horizontal;
            231: 
                phyIdx := 2;  // grd2e -> 纵1
                level := 1;   // 地轨