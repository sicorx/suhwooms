package rems.system.persistence;

import java.util.HashMap;
import java.util.List;

import rems.common.model.AreaVo;
import rems.system.model.GridStoreMgntVo;

public interface StoreMgntMapper {

	public List<GridStoreMgntVo> retrieveRemsStoreMgnt(HashMap<String, Object> params);
	
	public GridStoreMgntVo retrieveRemsStoreMgntDtl(HashMap<String, Object> params);
	
	public String getMaxStrCd(HashMap<String, Object> params);

	public int getViewStrCd(HashMap<String, Object> params);
	
	public int saveRemsStoreMgnt(GridStoreMgntVo params);
	
	public int saveRemsStoreMgnt_init(GridStoreMgntVo params);
	
	public List<AreaVo> getLocalAreaCd(HashMap<String, Object> params);
	
	public int delRemsStoreMgnt(HashMap<String, Object> params);
	
	public List<HashMap<String, Object>> retrieveExcelRemsStoreList(HashMap<String, Object> params);

	public List<HashMap<String, Object>> retrieveExcelRemsMgntStoreList(HashMap<String, Object> params);
	
	public int updateEnvConfMst(HashMap<String, Object> params);

	public int delSignManualCtrlInfo(HashMap<String, Object> params);

	public int saveSignManualCtrlInfo_init(GridStoreMgntVo params);
}

