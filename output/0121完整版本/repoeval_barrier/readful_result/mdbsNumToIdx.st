FUNCTION_BLOCK mdbsNumToIdx
VAR_INPUT
	devNo		:WORD;
END_VAR
VAR_OUTPUT
	level		:INT;
	idx			:INT;
END_VAR
VAR
END_VAR

IF devNo > 40000 THEN
	CASE devNo OF
		//地轨
		41010:	level := 1;	idx := 1;
		41020:	level := 1;	idx := 3;
		41030:	level := 1;	idx := 4;
		41040:	level := 1;	idx := 5;
		41050:	level := 1;	idx := 6;
		41060:	level := 1;	idx := 8;
		41070:	level := 1;	idx := 9;
		41080:	level := 1;	idx := 10;
		42010:	level := 1;	idx := 2;
		42020:	level := 1;	idx := 7;
		
		51010:	level := 2;	idx := 1;
		51020:	level := 2;	idx := 3;
		51030:	level := 2;	idx := 4;
		51040:	level := 2;	idx := 5;
		51050:	level := 2;	idx := 6;
		51060:	level := 2;	idx := 8;
		51070:	level := 2;	idx := 9;
		51080:	level := 2;	idx := 10;
		52010:	level := 2;	idx := 2;
		52020:	level := 2;	idx := 7;
		52030:	level := 2;	idx := 11;
		52040:	level := 2;	idx := 12;
		52050:	level := 2;	idx := 13;
		52060:	level := 2;	idx := 14;
		52070:	level := 2;	idx := 15;
		52080:	level := 2;	idx := 16;
		53010:	level := 3;	idx := 1;
		53020:	level := 3;	idx := 3;
		53030:	level := 3;	idx := 4;
		53040:	level := 3;	idx := 5;
		53050:	level := 3;	idx := 6;
		53060:	level := 3;	idx := 8;
		53070:	level := 3;	idx := 9;
		53080:	level := 3;	idx := 10;
		54010:	level := 3;	idx := 2;
		54020:	level := 3;	idx := 7;
		54030:	level := 3;	idx := 11;
		54040:	level := 3;	idx := 12;
		54050:	level := 3;	idx := 13;
		54060:	level := 3;	idx := 14;
		54070:	level := 3;	idx := 15;
		54080:	level := 3;	idx := 16;
	ELSE
		level := -1;	idx := -1;
	END_CASE;
ELSE
	level := -1;	idx := -1;
END_IF;
END_FUNCTION_BLOCK
