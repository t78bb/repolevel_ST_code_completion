FUNCTION TwistVec_Scale
VAR_IN_OUT
    V_dst : TwistVec;
END_VAR
VAR_IN_OUT CONSTANT
    V_src : TwistVec;
END_VAR
VAR_INPUT
    theta : LREAL;
END_VAR

SM3M.SMC_V3_Mult(V_dst.w, V_src.w, theta);
SM3M.SMC_V3_Mult(V_dst.v, V_src.v, theta);