PROGRAM PLC_PRG
VAR
	state : UDINT;
	error : SMC_ERROR;
	
	// 凸轮数据
	camSegmentsExport: ARRAY[0..MAX_NUM_OF_CAM_SEGMENTS-1] OF SMC_CAM_SEGMENT;
	camRefExport: MC_CAM_REF;
	
	// 使用重构后的功能块
	fbCamBuilder		:	FB_CamBuilder;			// 凸轮创建器
	fbCamExporter		:	FB_CamFileExporter;		// 凸轮导出器
	fbCamImporter		:	FB_CamFileImporter;		// 凸轮导入器
	
	// 控制信号
	bStartCreateCam		:	BOOL;	// 启动凸轮创建
	bStartExportCam		:	BOOL;	// 启动凸轮导出
	bStartImportCam		:	BOOL;	// 启动凸轮导入
END_VAR
VAR_TEMP
	camId : UDINT;
END_VAR
VAR CONSTANT
	STATE_CREATE_CAM : UDINT := 0;
	STATE_EXPORT_CAM : UDINT := 10;
	STATE_START_IMPORT_CAM : UDINT := 20;
	STATE_DONE : UDINT := 500;
	STATE_ERROR : UDINT := 1000;
	MAX_NUM_OF_CAM_SEGMENTS : INT := 3;
	EXPORT_CAM_FILE_NAME : STRING := 'exportedCam.cam';
END_VAR

CASE state OF
STATE_CREATE_CAM:
	// 使用FB_CamBuilder创建凸轮
	bStartCreateCam := TRUE;
	
	fbCamBuilder(
		bExecute := bStartCreateCam,
		pSegments := ADR(camSegmentsExport),
		nSegmentsSize := XSIZEOF(camSegmentsExport)
	);
	
	IF fbCamBuilder.bDone THEN
		// 凸轮创建成功，获取凸轮引用
		camRefExport := fbCamBuilder.camRef;
		bStartCreateCam := FALSE;
		state := STATE_EXPORT_CAM;
	ELSIF fbCamBuilder.bError THEN
		// 凸轮创建失败
		error := fbCamBuilder.errorID;
		bStartCreateCam := FALSE;
		state := state + STATE_ERROR;
	END_IF

STATE_EXPORT_CAM:
	// 使用FB_CamFileExporter导出凸轮
	bStartExportCam := TRUE;
	
	fbCamExporter(
		camRef := camRefExport,
		bExecute := bStartExportCam,
		sFileName := EXPORT_CAM_FILE_NAME
	);
	
	IF fbCamExporter.bDone THEN
		// 导出成功
		bStartExportCam := FALSE;
		state := STATE_START_IMPORT_CAM;
	ELSIF fbCamExporter.bError THEN
		// 导出失败
		bStartExportCam := FALSE;
		state := state + STATE_ERROR;
	END_IF

STATE_START_IMPORT_CAM:
	// 使用FB_CamFileImporter导入凸轮
	bStartImportCam := TRUE;
	
	fbCamImporter(
		bExecute := bStartImportCam,
		sFileName := EXPORT_CAM_FILE_NAME
	);
	
	IF fbCamImporter.bDone THEN
		// 导入成功
		bStartImportCam := FALSE;
		state := STATE_DONE;
	ELSIF fbCamImporter.bError THEN
		// 导入失败
		bStartImportCam := FALSE;
		state := state + STATE_ERROR;
	END_IF

STATE_DONE:
	// 所有操作完成
	// 可以在这里添加后续处理逻辑
	;

STATE_CREATE_CAM + STATE_ERROR,
STATE_EXPORT_CAM + STATE_ERROR,
STATE_START_IMPORT_CAM + STATE_ERROR:
	// 错误状态处理
	// 可以在这里添加错误恢复逻辑
	;
END_CASE
