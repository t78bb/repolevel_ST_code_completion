VAR
END_VAR

(**
 * 将设备编号转换为对应的索引和层级
 * (level:1->地轨 2->天轨)(idx:设备索引)
 *)
CASE devNo OF
    1..10: // 地轨设备编号范围
        level := 1; // 地轨
        idx := devNo; // 索引直接对应编号
    11..20: // 天轨设备编号范围
        level := 2; // 天轨
        idx := devNo - 10; // 索引为编号减去地轨范围
    ELSE
        level := 0; // 无效层级
        idx := -1; // 无效索引
END_CASE;