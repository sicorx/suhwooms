package rems.eqmt.persistence;

import java.util.HashMap;
import java.util.List;

import rems.eqmt.model.SystemVo;

public interface EqmtStoreLogMapper {

	List<SystemVo> retrieveStoreLogList(HashMap<String, Object> params);
	
	public List<HashMap<String, Object>> downloadEqmtStoreLogExcel(HashMap<String, Object> params);

}
