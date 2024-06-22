package rems.eqmt.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import rems.common.model.SelectVo;
import rems.eqmt.model.GridTemonStatusVo;
import rems.eqmt.persistence.EqmtTemonStatusMapper;

@Service
public class EqmtTemonStatusSvcImpl implements EqmtTemonStatusSvc {

	@Autowired 
	private EqmtTemonStatusMapper mapper;
	
	private static final Logger LOGGER = LoggerFactory.getLogger( EqmtTemonStatusSvcImpl.class );
	
	@Override
	public List<SelectVo> retrieveTemonList(HashMap<String, Object> params) {
		LOGGER.info( "retrieveTemonList : " + params );
		
		return mapper.retrieveTemonList(params);
	}
	
	@Override
	public List<GridTemonStatusVo> retrieveTemonStatusList(HashMap<String, Object> params) {
		LOGGER.info( "retrieveTemonStatusList : " + params );
		
		return mapper.retrieveTemonStatusList(params);
	}
	 
	@Override
	public List<HashMap<String, String>> retrieveTemonTempChartData(HashMap<String, Object> params) {
		LOGGER.info( "retrieveTemonTempChartData : " + params );
		
		return mapper.retrieveTemonTempChartData(params);
	}
	
}
