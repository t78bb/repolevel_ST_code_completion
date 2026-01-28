F_CalculateRadius := ABS(SQRT(EXPT(lD, 2) + EXPT(lHnew + lOffset, 2)) - SQRT(EXPT(lD, 2) + EXPT(lHold + lOffset, 2))) / SMC_PI + lTk;
RETURN;
END_FUNCTION
