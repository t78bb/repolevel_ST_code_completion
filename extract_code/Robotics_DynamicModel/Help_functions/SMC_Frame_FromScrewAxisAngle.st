/// Calculates an SE(3) frame from a screw axis
/// (a normalized |TwistVec|) and an angle.
FUNCTION SMC_Frame_FromScrewAxisAngle
VAR_IN_OUT
    /// The resulting frame.
    f : SM3M.SMC_Frame;
END_VAR
VAR_IN_OUT CONSTANT
    /// The screw axis.
    A : TwistVec;
END_VAR
VAR_INPUT
    /// The angle.
    theta : LREAL;
END_VAR
VAR
    wv : SM3M.SMC_VECTOR3D;
    w2v : SM3M.SMC_VECTOR3D;
    wt : SM3M.SMC_VECTOR3D;
END_VAR

SM3M.SMC_V3_Cross(wv, A.w, A.v);
SM3M.SMC_V3_Cross(w2v, A.w, wv);

SM3M.SMC_V3_Mult(f.vT, A.v, theta);
SM3M.SMC_V3_MAdd(f.vT, f.vT, wv, (1 - COS(theta)));
SM3M.SMC_V3_MAdd(f.vT, f.vT, w2v, (theta - SIN(theta)));

SM3M.SMC_V3_Mult(wt, A.w, theta);
SM3M.SMC_Matrix3_FromAxisAngle(f.mR, wt);