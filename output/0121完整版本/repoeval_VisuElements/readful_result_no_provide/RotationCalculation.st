VAR
    rRadians : REAL;
    rCos : REAL;
    rSin : REAL;
    rTranslatedX : REAL;
    rTranslatedY : REAL;
END_VAR

rRadians := rAngle * 3.14159265359 / 180.0; // Replace undefined PI with its numeric approximation
rCos := COS(rRadians);          (* Calculate cosine of the angle *)
rSin := SIN(rRadians);          (* Calculate sine of the angle *)

(* Translate point to origin relative to the rotation center *)
rTranslatedX := rPointX - rCenterX;
rTranslatedY := rPointY - rCenterY;

(* Perform rotation *)
rRotatedX := rTranslatedX * rCos - rTranslatedY * rSin + rCenterX;
rRotatedY := rTranslatedX * rSin + rTranslatedY * rCos + rCenterY;

RotationCalculation := TRUE; // Assign result to function name before returning
RETURN; // Exit the function
END_FUNCTION