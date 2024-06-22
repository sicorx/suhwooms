package rems.eqmt.persistence;

import java.util.HashMap;
import java.util.List;

import rems.eqmt.model.SystemVo;

public interface EqmtStoreMapper {

	List<SystemVo> retrieveStore(HashMap<String, Object> params);

	List<SystemVo> retrieveAuthList(HashMap<String, Object> params);
	
	public List<HashMap<String, Object>> retrieveStoreExcel(HashMap<String, Object> params);

}
