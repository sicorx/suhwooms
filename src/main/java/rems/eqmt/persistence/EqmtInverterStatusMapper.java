package rems.eqmt.persistence;

import java.util.HashMap;
import java.util.List;

import rems.common.model.SelectVo;
import rems.eqmt.model.GridInverterStatusVo;

public interface EqmtInverterStatusMapper { 

	public List<GridInverterStatusVo> retrieveInverterStatusList(HashMap<String, Object> params);
	
	public GridInverterStatusVo  retrieveInverterStatusDtl(HashMap<String, Object> params);
	
	public List<SelectVo> retrieveInverterList(HashMap<String, Object> params);
	
	public List<HashMap<String, String>> retrieveInverterTempChartData(HashMap<String, Object> params);
}
