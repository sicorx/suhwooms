package rems.system.persistence;

import rems.system.model.SessionUserVo;
import rems.system.model.UserVo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface SystemMapper {
	
	SessionUserVo retrieveLoginUser(UserVo params);

	String retrieveUserPw(HashMap<String, Object> params);

	int saveEulaYn(HashMap<String, Object> params);

	Map<String, Object> retrieveTopAreaInfo(Map<String, String> params);

	List<Map<String, Object>> retrieveMenu(Map<String, String> params);
}
