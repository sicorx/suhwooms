package rems.eqmt.persistence;

import java.util.HashMap;
import java.util.List;

import rems.eqmt.model.SystemVo;

public interface EqmtEnergyMapper {

	List<SystemVo> retrieveEnergyList(HashMap<String, Object> params);

	public List<HashMap<String, Object>> retrieveExcelEnergyList(HashMap<String, Object> params);
}
