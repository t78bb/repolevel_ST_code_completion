/// Applies a coordinate transformation T_ab to a twist vector V_b in se(3).
///       |   mR     0 |
/// V_a = |            | V_b
///       |[vT]*mR   mR|
FUNCTION SMC_Frame_ApplyTwist
VAR_IN_OUT
    /// Twist vector in a frame coordinates
	V_a : TwistVec;
END_VAR
VAR_IN_OUT CONSTANT
    /// Orientation and position of the b frame
    /// in a frame coordinates.
	T_ab : SM3M.SMC_Frame;
    /// Twist vector in b frame coordinates.
	V_b : TwistVec;
END_VAR
VAR
    vTmp : SM3M.SMC_VECTOR3D;
END_VAR

SM3M.SMC_Matrix3_Apply(V_a.w, T_ab.mR, V_b.w);
SM3M.SMC_Matrix3_Apply(V_a.v, T_ab.mR, V_b.v);
SM3M.SMC_V3_Cross(vTmp, T_ab.vT, V_a.w);
SM3M.SMC_V3_Add(V_a.v, V_a.v, vTmp);