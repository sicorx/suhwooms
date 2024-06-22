package rems.eqmt.persistence;

import java.util.HashMap;
import java.util.List;

import rems.eqmt.model.SystemVo;

public interface EqmtStoreSemsMapper {

	List<SystemVo> retrieveStoreSemsList(HashMap<String, Object> params);

	public List<HashMap<String, Object>> retrieveExcelStoreSemsList(HashMap<String, Object> params);
}
