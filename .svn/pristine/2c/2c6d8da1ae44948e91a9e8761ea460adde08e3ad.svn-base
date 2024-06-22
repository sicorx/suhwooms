package rems.system.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import rems.common.persistence.CommonMapper;
import rems.energy.model.EpContDemandListVo;
import rems.energy.model.EpStatusVo;
import rems.eqmt.model.GridEqmtAlarmListVo;
import rems.eqmt.model.PlantStatusListVo;
import rems.system.model.DashBoardStoreDataVo;
import rems.system.persistence.DashBoardMgntMapper;

@Service
public class DashBoardMgntSvcImpl implements DashBoardMgntSvc {

	@Autowired
	private DashBoardMgntMapper dashBoardMgntMapper;
	
	@Autowired
	private CommonMapper commonMapper;
	
	private static final Logger LOGGER = LoggerFactory.getLogger( DashBoardMgntSvcImpl.class );
	
	
	// 매장 정보
	@Override
	public DashBoardStoreDataVo retrieveStoreMstData(HashMap<String, Object> params) {
		LOGGER.info( "retrieveStoreMstData : " + params );
		
		return dashBoardMgntMapper.retrieveStoreMstData(params);
	}
	
	// 매장 상단 정보
	@Override
	public DashBoardStoreDataVo retrieveStoreRealData(HashMap<String, Object> params) {
		LOGGER.info( "retrieveStoreRealData : " + params );
		
		return dashBoardMgntMapper.retrieveStoreRealData(params);
	}	
	
	// 매장 1단 에너지사용량
	@Override
	public DashBoardStoreDataVo retrieveStoreEnergyData(HashMap<String, Object> params) {
		LOGGER.info( "retrieveStoreEnergyData : " + params );
		
		return dashBoardMgntMapper.retrieveStoreEnergyData(params);
	}	
	
	// 매장 1단 에너지사용량 - 차트 데이터
	@Override
	public List<DashBoardStoreDataVo> retrieveStoreEnergyChartData(HashMap<String, Object> params) {
		LOGGER.info( "retrieveStoreEnergyChartData : " + params );
		
		return dashBoardMgntMapper.retrieveStoreEnergyChartData(params);
	}
	
	// 시설물 알람 처리 현황
	@Override
	public DashBoardStoreDataVo retrieveStoreAlarmData(HashMap<String, Object> params) {
		LOGGER.info( "retrieveStoreAlarmData : " + params );
		
		return dashBoardMgntMapper.retrieveStoreAlarmData(params);
	}	
	
	// 시설물 알람 처리 현황
	@Override
	public List<DashBoardStoreDataVo> retrieveStoreEqmtData(HashMap<String, Object> params) {
		LOGGER.info( "retrieveStoreEqmtData : " + params );
		
		return dashBoardMgntMapper.retrieveStoreEqmtData(params);
	}
	
	// 월별 전력량
	@Override
	public List<EpStatusVo> retrieveEnergyMonthStatus(HashMap<String, Object> params) {
		LOGGER.error( "retrieveEnergyMonthStatus : " + params );
		
		return dashBoardMgntMapper.retrieveEnergyMonthStatus(params);
	}
	
	// 일별 전력량
	@Override
	public List<EpStatusVo> retrieveEnergyDayStatus(HashMap<String, Object> params) {
		LOGGER.error( "retrieveEnergyDayStatus : " + params );
		
		return dashBoardMgntMapper.retrieveEnergyDayStatus(params);
	}
	
	// 일별 전력량 tab
	@Override
	public List<EpStatusVo> retrieveEnergyDayStatus_tab(HashMap<String, Object> params) {
		LOGGER.error( "retrieveEnergyDayStatus_tab : " + params );
		
		return dashBoardMgntMapper.retrieveEnergyDayStatus_tab(params);
	}
	
	// 일별 상세 전력량(차트)
	@Override
	public List<EpStatusVo> retrieveEnergyDayStatusChart(HashMap<String, Object> params) {
		LOGGER.error( "retrieveEnergyDayStatusChart : " + params );
		
		return dashBoardMgntMapper.retrieveEnergyDayStatusChart(params);
	}
	
