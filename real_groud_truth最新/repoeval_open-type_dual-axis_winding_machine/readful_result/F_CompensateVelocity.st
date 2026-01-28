// Velocity compensation formula:
// V_compensated = V_current * (R_old / R_new)

VAR
    lOldRadius : LREAL; // Previous radius
    lNewRadius : LREAL; // Current radius
END_VAR

// Calculate the old and new radii based on the positions and material thickness
lOldRadius := ABS(SQRT(EXPT(lRadius, 2) + EXPT(lOldPos, 2)) - SQRT(EXPT(lRadius, 2) + EXPT(lOldPos - lTk, 2))) / SMC_PI + lTk;
lNewRadius := ABS(SQRT(EXPT(lRadius, 2) + EXPT(lNewPos, 2)) - SQRT(EXPT(lRadius, 2) + EXPT(lNewPos - lTk, 2))) / SMC_PI + lTk;

// Adjust velocity based on unwinding or winding direction
IF bUnwinding THEN
    F_CompensateVelocity := lCurrentVel * (lOldRadius / lNewRadius);
ELSE
    F_CompensateVelocity := lCurrentVel * (lNewRadius / lOldRadius);
END_IF;