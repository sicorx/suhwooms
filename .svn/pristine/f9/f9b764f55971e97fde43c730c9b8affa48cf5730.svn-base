package rems.system.service;

import java.util.HashMap;
import java.util.List;

import rems.system.model.GridRemsDeviceMgntVo;
import rems.system.model.RemsConfigMgntVo;
import rems.system.model.RemsConfigMstVo;

public interface RemsConfigMgntSvc {
	
	public List<RemsConfigMgntVo> retrieveRemsConfigDataList(HashMap<String, Object> params);
	
	public RemsConfigMstVo retrieveRemsConfMst();
	
	public String retrieveStoreContractPower(HashMap<String, Object> params);
	
	public GridRemsDeviceMgntVo retrieveStoreRemsPart(HashMap<String, Object> params);
	
	public boolean saveRemsConfigMgnt(HashMap<String,Object> params);
	
	public RemsConfigMgntVo retrieveRemsConfigParticularData(HashMap<String, Object> params);
	
	public RemsConfigMstVo retrieveRemsConfigTempLevelData(HashMap<String, Object> params);
	
	public boolean deleteRemsConfigPaticularData(HashMap<String, Object> params);
	
	public boolean updateStoreContractPower(HashMap<String, Object> params);
	
	// REMS 환경정보 초기 저장
	public int saveConfigMgnt_init(HashMap<String, Object> params);	
	
	// REMS 환경정보 지우기
	public int delConfigMgnt(HashMap<String, Object> params);
	
	//엑셀다운로드
	public List<HashMap<String, Object>> downloadRemsConfigDataListExcel(HashMap<String, Object> params);
	
	
}