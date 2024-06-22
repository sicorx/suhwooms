package rems.system.persistence;

import java.util.HashMap;
import java.util.List;

import rems.system.model.DemandPowerExcelDataVo;

public interface DemandPowerExcelUtilMapper {

	public int insertStrInfoDB(HashMap<String, Object> params);
	public int insertGwInfoDB(HashMap<String, Object> params);
	public int insertRemsPartCntDB(HashMap<String, Object> params);
	public int insertStrConfDB(HashMap<String, Object> params);
	public int insertTemonInfoDB(HashMap<String, Object> params);
	public int insertInvInfoDB(HashMap<String, Object> params);	
	
	public String getStrCdValue(HashMap<String, Object> params);	
	public String getGwIdValue(HashMap<String, Object> params);
	
	public void deleteInfoDB(HashMap<String, Object> params);

	public List<DemandPowerExcelDataVo> getDemandPowerStoreList(HashMap<String, Object> params);
	
	public int insertRecommendDemandPower(HashMap<String, Object> params);
	
	public int insertStoreArea(HashMap<String, Object> params);
	
	public int insertStorePeak(HashMap<String, Object> params);
	
	public int saveElectricEnt_init(HashMap<String, Object> params);
	
	public int updateElectricEnt(HashMap<String, Object> params);
	
	public int delElectricEnt(HashMap<String, Object> params);
	
	public List<HashMap<String, Object>> retrieveExcelDemandPowerStoreList(HashMap<String, Object> params);
}
