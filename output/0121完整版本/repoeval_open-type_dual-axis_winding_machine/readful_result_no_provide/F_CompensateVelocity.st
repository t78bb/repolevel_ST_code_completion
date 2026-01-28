VAR
    lDeltaPos : LREAL; // Position change
END_VAR

// Calculate position change
lDeltaPos := lNewPos - lOldPos;

// Check if the axis is moving (position is changing)
IF lDeltaPos <> 0 THEN
    IF bUnwinding THEN
        // Unwinding: radius decreases, velocity needs to increase
        // Formula: V_new = V_old + V_old * Tk / (R - Tk)
        IF (lRadius - lTk) > 0.01 THEN // Avoid division by zero
            F_CompensateVelocity := lCurrentVel + lCurrentVel * lTk / (lRadius - lTk);
        ELSE
            F_CompensateVelocity := lCurrentVel;
        END_IF
    ELSE
        // Rewinding: radius increases, velocity needs to decrease
        // Formula: V_new = V_old - V_old * Tk / (R + Tk)
        IF (lRadius + lTk) > 0.01 THEN // Avoid division by zero
            F_CompensateVelocity := lCurrentVel - lCurrentVel * lTk / (lRadius + lTk);
        ELSE
            F_CompensateVelocity := lCurrentVel;
        END_IF
    END_IF
ELSE
    // Position unchanged, maintain current velocity
    F_CompensateVelocity := lCurrentVel;
END_IF;

RETURN;
END_FUNCTION
