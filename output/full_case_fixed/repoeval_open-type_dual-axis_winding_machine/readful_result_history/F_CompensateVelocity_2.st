FUNCTION F_CompensateVelocity : LREAL
VAR_INPUT
 lCurrentVel		:	LREAL;		//当前速度
 lOldPos			:	LREAL;		//上一次位置
 lNewPos			:	LREAL;		//当前位置
 lRadius			:	LREAL;		//当前半径
 lTk				:	LREAL;		//材料厚度
 bUnwinding		:	BOOL;		//TRUE=放卷（半径减小），FALSE=收卷（半径增加）
END_VAR
VAR
 lDeltaPos : LREAL; // Position change
END_VAR

// Calculate position change
lDeltaPos := lNewPos - lOldPos;

// Check if the axis is moving (position change)
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