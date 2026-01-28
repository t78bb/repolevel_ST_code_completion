FUNCTION RotationCalculation : BOOL
VAR_INPUT
    rCenterX : REAL;    (* X coordinate of rotation center *)
    rCenterY : REAL;    (* Y coordinate of rotation center *)
    rAngle : REAL;      (* Rotation angle in degrees *)
    rPointX : REAL;     (* X coordinate of point to rotate *)
    rPointY : REAL;     (* Y coordinate of point to rotate *)
END_VAR

VAR_OUTPUT
    rRotatedX : REAL;   (* X coordinate after rotation *)
    rRotatedY : REAL;   (* Y coordinate after rotation *)
END_VAR
VAR
    rRadians : REAL;
    rCos : REAL;
    rSin : REAL;
    rTranslatedX : REAL;
    rTranslatedY : REAL;
END_VAR

rRadians := rAngle * PI / 180.0; (* Convert angle to radians *)
rCos := COS(rRadians);          (* Calculate cosine of the angle *)
rSin := SIN(rRadians);          (* Calculate sine of the angle *)

(* Translate point to origin *)
rTranslatedX := rPointX - rCenterX;
rTranslatedY := rPointY - rCenterY;

(* Rotate the point *)
rRotatedX := rTranslatedX * rCos - rTranslatedY * rSin + rCenterX;
rRotatedY := rTranslatedX * rSin + rTranslatedY * rCos + rCenterY;

RETURN TRUE;
END_FUNCTION
