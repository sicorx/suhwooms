package rems.eqmt.service;

import java.util.HashMap;
import java.util.List;

import rems.eqmt.model.SystemVo;

public interface EqmtStoreLogSvc {

	List<SystemVo> retrieveStoreLogList(HashMap<String, Object> params);

	// 엑셀
	public List<HashMap<String, Object>> downloadEqmtStoreLogExcel(HashMap<String, Object> params);	
}
