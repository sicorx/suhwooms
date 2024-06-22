package rems.system.persistence;

import java.util.HashMap;
import java.util.List;

import rems.system.model.GridRemsDeviceMgntVo;
import rems.system.model.RemsConfigMgntVo;
import rems.system.model.RemsConfigMstVo;

public interface RemsConfigMgntMapper {

	public List<RemsConfigMgntVo> retrieveRemsConfigDataList(HashMap<String, Object> params);
	
	public RemsConfigMstVo retrieveRemsConfMst();
	
	public String retrieveStoreContractPower(HashMap<String, Object> params);
	
	public GridRemsDeviceMgntVo retrieveStoreRemsPart(HashMap<String, Object> params);
	
	public int saveRemsConfigMgnt(HashMap<String,Object> params);
	
	public RemsConfigMgntVo retrieveRemsConfigParticularData(HashMap<String, Object> params);
	
	public RemsConfigMstVo retrieveRemsConfigTempLevelData(HashMap<String, Object> params);
	
	public int deleteRemsConfigPaticularData(HashMap<String, Object> params);
	
	public int updateStoreContractPower(HashMap<String, Object> params);
	
	public int deleteRemsConfigMgnt(HashMap<String, Object> params);
	
	// REMS 환경 정보 초기 저장
	public int saveConfigMgnt_init(HashMap<String, Object> params);
	
	// REMS 환경 정보 지우기
	public int delConfigMgnt(HashMap<String, Object> params);
	
	//엑셀다운로드
	public List<HashMap<String, Object>> downloadRemsConfigDataListExcel(HashMap<String, Object> params);
}
