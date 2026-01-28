FUNCTION_BLOCK mdbsPhyToLogic	//modbus本地索引对应回传华中的状态地址
VAR_INPUT
	section		:INT;	//区域限定(1:grdExt, 2:grdRet, 3:skyExt, 4:skyRet)
	phyIdx		:INT;	//内存物理地址对应数组索引
END_VAR
VAR_OUTPUT
	lgcIdx		:INT;	//华中对应的地址	127 175 223 271...
END_VAR
VAR
END_VAR

CASE section OF
    1: // 区域限定(1:groundExtend)
        CASE phyIdx OF
            1: lgcIdx := 223; // grd1e -> 横1 223
            2: lgcIdx := 231; // grd2e -> 纵1 231
            3: lgcIdx := 224; // grd3e -> 横2 224
            4: lgcIdx := 225; // grd4e -> 横3 225
            5: lgcIdx := 226; // grd5e -> 横4 226
            6: lgcIdx := 227; // grd6e -> 横5 227
            7: lgcIdx := 232; // grd7e -> 纵2 232
            8: lgcIdx := 228; // grd8e -> 横6 228
            9: lgcIdx := 229; // grd9e -> 横7 229
            10: lgcIdx := 230; // grd10e -> 横8 230
        END_CASE
    2: // 区域限定(2:groundRetract)
        CASE phyIdx OF
            1: lgcIdx := 127; // grd1r -> 横1 127
            2: lgcIdx := 135; // grd2r -> 纵1 135
            3: lgcIdx := 128; // grd3r -> 横2 128
            4: lgcIdx := 129; // grd4r -> 横3 129
            5: lgcIdx := 130; // grd5r -> 横4 130
            6: lgcIdx := 131; // grd6r -> 横5 131
            7: lgcIdx := 136; // grd7r -> 纵2 136
            8: lgcIdx := 132; // grd8r -> 横6 132
            9: lgcIdx := 133; // grd9r -> 横7 133
            10: lgcIdx := 134; // grd10r -> 横8 134
        END_CASE
    3: // 区域限定(3:skyExtend)
        CASE phyIdx OF
            1: lgcIdx := 271; // sky1e -> 横1 271
            2: lgcIdx := 279; // sky2e -> 纵1 279
            3: lgcIdx := 272; // sky3e -> 横2 272
            4: lgcIdx := 273; // sky4e -> 横3 273
            5: lgcIdx := 274; // sky5e -> 横4 274
            6: lgcIdx := 275; // sky6e -> 横5 275
            7: lgcIdx := 280; // sky7e -> 纵2 280
            8: lgcIdx := 276; // sky8e -> 横6 276
            9: lgcIdx := 277; // sky9e -> 横7 277
            10: lgcIdx := 278; // sky10e -> 横8 278
        END_CASE
    4: // 区域限定(4:skyRetract)
        CASE phyIdx OF
            1: lgcIdx := 175; // sky1r -> 横1 175
            2: lgcIdx := 183; // sky2r -> 纵1 183
            3: lgcIdx := 176; // sky3r -> 横2 176
            4: lgcIdx := 177; // sky4r -> 横3 177
            5: lgcIdx := 178; // sky5r -> 横4 178
            6: lgcIdx := 179; // sky6r -> 横5 179
            7: lgcIdx := 184; // sky7r -> 纵2 184
            8: lgcIdx := 180; // sky8r -> 横6 180
            9: lgcIdx := 181; // sky9r -> 横7 181
            10: lgcIdx := 182; // sky10r -> 横8 182
        END_CASE
END_CASE
END_FUNCTION_BLOCK
