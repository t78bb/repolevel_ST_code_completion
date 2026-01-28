VAR
	fbPower1		:	MC_Power;		//轴1电源控制
	fbPower2		:	MC_Power;		//轴2电源控制
	bAxis1Error		:	BOOL;			//轴1错误标志
	bAxis2Error		:	BOOL;			//轴2错误标志
END_VAR

fbPower1(
	Axis := Axis1,
	Enable := bEnable,
	bDriveStart := TRUE,
	bRegulatorOn := TRUE
);

fbPower2(
	Axis := Axis2,
	Enable := bEnable,
	bDriveStart := TRUE,
	bRegulatorOn := TRUE
);

bAxis1Ready := fbPower1.Status = MC_POWER_STATUS_READY;
bAxis2Ready := fbPower2.Status = MC_POWER_STATUS_READY;

bAxis1Error := fbPower1.Error;
bAxis2Error := fbPower2.Error;

bError := bAxis1Error OR bAxis2Error;

bBothReady := bAxis1Ready AND bAxis2Ready;
END_FUNCTION_BLOCK
