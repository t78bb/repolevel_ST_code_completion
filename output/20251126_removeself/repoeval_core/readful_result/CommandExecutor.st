VAR
	direct		:TargetDirect;	//方向
END_VAR

CASE direct OF
	TargetDirect.extend:
		CASE level OF
			1:
				gController.grd[idx].extendPercent := REAL_TO_WORD(percent * 65535 / 100);
				gController.grd[idx].retractPercent := 0;
			2:
				gController.sky[idx].extendPercent := REAL_TO_WORD(percent * 65535 / 100);
				gController.sky[idx].retractPercent := 0;
		END_CASE
	TargetDirect.retract:
		CASE level OF
			1:
				gController.grd[idx].extendPercent := 0;
				gController.grd[idx].retractPercent := REAL_TO_WORD(percent * 65535 / 100);
			2:
				gController.sky[idx].extendPercent := 0;
				gController.sky[idx].retractPercent := REAL_TO_WORD(percent * 65535 / 100);
		END_CASE
	TargetDirect.stop:
		CASE level OF
			1:
				gController.grd[idx].extendPercent := 0;
				gController.grd[idx].retractPercent := 0;
			2:
				gController.sky[idx].extendPercent := 0;
				gController.sky[idx].retractPercent := 0;
		END_CASE
END_CASE
```

This code defines a function block `CommandExecutor` that controls the extension and retraction of a mechanism based on the input parameters `level`, `idx`, and `percent`. The `direct` variable determines the direction of the movement, which can be `extend`, `retract`, or `stop`. Depending on the `level` (1 for ground track, 2 for sky track), the appropriate controller (`gController.grd` or `gController.sky`) is updated with the calculated percentage values.