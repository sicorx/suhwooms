package rems.system.persistence;

import java.util.HashMap;
import java.util.List;

import rems.system.model.GridStoreInverterMgntVo;

public interface StoreInverterMgntMapper {

	public List<GridStoreInverterMgntVo> retrieveInverterMgnt(HashMap<String, Object> params);
	
	public List<GridStoreInverterMgntVo> retrieveStoreInverterMgntDtl(HashMap<String, Object> params);
	
	public int saveStoreInverterMgnt(GridStoreInverterMgntVo params);
	
	public int deleteStoreInverterMgnt(HashMap<String, Object> params);
	
	// REMS 인버터 정보 초기 저장
	public int saveStoreInverterMgnt_init(HashMap<String, Object> params);	
	
	// REMS 인버터 정보 지우기
	public int delStoreInverterMgnt(HashMap<String, Object> params);	
	
	
}
