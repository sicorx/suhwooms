package rems.eqmt.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import rems.common.model.SelectVo;
import rems.eqmt.model.GridInverterStatusVo;
import rems.eqmt.persistence.EqmtInverterStatusMapper;

@Service
public class EqmtInverterStatusSvcImpl implements EqmtInverterStatusSvc {

	@Autowired 
	private EqmtInverterStatusMapper eqmtInverterStatusMapper;
	
	private static final Logger LOGGER = LoggerFactory.getLogger( EqmtInverterStatusSvcImpl.class );
	
	@Override
	public List<SelectVo> retrieveInverterList(HashMap<String, Object> params) {
		LOGGER.info( "retrieveInverterList : " + params );
		
		return eqmtInverterStatusMapper.retrieveInverterList(params);
	}
	
	@Override
	public List<GridInverterStatusVo> retrieveInverterStatusList(HashMap<String, Object> params) {
		LOGGER.info( "retrieveInverterStatusList : " + params );
		
		return eqmtInverterStatusMapper.retrieveInverterStatusList(params);
	}
	 
	@Override
	public GridInverterStatusVo retrieveInverterStatusDtl(HashMap<String, Object> params) {
		LOGGER.info( "retrieveInverterStatusDtl : " + params );
		
		return eqmtInverterStatusMapper.retrieveInverterStatusDtl(params);
	}
	
	@Override
	public List<HashMap<String, String>> retrieveInverterTempChartData(HashMap<String, Object> params) {
		LOGGER.info( "retrieveInverterTempChartData : " + params );
		
		return eqmtInverterStatusMapper.retrieveInverterTempChartData(params);
	}
	
}
