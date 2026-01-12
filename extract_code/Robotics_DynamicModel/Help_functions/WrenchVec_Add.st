FUNCTION WrenchVec_Add
VAR_IN_OUT
    F_dst : WrenchVec;
END_VAR
VAR_IN_OUT CONSTANT
    F_lhs : WrenchVec;
    F_rhs : WrenchVec;
END_VAR

SM3M.SMC_V3_Add(F_dst.m, F_lhs.m, F_rhs.m);
SM3M.SMC_V3_Add(F_dst.f, F_lhs.f, F_rhs.f);