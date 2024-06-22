package rems.eqmt.service;

import java.util.HashMap;
import java.util.List;

import rems.eqmt.model.GridTemonStatusVo;

public interface EqmtStoreTemonSvc {
	
	public List<GridTemonStatusVo> retrieveStoreTemonList(HashMap<String, Object> params);
}
 