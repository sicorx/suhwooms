package rems.eqmt.persistence;

import java.util.HashMap;
import java.util.List;

import rems.common.model.SelectVo;
import rems.eqmt.model.GridTemonStatusVo;

public interface EqmtTemonStatusMapper {
	
	public List<GridTemonStatusVo> retrieveTemonStatusList(HashMap<String, Object> params);
	
	public List<SelectVo> retrieveTemonList(HashMap<String, Object> params);
	
	public List<HashMap<String, String>> retrieveTemonTempChartData(HashMap<String, Object> params);

}
