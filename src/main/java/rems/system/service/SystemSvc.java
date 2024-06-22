package rems.system.service;

import rems.system.model.SessionUserVo;
import rems.system.model.UserVo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface SystemSvc {

	SessionUserVo retrieveLoginUser(UserVo params);

	int saveEulaYn(HashMap<String, Object> params);

	Map<String, Object> retrieveTopAreaInfo(Map<String, String> params);

	List<Map<String, Object>> retrieveMenu(Map<String, String> params);
}