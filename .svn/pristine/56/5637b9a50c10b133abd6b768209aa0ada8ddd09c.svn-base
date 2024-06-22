package rems.system.service;

import java.util.HashMap;
import java.util.List;

import rems.system.model.GridStoreInverterMgntVo;
import rems.system.model.StoreInverterDataVo;

public interface StoreInverterMgntSvc {
	
	public List<GridStoreInverterMgntVo> retrieveInverterMgnt(HashMap<String, Object> params);
	
	public List<GridStoreInverterMgntVo> retrieveStoreInverterMgntDtl(HashMap<String, Object> params);
	
	public boolean saveStoreInverterMgnt(StoreInverterDataVo params);
	
	public boolean deleteStoreInverterMgnt(HashMap<String, Object> params);
	
	// REMS 인버터 정보 초기 저장
	public int saveStoreInverterMgnt_init(HashMap<String, Object> params );
	
	// 인버터 지우기
	public int delStoreInverterMgnt(HashMap<String, Object> params );
	
}
