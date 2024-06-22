package rems.eqmt.service;

import java.util.HashMap;
import java.util.List;

import rems.common.model.SelectVo;
import rems.eqmt.model.GridEqmtAlarmListVo;
import rems.eqmt.model.PlantAlarmListVo;
import rems.eqmt.model.PlantStatusListVo;
import rems.eqmt.model.PlantStatusVo;

public interface EqmtStatusSvc {

	//시설물 현황(1page)
	public List<PlantStatusVo> retrievePlantStatus(HashMap<String, Object> params);
	
	// 시설물목록
	public List<PlantStatusListVo> retrieveEqmtStoreMgnt(HashMap<String, Object> params);	
	
	// 	시설물온도
	public List<PlantStatusListVo> retrieveEqmtTempChart(HashMap<String, Object> params);
	
	// 시설물 장비
	public List<SelectVo> retrieveEqmtList(HashMap<String, Object> params);
	
	// 시설물 장비유형
	public List<SelectVo> retrieveEqmtTypeList(HashMap<String, Object> params);	
	
	// AS 타입 유형
	public List <SelectVo> retrieveEqmtAsTypeList(HashMap<String, Object> params);
	
	// 시설물 알람
	public List<GridEqmtAlarmListVo> retrieveEqmtAlarmStatus(HashMap<String, Object> params);	
	
	// 엑셀
	public List<HashMap<String, Object>> retrieveEqmtAlarmExcelStatus(HashMap<String, Object> params);
	
	// 시설물 알람 - 조치 내역 확인/조회
	public GridEqmtAlarmListVo retrieveEqmtAlarmAsResult(HashMap<String, Object> params);
	
	// 시설물 알람 - 조치 내역 입력
	public String retrieveAsResultYn(HashMap<String, Object> params);
	
	// 시설물 알람 - 조치 내역 입력
	public int saveEqmtAlarmAsResult(HashMap<String, Object> params);
	
	// 시설물 알람 - 조치 내역 입력 - 경영주 푸쉬
	public int saveEqmtAlarmAsResultPush(HashMap<String, Object> params);
	
	//시설물 가동상태
	public List <PlantStatusVo> retrieveOperateUse(HashMap<String, Object> params);
	
	//월 알람 발생 횟수
	public List<PlantStatusVo> retrieveAlarmCntMonth(HashMap<String, Object> params);
	
	//알람발생 시설물 목록(2page)
	public List<PlantAlarmListVo> retrievePlantAlarmList(HashMap<String, Object> params);

	//알람발생 시설물 목록 상세(2page)
	public List<HashMap<String, String>> retrievePlantAlarmDtlList(HashMap<String, Object> params);
	
	//시설물 조회(3page)
	public List<PlantStatusListVo> retrievePlantSearch(HashMap<String, Object> params);
	
	//월별 시설물
	public List<HashMap<String, String>> retrievePlantMonthList(HashMap<String, Object> params);
	
	//일자별 시설물
	public List<HashMap<String, String>> retrievePlantDailyList(HashMap<String, Object> params);
	
	//시설물 차트
	public List<HashMap<String, String>> retrievePlantStatusChrt(HashMap<String, Object> params);	
}
