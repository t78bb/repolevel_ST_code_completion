VAR
    rRadians : REAL;
    rCos : REAL;
    rSin : REAL;
    rTranslatedX : REAL;
    rTranslatedY : REAL;
END_VAR

rRadians := rAngle * 3.14159265359 / 180.0; (* Convert angle to radians using numeric value of PI *)
rCos := COS(rRadians);          (* Calculate cosine of the angle *)
rSin := SIN(rRadians);          (* Calculate sine of the angle *)

(* Translate point to origin *)
rTranslatedX := rPointX - rCenterX;
rTranslatedY := rPointY - rCenterY;

(* Rotate the point *)
rRotatedX := rTranslatedX * rCos - rTranslatedY * rSin + rCenterX;
rRotatedY := rTranslatedX * rSin + rTranslatedY * rCos + rCenterY;

RETURN;
END_FUNCTION