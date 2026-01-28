VAR
END_VAR

(**
 * 将设备编号解析为对应的层级和索引
 * (level:1->地轨	2->天轨)(idx:内存物理地址对应数组索引)
 *)
CASE devNo OF
	1..10: // 地轨设备编号范围
		level := 1; // 地轨
		idx := devNo; // 索引直接对应设备编号
	11..20: // 天轨设备编号范围
		level := 2; // 天轨
		idx := devNo - 10; // 索引为设备编号减去偏移量
ELSE
	// 默认值处理
	level := 0; // 未定义层级
	idx := -1; // 无效索引
END_CASE;