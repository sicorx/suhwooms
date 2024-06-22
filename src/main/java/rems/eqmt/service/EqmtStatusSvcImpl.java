package rems.eqmt.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import rems.common.model.SelectVo;
import rems.common.persistence.CommonMapper;
import rems.eqmt.model.GridEqmtAlarmListVo;
import rems.eqmt.model.PlantAlarmListVo;
import rems.eqmt.model.PlantStatusListVo;
import rems.eqmt.model.PlantStatusVo;
import rems.eqmt.persistence.EqmtStatusMapper;
import rems.system.model.GridStoreMgntVo;

@Service
public class EqmtStatusSvcImpl implements EqmtStatusSvc {

	@Autowired
	private EqmtStatusMapper plantAllMapper;
	
	@Autowired
	private CommonMapper commonMapper;
	
	private static final Logger LOGGER = LoggerFactory.getLogger( EqmtStatusSvcImpl.class );

	@Override
	public List<PlantStatusVo> retrievePlantStatus(HashMap<String, Object> params) {

		LOGGER.info( "retrievePlantStatus" );

		return plantAllMapper.retrievePlantStatus(params);
	}
	
	
	// 시설물 목록
	@Transactional
	@Override
	public List<PlantStatusListVo> retrieveEqmtStoreMgnt(HashMap<String, Object> params) {

		LOGGER.info( "retrieveEqmtStoreMgnt" );
		
		List<PlantStatusListVo> list = plantAllMapper.retrieveEqmtStoreMgnt(params);
		
		int cnt = commonMapper.selectTotalCnt();
		if( cnt != 0 )		
			list.get(0).setTotal(String.valueOf(cnt));				
		
		return list;		
	}
	
	//알람 엑셀다운로드
	@Override
	public List<HashMap<String, Object>> retrieveEqmtAlarmExcelStatus(HashMap<String, Object> params) {
		
		List<HashMap<String, Object>> list = plantAllMapper.retrieveEqmtAlarmexcelStatus(params);
		
		return list;
	}

	// 시설물 목록
	@Override
	public List<PlantStatusListVo> retrieveEqmtTempChart(HashMap<String, Object> params) {

		LOGGER.info( "retrieveEqmtTempChart" );

		return plantAllMapper.retrieveEqmtTempChart(params);
	}

	// 시설물 장비
	@Override
	public List<SelectVo> retrieveEqmtList(HashMap<String, Object> params) {

		LOGGER.info( "retrieveEqmtList" );

		return plantAllMapper.retrieveEqmtList(params);
	}
	
	// 시설물 장비 유형
	@Override
	public List<SelectVo> retrieveEqmtTypeList(HashMap<String, Object> params) {

		LOGGER.info( "retrieveEqmtTypeList" );

		return plantAllMapper.retrieveEqmtTypeList(params);
	}
	
	// AS 타입 유형
	@Override
	public List<SelectVo> retrieveEqmtAsTypeList(HashMap<String, Object> params) {

		LOGGER.info( "retrieveEqmtAsTypeList" );

		return plantAllMapper.retrieveEqmtAsTypeList(params);
	}
	
	//시설물 알람
	@Transactional
	@Override
	public List<GridEqmtAlarmListVo> retrieveEqmtAlarmStatus(HashMap<String, Object> params) {

			LOGGER.info( "retrieveEqmtAlarmStatus" );			
			
			List<GridEqmtAlarmListVo> list = plantAllMapper.retrieveEqmtAlarmStatus(params);
			
			int cnt = commonMapper.selectTotalCnt();
			if( cnt != 0 )		
				list.get(0).setTotal(String.valueOf(cnt));				
			
			return list;		
			
	}
	
	
	// 시설물 알람 - 조치 내역 확인/조회
	@Override
	public GridEqmtAlarmListVo retrieveEqmtAlarmAsResult(HashMap<String, Object> params) {

			LOGGER.info( "retrieveEqmtAlarmAsResult" );

			return plantAllMapper.retrieveEqmtAlarmAsResult(params);
	}
	
	// 시설물 알람 - 조치 내역 확인
	@Override
	public String retrieveAsResultYn(HashMap<String, Object> params) {

			LOGGER.info( "retrieveAsResultYn" );			
			
			return plantAllMapper.retrieveAsResultYn(params);
	}

	
	// 시설물 알람 - 조치 내역 입력
	@Override
	public int saveEqmtAlarmAsResult(HashMap<String, Object> params) {

			LOGGER.info( "saveEqmtAlarmAsResult" );

			return plantAllMapper.saveEqmtAlarmAsResult(params);
	}
	
	// 시설물 알람 - 조치 내역 입력 - 경영주 푸쉬
	@Override
	public int saveEqmtAlarmAsResultPush(HashMap<String, Object> params) {

			LOGGER.info( "saveEqmtAlarmAsResultPush" );

			return plantAllMapper.saveEqmtAlarmAsResultPush(params);
	}
	
	
	
	
	@Override
	public List<PlantStatusVo> retrieveAlarmCntMonth(HashMap<String, Object> params) {

		LOGGER.info( "retrieveAlarmCntMonth" );

		return plantAllMapper.retrieveAlarmCntMonth(params);
	}
	
	@Override
	public List<PlantAlarmListVo> retrievePlantAlarmList(HashMap<String, Object> params) {

		LOGGER.info( "retrievePlantAlarmList" );

		return plantAllMapper.retrievePlantAlarmList(params);
	}

	@Override
	public List <HashMap<String, String>> retrievePlantAlarmDtlList(HashMap<String, Object> params) {
		
		LOGGER.info( "retrievePlantAlarmListDtl" );

		return plantAllMapper.retrievePlantAlarmDtlList(params);
	}
	
	@Override
	public List<PlantStatusListVo> retrievePlantSearch(HashMap<String, Object> params) {

		LOGGER.info( "retrievePlantSearch" );

		return plantAllMapper.retrievePlantSearch(params);
	}

	@Override
	public List<HashMap<String, String>> retrievePlantMonthList(HashMap<String, Object> params) {

		LOGGER.info( "retrievePlantMonthList" );

		return plantAllMapper.retrievePlantMonthList(params);
	}

	@Override
	public List<HashMap<String, String>> retrievePlantDailyList(HashMap<String, Object> params) {

		LOGGER.info( "retrievePlantDailyList" );

		return plantAllMapper.retrievePlantDailyList(params);
	}

	@Override
	public List<HashMap<String, String>> retrievePlantStatusChrt(HashMap<String, Object> params) {

		LOGGER.info( "retrievePlantStatusChrt" );

		return plantAllMapper.retrievePlantStatusChrt(params);
	}


	@Override
	public List<PlantStatusVo> retrieveOperateUse(HashMap<String, Object> params) {
		// TODO Auto-generated method stub
		return null;
	}
}
