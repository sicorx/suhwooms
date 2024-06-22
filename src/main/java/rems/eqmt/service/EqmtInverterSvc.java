package rems.eqmt.service;

import java.util.HashMap;
import java.util.List;

import rems.eqmt.model.GridStoreInverterVo;

public interface EqmtInverterSvc {
	
	public List<GridStoreInverterVo> retrieveStoreInverter(HashMap<String, Object> params);
}
 