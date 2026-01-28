VAR
    rRadians : REAL;
    rCos : REAL;
    rSin : REAL;
    rTranslatedX : REAL;
    rTranslatedY : REAL;
END_VAR

rRadians := rAngle * 3.14159265358979 / 180.0; // Convert angle from degrees to radians
rCos := COS(rRadians);          (* Calculate cosine of the angle *)
rSin := SIN(rRadians);          (* Calculate sine of the angle *)

rTranslatedX := rPointX - rCenterX; (* Calculate relative X coordinate *)
rTranslatedY := rPointY - rCenterY; (* Calculate relative Y coordinate *)

rRotatedX := (rTranslatedX * rCos) - (rTranslatedY * rSin) + rCenterX; (* Calculate rotated X coordinate *)
rRotatedY := (rTranslatedX * rSin) + (rTranslatedY * rCos) + rCenterY; (* Calculate rotated Y coordinate *)

RotationCalculation := TRUE; // Assign return value
RETURN; // End function execution
END_FUNCTION