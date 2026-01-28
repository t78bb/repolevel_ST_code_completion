VAR
END_VAR

(**
 * 将设备编号解析为对应的索引和层级
 * (level:1->地轨	2->天轨)(idx:设备对应的索引)
 *)
CASE devNo OF
	1..10: //设备编号1到10对应地轨
		level := 1;
		CASE devNo OF
			1: idx := 1;
			2: idx := 2;
			3: idx := 3;
			4: idx := 4;
			5: idx := 5;
			6: idx := 6;
			7: idx := 7;
			8: idx := 8;
			9: idx := 9;
			10: idx := 10;
		END_CASE;
	11..20: //设备编号11到20对应天轨
		level := 2;
		CASE devNo OF
			11: idx := 1;
			12: idx := 2;
			13: idx := 3;
			14: idx := 4;
			15: idx := 5;
			16: idx := 6;
			17: idx := 7;
			18: idx := 8;
			19: idx := 9;
			20: idx := 10;
		END_CASE;
	ELSE
		level := 0; //无效设备编号
		idx := -1;  //无效索引
END_CASE;