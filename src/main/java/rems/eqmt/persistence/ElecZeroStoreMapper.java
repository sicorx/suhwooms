package rems.eqmt.persistence;

import java.util.HashMap;
import java.util.List;

import rems.eqmt.model.SystemVo;

public interface ElecZeroStoreMapper {

	List<SystemVo> retrieveElecStore(HashMap<String, Object> params);

	List<SystemVo> retrieveAuthList(HashMap<String, Object> params);
	
	public List<HashMap<String, Object>> retrieveElecStoreExcel(HashMap<String, Object> params);

}
