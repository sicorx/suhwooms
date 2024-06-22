package rems.system.service;

import java.util.HashMap;
import java.util.List;

import rems.system.model.GridStoreMgntVo;

public interface StoreMgntSvc {
	
	public List<GridStoreMgntVo> retrieveRemsStoreMgnt(HashMap<String, Object> params);
	
	public GridStoreMgntVo retrieveRemsStoreMgntDtl(HashMap<String, Object> params);
	
	public String getMaxStrCd(HashMap<String, Object> params);
	
	public boolean getViewStrCd(HashMap<String, Object> params);

	public boolean saveRemsStoreMgnt(GridStoreMgntVo params);
	
	// 초기화
	public boolean saveRemsStoreMgnt_init(GridStoreMgntVo params);
	
	// 지우기
	public int delRemsStoreMgnt(HashMap<String, Object> params);
	
	// 매장 엑셀
	public List<HashMap<String, Object>> retrieveExcelRemsStoreList(HashMap<String, Object> params);

	// 매장리스트 엑셀
	public List<HashMap<String, Object>> retrieveExcelRemsMgntStoreList(HashMap<String, Object> params);
	
	// REMS 환경 업데이트
	public boolean updateEnvConfMst(HashMap<String, Object> params);

	public int saveSignManualCtrlInfo_init(GridStoreMgntVo params);

	public int delSignManualCtrlInfo(HashMap<String, Object> params);
}
