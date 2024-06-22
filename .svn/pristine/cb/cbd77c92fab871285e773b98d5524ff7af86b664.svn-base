package rems.eqmt.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import rems.eqmt.model.GridInverterStatusVo;
import rems.eqmt.persistence.EqmtInverterControlMapper;

@Service
public class EqmtInverterControlSvcImpl implements EqmtInverterControlSvc {

	@Autowired
	private EqmtInverterControlMapper eqmtInverterControlMapper;
	
	private static final Logger LOGGER = LoggerFactory.getLogger( EqmtInverterControlSvc.class );
	
	@Override
	public List<GridInverterStatusVo> retrieveInverterControlList(HashMap<String, Object> params) {
		LOGGER.info( "retrieveInverterControlList : " + params );
		
		return eqmtInverterControlMapper.retrieveInverterControlList(params);
	}

	@Override
	public GridInverterStatusVo retrieveInverterControlDtl(HashMap<String, Object> params) {
		LOGGER.info( "retrieveInverterControlDtl : " + params );
		
		return eqmtInverterControlMapper.retrieveInverterControlDtl(params);
	}
	
	@Override
	public int retrieveGwId(String param) {
		LOGGER.info( "retrieveGwId : " + param );
		
		return eqmtInverterControlMapper.retrieveGwId(param);
	}
}
