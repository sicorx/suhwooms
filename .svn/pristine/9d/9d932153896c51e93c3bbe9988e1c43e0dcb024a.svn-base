package rems.system.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import rems.system.model.DemandPowerExcelDataVo;
import rems.system.model.GridMaintainEngineerMgntVo;

public interface DemandPowerExcelUtilSvc {

	public List<DemandPowerExcelDataVo> insertArticleInBoard(File destFile);
	
	

	public List<DemandPowerExcelDataVo> getDemandPowerStoreList(HashMap<String, Object> params);
	
	public int insertRecommendDemandPower(HashMap<String, Object> params);
	
	public int insertStoreArea(HashMap<String, Object> params);
	
	public int insertStorePeak(HashMap<String, Object> params);
	
	public int saveElectricEnt_init(HashMap<String, Object> params);
	
	public int updateElectricEnt(HashMap<String, Object> params);
	
	public int delElectricEnt(HashMap<String, Object> params);
	
	//계약전력산출 엑셀다운로드
	public List<HashMap<String, Object>> retrieveExcelDemandPowerStoreList(HashMap<String, Object> params);
	
}
