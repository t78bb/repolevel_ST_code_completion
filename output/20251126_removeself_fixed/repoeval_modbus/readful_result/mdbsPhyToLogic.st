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

(**
 * 将物理地址索引解析为华中指令的标号
 * (lgcIdx:华中对应的地址)
 *)
CASE section OF
    1: // 区域限定1:grdExt
        CASE phyIdx OF
            1:  lgcIdx := 127;    // 地轨1 -> 华中地址127
            2:  lgcIdx := 128;    // 地轨2 -> 华中地址128
            3:  lgcIdx := 129;    // 地轨3 -> 华中地址129
            4:  lgcIdx := 130;    // 地轨4 -> 华中地址130
            5:  lgcIdx := 131;    // 地轨5 -> 华中地址131
            6:  lgcIdx := 132;    // 地轨6 -> 华中地址132
            7:  lgcIdx := 133;    // 地轨7 -> 华中地址133
            8:  lgcIdx := 134;    // 地轨8 -> 华中地址134
            9:  lgcIdx := 135;    // 地轨9 -> 华中地址135
            10: lgcIdx := 136;    // 地轨10 -> 华中地址136
        END_CASE;
    2: // 区域限定2:grdRet
        CASE phyIdx OF
            1:  lgcIdx := 175;    // 地轨1 -> 华中地址175
            2:  lgcIdx := 176;    // 地轨2 -> 华中地址176
            3:  lgcIdx := 177;    // 地轨3 -> 华中地址177
            4:  lgcIdx := 178;    // 地轨4 -> 华中地址178
            5:  lgcIdx := 179;    // 地轨5 -> 华中地址179
            6:  lgcIdx := 180;    // 地轨6 -> 华中地址180
            7:  lgcIdx := 181;    // 地轨7 -> 华中地址181
            8:  lgcIdx := 182;    // 地轨8 -> 华中地址182
            9:  lgcIdx := 183;    // 地轨9 -> 华中地址183
            10: lgcIdx := 184;    // 地轨10 -> 华中地址184
        END_CASE;
    3: // 区域限定3:skyExt
        CASE phyIdx OF
            1:  lgcIdx := 223;    // 天轨1 -> 华中地址223
            2:  lgcIdx := 224;    // 天轨2 -> 华中地址224
            3:  lgcIdx := 225;    // 天轨3 -> 华中地址225
            4:  lgcIdx := 226;    // 天轨4 -> 华中地址226
            5:  lgcIdx := 227;    // 天轨5 -> 华中地址227
            6:  lgcIdx := 228;    // 天轨6 -> 华中地址228
            7:  lgcIdx := 229;    // 天轨7 -> 华中地址229
            8:  lgcIdx := 230;    // 天轨8 -> 华中地址230
            9:  lgcIdx := 231;    // 天轨9 -> 华中地址231
            10: lgcIdx := 232;    // 天轨10 -> 华中地址232
        END_CASE;
    4: // 区域限定4:skyRet
        CASE phyIdx OF
            1:  lgcIdx := 271;    // 天轨1 -> 华中地址271
            2:  lgcIdx := 272;    // 天轨2 -> 华中地址272
            3:  lgcIdx := 273;    // 天轨3 -> 华中地址273
            4:  lgcIdx := 274;    // 天轨4 -> 华中地址274
            5:  lgcIdx := 275;    // 天轨5 -> 华中地址275
            6:  lgcIdx := 276;    // 天轨6 -> 华中地址276
            7:  lgcIdx := 277;    // 天轨7 -> 华中地址277
            8:  lgcIdx := 278;    // 天轨8 -> 华中地址278
            9:  lgcIdx := 279;    // 天