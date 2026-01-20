FUNCTION_BLOCK mdbsLogicToPhy	//modbus华中挡板地址编号对应本地索引编号
VAR_INPUT
  section		:INT;	//区域限定 1:skyExt, 2:skyRet, 3:grdExt, 4:grdRet)
  lgcIdx		:INT;	//华中对应的地址	10,14{1..10}  17,20{1..11}
END_VAR
VAR_OUTPUT
  level		:INT;	//1->地轨	2->天轨
  phyIdx		:INT;	//内存物理地址对应数组索引
  direct		:TargetDirect;
END_VAR

CASE section OF
  1: // skyExtend
    level := 2;
    direct := TargetDirect.extend;
    CASE lgcIdx OF
      1: phyIdx := 1;
      2: phyIdx := 3;
      3: phyIdx := 4;
      4: phyIdx := 5;
      5: phyIdx := 6;
      6: phyIdx := 8;
      7: phyIdx := 9;
      8: phyIdx := 10;
      9: phyIdx := 11;
      10: phyIdx := 12;
    END_CASE;
  2: // skyRetract
    level := 2;
    direct := TargetDirect.retract;
    CASE lgcIdx OF
      1: phyIdx := 13;
      2: phyIdx := 14;
      3: phyIdx := 15;
      4: phyIdx := 16;
      5: phyIdx := 17;
      6: phyIdx := 18;
      7: phyIdx := 19;
      8: phyIdx := 20;
      9: phyIdx := 21;
      10: phyIdx := 22;
    END_CASE;
  3: // groundExtend
    level := 1;
    direct := TargetDirect.extend;
    CASE lgcIdx OF
      1: phyIdx := 23;
      2: phyIdx := 24;
      3: phyIdx := 25;
      4: phyIdx := 26;
      5: phyIdx := 27;
      6: phyIdx := 28;
      7: phyIdx := 29;
      8: phyIdx := 30;
      9: phyIdx := 31;
      10: phyIdx := 32;
    END_CASE;
  4: // groundRetract
    level := 1;
    direct := TargetDirect.retract;
    CASE lgcIdx OF
      1: phyIdx := 33;
      2: phyIdx := 34;
      3: phyIdx := 35;
      4: phyIdx := 36;
      5: phyIdx := 37;
      6: phyIdx := 38;
      7: phyIdx := 39;
      8: phyIdx := 40;
      9: phyIdx := 41;
      10: phyIdx := 42;
    END_CASE;
  ELSE
    level := 0;
    phyIdx := 0;
    direct := TargetDirect.undefined;
END_CASE;
END_FUNCTION_BLOCK