	// 월별 계약전력량
	@Override
	public List<EpContDemandListVo> retrieveDemandEnergyMonthStatus(HashMap<String, Object> params) {
		LOGGER.error( "retrieveDemandEnergyMonthStatus : " + params );
		
		return dashBoardMgntMapper.retrieveDemandEnergyMonthStatus(params);
	}
	
	// 일별 계약전력 대비 사용량
	@Override
	public List<EpContDemandListVo> retrieveDemandEnergyDayStatus(HashMap<String, Object> params) {
		LOGGER.error( "retrieveDemandEnergyDayStatus : " + params );
		
		return dashBoardMgntMapper.retrieveDemandEnergyDayStatus(params);
	}
	
	// 일별 상세 계약전력량(차트)
	@Override
	public List<EpContDemandListVo> retrieveDemandEnergyDayStatusChart(HashMap<String, Object> params) {
		LOGGER.error( "retrieveDemandEnergyDayStatusChart : " + params );
		
		return dashBoardMgntMapper.retrieveDemandEnergyDayStatusChart(params);
	}

	// 시설물 목록
	@Override
	public List<PlantStatusListVo> retrieveFacilityStatus(HashMap<String, Object> params) {
		LOGGER.error( "retrieveFacilityStatus : " + params );
		
		return dashBoardMgntMapper.retrieveFacilityStatus(params);
	}

	// 시설물 온도(차트)
	@Override
	public List<PlantStatusListVo> retrieveFacilityStatusChart(HashMap<String, Object> params) {
		LOGGER.error( "retrieveFacilityStatusChart : " + params );
		
		return dashBoardMgntMapper.retrieveFacilityStatusChart(params);
	}
	
	// 알림 목록
	@Transactional
	@Override
	public List<GridEqmtAlarmListVo> retrieveAlarmStatus(HashMap<String, Object> params) {
		LOGGER.error( "retrieveAlarmStatus : " + params );
		
		List<GridEqmtAlarmListVo> list = dashBoardMgntMapper.retrieveAlarmStatus(params);
		if (list.size() > 0) {
			int cnt = commonMapper.selectTotalCnt();
			list.get(0).setTotal(String.valueOf(cnt));
		}
		
		return list;
	}
	
	////////////////////////////////////////////////////////////////////////////////////////////////////
	// 대시보드 - 매장 상단정보
	@Override
	public DashBoardStoreDataVo retrieveDashStoreMstData(HashMap<String, Object> params) {
		LOGGER.info( "retrieveDashStoreMstData : " + params );
		
		return dashBoardMgntMapper.retrieveDashStoreMstData(params);
	}	
	
	// 대시보드 - 계약전력 사용현황
	@Override
	public List<DashBoardStoreDataVo> retrieveStoreContPowerData(HashMap<String, Object> params) {
		LOGGER.info( "retrieveStoreContPowerData : " + params );
		
		return dashBoardMgntMapper.retrieveStoreContPowerData(params);
	}	
	
	
	// 대시보드 - 시설물 알림 현황
	@Override
	public DashBoardStoreDataVo retrieveDashStoreAlarmData(HashMap<String, Object> params) {
		LOGGER.info( "retrieveDashStoreAlarmData : " + params );
		
		return dashBoardMgntMapper.retrieveDashStoreAlarmData(params);
	
	}
	
	// 대시보드 - 피크 현황 차트 데이터
	@Override
	public List<DashBoardStoreDataVo> retrieveStorePeakChartData(HashMap<String, Object> params) {
		LOGGER.info( "retrieveStorePeakChartData : " + params );
		
		return dashBoardMgntMapper.retrieveStorePeakChartData(params);
	
	}
	
	// 대시보드 - 실시간알람 개수
	@Override
	public DashBoardStoreDataVo retrieveDashDataCount(HashMap<String, Object> params) {
		LOGGER.info( "retrieveDashDataCount : " + params );
		
		return dashBoardMgntMapper.retrieveDashDataCount(params);
		
	}
}
