package rems.eqmt.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import rems.eqmt.persistence.EqmtCurrentAlarmMapper;

@Service
public class EqmtCurrentAlarmSvcImpl implements EqmtCurrentAlarmSvc {

	@Autowired
	private EqmtCurrentAlarmMapper mapper;
	
	private static final Logger LOGGER = LoggerFactory.getLogger( EqmtCurrentAlarmSvcImpl.class );
	
	@Override
	public Map<String, String> retrieveQueryDate(Map<String, Object> param) {
		
		LOGGER.info( "retrieveQueryDate" );
		
		return mapper.retrieveQueryDate(param);
	}
	
	@Override
	public Map<String, Object> retrieveEquipmentFailure(Map<String, String> param) {
		
		LOGGER.info( "retrieveEquipmentFailure" );
		
		List<Map<String, String>> rslt1 = mapper.retrieveEquipmentFailureDay(param);
		List<Map<String, String>> rslt2 = mapper.retrieveEquipmentFailureWeek(param);
		List<Map<String, String>> rslt3 = mapper.retrieveEquipmentFailureMonth(param);
		
		Map<String, Object> rslt = new HashMap<String, Object>();
		
		rslt.put( "day", rslt1 );
		rslt.put( "week", rslt2 );
		rslt.put( "month", rslt3 );
		
		return rslt;
	}

	@Override
	public List<Map<String, String>> retrieveEquipmentFailureList(Map<String, Object> param) {
		
		LOGGER.info( "retrieveEquipmentFailureList" );
		
		return mapper.retrieveEquipmentFailureList(param);		
	}	
	
	@Override
	public List<Map<String, String>> retrieveLatestTemp(Map<String, String> param) {
		
		LOGGER.info( "retrieveLatestTemp" );
		
		return mapper.retrieveLatestTemp(param);		
	}	
}
