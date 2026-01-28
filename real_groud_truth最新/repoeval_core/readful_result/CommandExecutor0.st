VAR
END_VAR

CASE direct OF
	TargetDirect.Extend:
		CASE level OF
			1:
				gController.grd[idx].extendPercent := REAL_TO_WORD(percent * 65535 / 100);
				gController.grd[idx].retractPercent := 0;
			2:
				gController.sky[idx].extendPercent := REAL_TO_WORD(percent * 65535 / 100);
				gController.sky[idx].retractPercent := 0;
		END_CASE;
	TargetDirect.Retract:
		CASE level OF
			1:
				gController.grd[idx].extendPercent := 0;
				gController.grd[idx].retractPercent := REAL_TO_WORD(percent * 65535 / 100);
			2:
				gController.sky[idx].extendPercent := 0;
				gController.sky[idx].retractPercent := REAL_TO_WORD(percent * 65535 / 100);
		END_CASE;
END_CASE;