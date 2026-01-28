/// Calculates the dot product between a wrench and a twist.
FUNCTION Wrench_Dot_Twist
VAR_IN_OUT CONSTANT
    F : WrenchVec;
    V : TwistVec;
END_VAR
VAR_OUTPUT
    Wrench_Dot_Twist : LREAL;
END_VAR

Wrench_Dot_Twist := SM3M.SMC_V3_Dot(F.m, V.w) + SM3M.SMC_V3_Dot(F.f, V.v);