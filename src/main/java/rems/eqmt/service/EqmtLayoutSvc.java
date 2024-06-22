package rems.eqmt.service;

import java.util.HashMap;
import java.util.List;

public interface EqmtLayoutSvc {
	
	//모든 시설물의 현재 온도 및 알람 값 조회
	public List<HashMap<String, String>> retrieveEqmtCurTempAlarm(HashMap<String, String> param);
	
	//특정 시설물의 하루 온도 조회
	public List<HashMap<String, String>> retrieveEqmtDailyTemp(HashMap<String, String> param);
	
	//특정 시설물의 하루 알람 조회
	public List<HashMap<String, String>> retrieveEqmtDailyAlarm(HashMap<String, String> param);
	
	//개별 시설물 온도 차트
	public List<HashMap<String, String>> retrieveEqmtTempChrt(HashMap<String, Object> params);
	
	//개별 시설물 알람 목록
	public List<HashMap<String, String>> retrieveEqmtAlarmList(HashMap<String, Object> params);	
	
}
