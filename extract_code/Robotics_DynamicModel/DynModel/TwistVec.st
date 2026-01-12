/// A six dimensional twist vector representing
/// a generalized velocity or acceleration.
TYPE TwistVec :
STRUCT
    /// The angular velocity or acceleration component.
    w : SM3M.SMC_VECTOR3D;
    /// The linear velocity or acceleration component.
    v : SM3M.SMC_VECTOR3D;
END_STRUCT
END_TYPE
