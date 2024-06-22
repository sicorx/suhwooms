package rems.system.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import rems.common.model.SelectVo;
import rems.system.model.MenuVo;

public interface MenuMgntSvc {
	List<Map<String, Object>> retrieveMenuList(HashMap<String, String> params);

	void saveMenuBatch(HashMap<String, Object> insertMap, HashMap<String, Object> updateMap, HashMap<String, Object> deleteMap);
}
