package rems.system.persistence;

import java.util.HashMap;
import java.util.List;

import rems.system.model.GridDimmTimePolicyMgntVo;
import rems.system.model.GridDimmWeatherPolicyMgntVo;

public interface DimmPolicyMgntMapper {

	public List<GridDimmTimePolicyMgntVo> retrieveDimmTimePolicyList(HashMap<String, Object> params);

	public List<GridDimmWeatherPolicyMgntVo> retrieveDimmWeatherPolicyList(HashMap<String, Object> params);
	
	public int saveDimmTimePolicyMgnt(HashMap<String, Object> params);
	
	public int saveDimmWeatherPolicyMgnt(HashMap<String, Object> params);
	
}
