package rems.eqmt.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import rems.eqmt.persistence.EqmtLayoutMapper;

@Service
public class EqmtLayoutSvcImpl implements EqmtLayoutSvc {
	
	@Autowired
	private EqmtLayoutMapper mapper;
	
	private static final Logger LOGGER = LoggerFactory.getLogger( EqmtLayoutSvcImpl.class );
	
	//모든 시설물의 현재 온도 및 알람 값 조회
	@Override
	public List<HashMap<String, String>> retrieveEqmtCurTempAlarm(HashMap<String, String> param) {
		
		LOGGER.info( "retrieveEqmtCurTempAlarm" );
		
		return mapper.retrieveEqmtCurTempAlarm(param);
	}
	
	//특정 시설물의 하루 온도 조회
	@Override
	public List<HashMap<String, String>> retrieveEqmtDailyTemp(HashMap<String, String> param) {
		
		LOGGER.info( "retrieveEqmtDailyTemp" );
		
		return mapper.retrieveEqmtDailyTemp(param);
	}
	
	//특정 시설물의 하루 알람 조회
	@Override
	public List<HashMap<String, String>> retrieveEqmtDailyAlarm(HashMap<String, String> param) {
		
		LOGGER.info( "retrieveEqmtDailyAlarm" );
		
		return mapper.retrieveEqmtDailyAlarm(param);
	}
	
	@Override
	public List<HashMap<String, String>> retrieveEqmtTempChrt(HashMap<String, Object> params) {

		LOGGER.info( "retrieveEqmtTempChrt" );

		return mapper.retrieveEqmtTempChrt(params);		
	}
	
	@Override
	public List<HashMap<String, String>> retrieveEqmtAlarmList(HashMap<String, Object> params) {

		LOGGER.info( "retrieveEqmtAlarmList" );

		return mapper.retrieveEqmtAlarmList(params);		
	}	
}
