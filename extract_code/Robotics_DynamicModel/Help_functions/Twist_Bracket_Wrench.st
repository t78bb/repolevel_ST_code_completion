/// Calculates the generalized cross product
/// between a |TwistVec|, representing a generalized
/// velocity, and a |WrenchVec|, representing a
/// generalized momentum, resulting in a generalized
/// force.
FUNCTION Twist_Bracket_Wrench
VAR_IN_OUT
    /// The resulting force.
    F_dst : WrenchVec;
END_VAR
VAR_IN_OUT CONSTANT
    /// The velocity.
    V_src : TwistVec;
    /// The momentum.
    F_src : WrenchVec;
END_VAR
VAR
    m0 : SM3M.SMC_VECTOR3D;
    m1 : SM3M.SMC_VECTOR3D;
END_VAR

SM3M.SMC_V3_Cross(m0, F_src.m, V_src.w);
SM3M.SMC_V3_Cross(m1, F_src.f, V_src.v);
SM3M.SMC_V3_Cross(F_dst.f, F_src.f, V_src.w);
SM3M.SMC_V3_Add(F_dst.m, m0, m1);