/// A six dimensional wrench vector representing
/// a generalized momentum or force.
TYPE WrenchVec :
STRUCT
    /// The angular momentum or torque component.
    m : SM3M.SMC_VECTOR3D;
    /// The linear momentum or force component.
    f : SM3M.SMC_VECTOR3D;
END_STRUCT
END_TYPE
