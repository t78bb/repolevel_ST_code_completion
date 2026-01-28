/// Applies a spatial inertia matrix to a twist vector 
/// resulting in a generalized momentum or force vector 
/// depending on whether the twist represents a velocity
/// or an acceleration.
FUNCTION MatSI_ApplyTwist
VAR_IN_OUT
    /// The resulting generalized momentum or force.
    W : WrenchVec;
END_VAR
VAR_IN_OUT CONSTANT
    /// The spatial inertia matrix.
    G : SMDYN.DynSpatialInertia;
    /// The generalized velocity or acceleration.
    T : TwistVec;
END_VAR

SM3M.SMC_Matrix3_Apply(W.m, G.I, T.w);
SM3M.SMC_V3_Mult(W.f, T.v, G.m);