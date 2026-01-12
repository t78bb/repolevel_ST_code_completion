/// Calculates the generalized cross product
/// between two |TwistVec|s, both representing
/// generalized velocities. The result is a
/// generalized acceleration.
FUNCTION Twist_Bracket_Twist
VAR_IN_OUT
    /// The resulting acceleration.
    V_dst : TwistVec;
END_VAR
VAR_IN_OUT CONSTANT
    /// The first velocity.
    V_lhs : TwistVec;
    /// The second velocity.
    V_rhs : TwistVec;
END_VAR
VAR
    v0 : SM3M.SMC_VECTOR3D;
    v1 : SM3M.SMC_VECTOR3D;
END_VAR

SM3M.SMC_V3_Cross(v0, V_lhs.v, V_rhs.w);
SM3M.SMC_V3_Cross(v1, V_lhs.w, V_rhs.v);
SM3M.SMC_V3_Cross(V_dst.w, V_lhs.w, V_rhs.w);
SM3M.SMC_V3_Add(V_dst.v, v0, v1);