FUNCTION TwistVec_Add
VAR_IN_OUT
    V_dst : TwistVec;
END_VAR
VAR_IN_OUT CONSTANT
    V_lhs : TwistVec;
    V_rhs : TwistVec;
END_VAR

SM3M.SMC_V3_Add(V_dst.w, V_lhs.w, V_rhs.w);
SM3M.SMC_V3_Add(V_dst.v, V_lhs.v, V_rhs.v);