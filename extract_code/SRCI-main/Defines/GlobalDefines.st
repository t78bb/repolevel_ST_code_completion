{attribute 'qualified_only'}
VAR_GLOBAL
  /// Task Info
  TaskInfo     : Task_Info2;
	/// local date
	LocalDate    : DATE;
	/// local time
	LocalTime    : TOD;
	/// local date and time
	LocalDT      : DT;
  /// Time struce
  Timestruct   : SYSTIMEDATE;
  /// System time
  SysTime      : SystemTime;
  /// Online change active
  {attribute 'init_on_onlchange'}
  OnlineChange : BOOL := TRUE;
END_VAR