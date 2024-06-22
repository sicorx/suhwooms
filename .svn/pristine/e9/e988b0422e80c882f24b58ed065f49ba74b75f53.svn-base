package rems.eqmt.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import rems.common.model.SelectVo;
import rems.eqmt.model.GridStoreFcltyAlrmHisVo;
import rems.eqmt.persistence.EqmtAlarmHistoryMapper;

@Service
public class EqmtAlarmHistorySvcImpl implements EqmtAlarmHistorySvc {

	@Autowired
	private EqmtAlarmHistoryMapper mapper;
	
	private static final Logger LOGGER = LoggerFactory.getLogger( EqmtAlarmHistorySvcImpl.class );
	
	@Override
	public List<GridStoreFcltyAlrmHisVo> retrieveStoreFcltyAlrmHis(HashMap<String, Object> params) {
		LOGGER.info( "retrieveStoreFcltyAlrmHis : " + params );
		
		return mapper.retrieveStoreFcltyAlrmHis(params);
	}
	
	
	@Override
	public List<SelectVo> retrieveStrFcltyAlrmPortNo(HashMap<String, Object> params) {
		LOGGER.info( "retrieveStrFcltyAlrmPortNo : " + params );
		
		return mapper.retrieveStrFcltyAlrmPortNo(params);
	}
}
