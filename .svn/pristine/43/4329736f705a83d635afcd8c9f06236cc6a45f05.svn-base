package rems.system.persistence;

import java.util.HashMap;
import java.util.List;

import rems.energy.model.EpContDemandListVo;
import rems.energy.model.EpStatusVo;
import rems.eqmt.model.GridEqmtAlarmListVo;
import rems.eqmt.model.PlantStatusListVo;
import rems.system.model.DashBoardStoreDataVo;

public interface DashBoardMgntMapper {

	// 매장 정보
	public DashBoardStoreDataVo retrieveStoreMstData(HashMap<String, Object> params);
	
	// 매장 상단 정보
	public DashBoardStoreDataVo retrieveStoreRealData(HashMap<String, Object> params);
	
	// 매장 1단 상단 에너지사용량
	public DashBoardStoreDataVo retrieveStoreEnergyData(HashMap<String, Object> params);
	
	// 매장 1단 상단 에너지사용량 - 차트데이터
	public List<DashBoardStoreDataVo> retrieveStoreEnergyChartData(HashMap<String, Object> params);
	
	// 시설물 알람 처리 현황	
	public DashBoardStoreDataVo retrieveStoreAlarmData(HashMap<String, Object> params);
	
	// 시설물 현황
	public List<DashBoardStoreDataVo> retrieveStoreEqmtData(HashMap<String, Object> params);

	// 월별 전력량
	public List<EpStatusVo> retrieveEnergyMonthStatus(HashMap<String, Object> params);
	
	// 일별 전력량
	public List<EpStatusVo> retrieveEnergyDayStatus(HashMap<String, Object> params);
	
	// 일별 전력량
	public List<EpStatusVo> retrieveEnergyDayStatus_tab(HashMap<String, Object> params);
	
	// 일별 상세 전력량(차트)
	public List<EpStatusVo> retrieveEnergyDayStatusChart(HashMap<String, Object> params);
	
	// 월별 계약전력량
	public List<EpContDemandListVo> retrieveDemandEnergyMonthStatus(HashMap<String, Object> params);
	
	// 일별 계약전력 대비 사용량
	public List<EpContDemandListVo> retrieveDemandEnergyDayStatus(HashMap<String, Object> params);
	
	// 일별 상세 계약전력량(차트)
	public List<EpContDemandListVo> retrieveDemandEnergyDayStatusChart(HashMap<String, Object> params);
	
	// 시설물 목록
	public List<PlantStatusListVo> retrieveFacilityStatus(HashMap<String, Object> params);

	// 시설물 온도(차트)
	public List<PlantStatusListVo> retrieveFacilityStatusChart(HashMap<String, Object> params);
	
	// 알림 목록
	public List<GridEqmtAlarmListVo> retrieveAlarmStatus(HashMap<String, Object> params);

	/////////////////////////////////////////////////////////////////////////////////////////////////
	// 대시보드 - 매장 상단정보
	public DashBoardStoreDataVo retrieveDashStoreMstData(HashMap<String, Object> params);
	
	// 대시보드 - 계약전력 사용현황
	public List<DashBoardStoreDataVo> retrieveStoreContPowerData(HashMap<String, Object> params);
	
	// 대시보드 - 시설물 알림 현황
	public DashBoardStoreDataVo retrieveDashStoreAlarmData(HashMap<String, Object> params);
	
	// 대시보드 - 피크 현황 차트 데이터
	public List<DashBoardStoreDataVo> retrieveStorePeakChartData(HashMap<String, Object> params);
	
	// 대시보드 - 실시간알람 개수
	public DashBoardStoreDataVo retrieveDashDataCount(HashMap<String, Object> params);
}
