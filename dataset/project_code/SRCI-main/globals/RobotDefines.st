VAR_GLOBAL
  ///  User data stored on the PLC according to Table 6-10
  UserData          : UserData;
  /// ToolData stored on PLC. For more information refer to 5.5.6.3
  ToolData          : ARRAY[0..RobotLibraryParameter.TOOL_MAX -1      ] OF Tool;
  /// LoadData stored on PLC.For more information refer to 5.5.6.4
  FrameData         : ARRAY[0..RobotLibraryParameter.FRAME_MAX -1     ] OF Frame;
  /// LoadData stored on PLC.For more information refer to 5.5.6.4
  LoadData          : ARRAY[0..RobotLibraryParameter.LOAD_MAX -1      ] OF Load;
  /// Work areas stored on PLC. For more information refer to 5.5.8
  WorkAreas         : ARRAY[0..RobotLibraryParameter.WORK_AREAS_MAX -1] OF RobotWorkArea;
  /// Software limits stored on PLC
  SWLimits          : SWLimits;
  /// Default dynamics stored on PLC. For more information refer to 5.5.7
  DefaultDynamics   : DefaultDynamics;
  /// Reference dynamics stored on PLC. For more information refer to 5.5.7
  ReferenceDynamics : ReferenceDynamics;
  /// System log on PLC
  SystemLog         : ARRAY[0..RobotLibraryParameter.SYSTEM_LOG_MAX ] OF STRING(RobotLibraryParameter.MESSAGE_TEXT_LEN);
  ///Message buffer on the PLC - For more information refer to 5.5.11
  MessageLog        : ARRAY[0..RobotLibraryParameter.MESSAGE_LOG_MAX] OF AlarmMessage;
  /// Robot assignment of function
  AxesGroup         : AxesGroup;
  /// Logger
	Logger            : LoggerFB;
  /// File Logger
	FileLogger        : FileLoggerFB;  
  /// Example chain
  SqS_Example       : SqS_ExampleFB;
  
  
  // --------------------------------------------------------------------------
  // Core Profile FBs
  // --------------------------------------------------------------------------
  /// RobotTask FB 
  RobotTask                         : MC_RobotTaskFB;
  /// EnableRobot FB 
  EnableRobot                       : MC_EnableRobotFB;
  /// GroupReset FB 
  GroupReset                        : MC_GroupResetFB;
  /// GroupStop FB 
  GroupStop                         : MC_GroupStopFB;
  /// GroupInterrupt FB 
  GroupInterrupt                    : MC_GroupInterruptFB;
  /// GroupContinue FB 
  GroupContinue                     : MC_GroupContinueFB;
  /// GroupJog FB 
  GroupJog                          : MC_GroupJogFB;
  /// SetSequence FB 
  SetSequence                       : MC_SetSequenceFB;
  /// ReadActualPosition FB 
  ReadActualPosition                : MC_ReadActualPositionFB;
  /// ReadActualPositionCyclic FB 
  ReadActualPositionCyclic          : MC_ReadActualPositionCyclicFB;
  /// MoveAxesAbsolute FB 
  MoveAxesAbsolute                  : MC_MoveAxesAbsoluteFB;
  /// MoveDirectAbsolute FB 
  MoveDirectAbsolute                : MC_MoveDirectAbsoluteFB;
  /// MoveLinearAbsolute FB 
  MoveLinearAbsolute                : MC_MoveLinearAbsoluteFB;
  /// ChangeSpeedOverride FB 
  ChangeSpeedOverride               : MC_ChangeSpeedOverrideFB;
  /// ReadFrameData FB 
  ReadFrameData                     : MC_ReadFrameDataFB;
  /// ReadToolData FB 
  ReadToolData                      : MC_ReadToolDataFB;
  /// ReadLoadData FB 
  ReadLoadData                      : MC_ReadLoadDataFB;
  /// ReadRobotDefaultDynamics FB 
  ReadRobotDefaultDynamics          : MC_ReadRobotDefaultDynamicsFB;
  /// ReadRobotReferenceDynamics FB 
  ReadRobotReferenceDynamics        : MC_ReadRobotReferenceDynamicsFB;
  /// ReadRobotSwLimits FB 
  ReadRobotSwLimits                 : MC_ReadRobotSwLimitsFB;
  /// ReturnToPrimary FB 
  ReturnToPrimary                   : MC_ReturnToPrimaryFB;
  /// WriteFrameData FB 
  WriteFrameData                    : MC_WriteFrameDataFB;
  /// WriteToolData FB 
  WriteToolData                     : MC_WriteToolDataFB;                                    
  /// WriteLoadData FB 
  WriteLoadData                     : MC_WriteLoadDataFB;
  /// WriteRobotDefaultDynamics FB 
  WriteRobotDefaultDynamics         : MC_WriteRobotDefaultDynamicsFB;
  /// WriteRobotReferenceDynamics FB 
  WriteRobotReferenceDynamics       : MC_WriteRobotReferenceDynamicsFB;
  /// WriteRobotSwLimits FB 
  WriteRobotSwLimits                : MC_WriteRobotSwLimitsFB;
  

  // --------------------------------------------------------------------------
  // Extended Profile FBs
  // --------------------------------------------------------------------------

  /// MoveLinearRelative FB 
  MoveLinearRelative         : MC_MoveLinearRelativeFB;
  /// MoveDirectRelative FB 
  MoveDirectRelative         : MC_MoveDirectRelativeFB;
  /// MoveAxesRelative FB 
  MoveAxesRelative           : MC_MoveAxesRelativeFB;  
  /// MoveCircularAbsolute FB 
  MoveCircularAbsolute       : MC_MoveCircularAbsoluteFB;
  /// MoveCircularRelative FB 
  MoveCircularRelative       : MC_MoveCircularRelativeFB;
  /// MoveLinearOffset FB 
  MoveLinearOffset           : MC_MoveLinearOffsetFB;
  /// MoveDirectOffset FB 
  MoveDirectOffset           : MC_MoveDirectOffsetFB;
  /// WaitTime FB 
  WaitTime                   : MC_WaitTimeFB;
  /// ReadCallSubprogramCyclic FB 
  ReadCallSubprogramCyclic   : MC_ReadCallSubprogramCyclicFB;
  /// ReadDigitalInputs FB 
  ReadDigitalInputs          : MC_ReadDigitalInputsFB;
  /// ReadDigitalOutputs FB 
  ReadDigitalOutputs         : MC_ReadDigitalOutputsFB;
  /// ReadIntegers FB 
  ReadIntegers               : MC_ReadIntegersFB;
  /// ReadReals FB 
  ReadReals                  : MC_ReadRealsFB;
  /// WriteIntegers FB 
  WriteIntegers              : MC_WriteIntegersFB;
  /// WriteReals FB 
  WriteReals                 : MC_WriteRealsFB;
  /// MoveLinearCam FB 
  MoveLinearCam              : MC_MoveLinearCamFB;
  /// MoveLinearAbsoluteJ FB 
  MoveLinearAbsoluteJ        : MC_MoveLinearAbsoluteJFB;
  /// MoveDirectCam FB 
  MoveDirectCam              : MC_MoveLinearCamFB;  
  /// MoveCircularCam FB 
  MoveCircularCam            : MC_MoveCircularCamFB;
  /// SetTriggerRegister FB 
  SetTriggerRegister         : MC_SetTriggerRegisterFB;
  /// SetTriggerLimit FB 
  SetTriggerLimit            : MC_SetTriggerLimitFB;
  /// SetTriggerUser FB 
  SetTriggerUser             : MC_SetTriggerUserFB;
  /// SetTriggerError FB 
  SetTriggerError            : MC_SetTriggerErrorFB;
  /// StopSubProgram FB 
  StopSubProgram             : MC_StopSubProgramFB;
  /// ReactAtTrigger FB 
  ReactAtTrigger             : MC_ReactAtTriggerFB;
  /// WaitForTrigger FB 
  WaitForTrigger             : MC_WaitForTriggerFB;
  /// ReadSystemVariable FB 
  ReadSystemVariable         : MC_ReadSystemVariableFB;
  /// WriteSystemVariable FB 
  WriteSystemVariable        : MC_WriteSystemVariableFB;
  /// CalculateForwardKinematic FB 
  CalculateForwardKinematic  : MC_CalculateForwardKinematicFB;
  /// CalculateInverseKinematic FB 
  CalculateInverseKinematic  : MC_CalculateInverseKinematicFB;  
  /// CalculateCartesianPosition FB 
  CalculateCartesianPosition : MC_CalculateCartesianPositionFB;
  /// CalculateTool FB 
  CalculateTool              : MC_CalculateToolFB;
  /// CalculateFrame FB 
  CalculateFrame             : MC_CalculateFrameFB;
  /// ActivateNextCommand FB 
  ActivateNextCommand        : MC_ActivateNextCommandFB;
  /// ShiftPosition FB 
  ShiftPosition              : MC_ShiftPositionFB;
  /// WriteCallSubprogramCyclic FB 
  WriteCallSubprogramCyclic : MC_WriteCallSubprogramCyclicFB;
  /// WriteDigitalOutputs FB 
  WriteDigitalOutputs       : MC_WriteDigitalOutputsFB;
  // --------------------------------------------------------------------------
  // Optional Profile FBs
  // --------------------------------------------------------------------------
  /// ReadDHParameter FB 
  ReadDHParameter            : MC_ReadDHParameterFB;
  /// RestartController FB 
  RestartController          : MC_RestartControllerFB;
  /// ReadActualTCPVelocity FB 
  ReadActualTCPVelocity      : MC_ReadActualTCPVelocityFB;
  /// UserLogin FB 
  UserLogin                  : MC_UserLoginFB;
  /// SwitchLanguage FB 
  SwitchLanguage             : MC_SwitchLanguageFB;
  /// SetOperationMode FB 
  SetOperationMode           : MC_SetOperationModeFB;
  /// ReadWorkArea FB 
  ReadWorkArea               : MC_ReadWorkAreaFB;
  /// WriteWorkArea FB 
  WriteWorkArea              : MC_WriteWorkAreaFB;
  /// ActivateWorkArea FB 
  ActivateWorkArea           : MC_ActivateWorkAreaFB;
  /// MonitorWorkArea FB 
  MonitorWorkArea            : MC_MonitorWorkAreaFB;
  /// MoveApproachLinear FB 
  MoveApproachLinear         : MC_MoveApproachLinearFB;
  /// MoveDepartLinear FB 
  MoveDepartLinear           : MC_MoveDepartLinearFB;
  /// MoveApproachDirect FB 
  MoveApproachDirect         : MC_MoveApproachDirectFB;
  /// MoveDepartDirect FB 
  MoveDepartDirect           : MC_MoveDepartDirectFB;
  /// SearchHardStop FB 
  SearchHardStop             : MC_SearchHardStopFB;
  /// SearchHardStopJ FB 
  SearchHardStopJ            : MC_SearchHardStopJFB;
  /// MovePickPlaceLinear FB 
  MovePickPlaceLinear        : MC_MovePickPlaceLinearFB;
  /// MovePickPlaceDirect FB 
  MovePickPlaceDirect        : MC_MovePickPlaceDirectFB;
  /// ActivateConveyorTracking FB 
  ActivateConveyorTracking   : MC_ActivateConveyorTrackingFB;
  /// RedefineTrackingPos FB 
  RedefineTrackingPos        : MC_RedefineTrackingPosFB;
  /// SyncToConveyor FB 
  SyncToConveyor             : MC_SyncToConveyorFB;
  /// ConfigureConveyor FB 
  ConfigureConveyor          : MC_ConfigureConveyorFB;
  /// MoveSuperImposed FB 
  MoveSuperImposed           : MC_MoveSuperImposedFB;
  /// MoveSuperImposedDynamic FB 
  MoveSuperImposedDynamic    : MC_MoveSuperImposedDynamicFB;
  /// ReadAnalogInput FB 
  ReadAnalogInput            : MC_ReadAnalogInputFB;
  /// ReadAnalogOutput FB 
  //ReadAnalogOutput         : MC_ReadAnalogOutputFB;
  /// WriteAnalogOutput FB 
  WriteAnalogOutput          : MC_WriteAnalogOutputFB;
  /// MeasuringInput FB 
  MeasuringInput             : MC_MeasuringInputFB;
  /// AbortMeasuringInput FB 
  AbortMeasuringInput        : MC_AbortMeasuringInputFB;
  /// SetTriggerMotion FB 
  SetTriggerMotion           : MC_SetTriggerMotionFB;
  /// OpenBrake FB 
  OpenBrake                  : MC_OpenBrakeFB;
  /// CallSubprogram FB 
  CallSubprogram             : MC_CallSubprogramFB;
  /// PathAccuracyMode FB 
  PathAccuracyMode           : MC_PathAccuracyModeFB;
  /// AvoidSingularity FB 
  AvoidSingularity           : MC_AvoidSingularityFB;
  /// ForceControl FB 
  ForceControl               : MC_ForceControlFB;
  /// ForceLimit FB 
  ForceLimit                 : MC_ForceLimitFB;
  /// ReadActualForce FB 
  ReadActualForce            : MC_ReadActualForceFB;
  /// BrakeTest FB 
  BrakeTest                  : MC_BrakeTestFB;
  /// SoftSwitchTcp FB 
  SoftSwitchTcp              : MC_SoftSwitchTcpFB;
  /// CreateSpline FB 
  CreateSpline               : MC_CreateSplineFB;
  /// DeleteSpline FB 
  DeleteSpline               : MC_DeleteSplineFB;
  /// MoveSpline FB 
  MoveSpline                 : MC_MoveSplineFB;
  /// DynamicSpline FB 
  DynamicSpline              : MC_DynamicSplineFB;
  /// LoadMeasurementAutomatic FB 
  LoadMeasurementAutomatic   : MC_LoadMeasurementAutomaticFB;
  /// LoadMeasurementSequential FB 
  LoadMeasurementSequential  : MC_LoadMeasurementSequentialFB;
  /// CollisionDetection FB 
  CollisionDetection         : MC_CollisionDetectionFB;
  /// FreeDrive FB 
  FreeDrive                  : MC_FreeDriveFB;
  /// UnitMeasurement FB 
  UnitMeasurement            : MC_UnitMeasurementFB;
  
  
  HomePositions              : RobotJointCurrentShort := (J1 := 0, J2 := 0, J3 := 0, J4 := 0, J5 := 0, J6 := 0);
  
END_VAR