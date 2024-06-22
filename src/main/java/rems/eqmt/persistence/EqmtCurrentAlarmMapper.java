package rems.eqmt.persistence;

import java.util.List;
import java.util.Map;

public interface EqmtCurrentAlarmMapper {

	public Map<String, String> retrieveQueryDate(Map<String, Object> param);
	
	public List<Map<String, String>> retrieveEquipmentFailureDay(Map<String, String> param);
	
	public List<Map<String, String>> retrieveEquipmentFailureWeek(Map<String, String> param);
	
	public List<Map<String, String>> retrieveEquipmentFailureMonth(Map<String, String> param);
	
	public List<Map<String, String>> retrieveEquipmentFailureList(Map<String, Object> param);
	
	public List<Map<String, String>> retrieveLatestTemp(Map<String, String> param);
}
