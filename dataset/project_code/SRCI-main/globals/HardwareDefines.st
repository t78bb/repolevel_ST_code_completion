{attribute 'qualified_only'}
VAR_GLOBAL
  {region "Comau"}
  /// Inputs of PLC for communication from Comau RC
  Comau_RobotInData                  : ARRAY[0..255] OF BYTE;

  Comau_RobotInData_1   AT %IB10     : ARRAY[0..63] OF BYTE;
  Comau_RobotInData_2   AT %IB75     : ARRAY[0..63] OF BYTE;
  Comau_RobotInData_3   AT %IB140    : ARRAY[0..63] OF BYTE;
  Comau_RobotInData_4   AT %IB205    : ARRAY[0..63] OF BYTE;

   
  /// Outputs of PLC for communication to Comau RC
  Comau_RobotOutData                 : ARRAY[0..255] OF BYTE;
  Comau_RobotOutData_1  AT %QB8      : ARRAY[0..63] OF BYTE;
  Comau_RobotOutData_2  AT %QB72     : ARRAY[0..63] OF BYTE;
  Comau_RobotOutData_3  AT %QB136    : ARRAY[0..63] OF BYTE;
  Comau_RobotOutData_4  AT %QB200    : ARRAY[0..63] OF BYTE;
  {endregion} 
  
     
  {region "Jaka"}
  /// Inputs of PLC for communication from Jaka RC
  Jaka_RobotInData      AT %IB955    : ARRAY[0..255] OF BYTE;
  /// Outputs of PLC for communication to Jaka RC
  Jaka_RobotOutData     AT %QB544    : ARRAY[0..255] OF BYTE;
  {endregion} 
     
     
  {region "Staubli"}
  /// Inputs of PLC for communication from Stäubli RC
  Staubli_RobotInData   AT %IB1217   : ARRAY[0..255] OF BYTE;
  /// Outputs of PLC for communication to Stäubli RC
  Staubli_RobotOutData  AT %QB800    : ARRAY[0..255] OF BYTE;
  {endregion}   
     
     
  {region "Yaskawa"}  
  /// Inputs of PLC for communication from RC
  Yaskawa_RobotInData   AT %ID370    : ARRAY[0..108] OF UDINT;
  /// Inputs of PLC for communication from RC
  Yaskawa_RobotInDataSwaped          : ARRAY[0..108] OF UDINT;
  /// Outputs of PLC for communication to RC
  Yaskawa_RobotOutData  AT %QD264    : ARRAY[0..108] OF UDINT;
  /// Outputs of PLC for communication to RC
  Yaskawa_RobotOutDataSwaped         : ARRAY[0..108] OF UDINT;
  {endregion} 
  

  {region "Kawasaki"}  
  /// Inputs of PLC for communication from Kawasaki RC
  Kawasaki_RobotInData  AT %IW961    : ARRAY[0..255] OF BYTE;
  /// Outputs of PLC for communication to Kawasaki RC
  Kawasaki_RobotOutData AT %QW746    : ARRAY[0..255] OF UINT;
  {endregion} 
END_VAR