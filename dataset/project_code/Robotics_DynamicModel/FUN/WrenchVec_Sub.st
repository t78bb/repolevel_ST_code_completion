FUNCTION WrenchVec_Sub
VAR_IN_OUT
    V_dst : WrenchVec;
END_VAR
VAR_IN_OUT CONSTANT
    V_lhs : WrenchVec;
    V_rhs : WrenchVec;
END_VAR

SM3M.SMC_V3_Sub(V_dst.m, V_lhs.m, V_rhs.m);
SM3M.SMC_V3_Sub(V_dst.f, V_lhs.f, V_rhs.f);