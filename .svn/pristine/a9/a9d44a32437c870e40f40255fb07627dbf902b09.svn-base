package rems.eqmt.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import rems.eqmt.model.GridStoreInverterVo;
import rems.eqmt.persistence.EqmtInverterMapper;

@Service
public class EqmtInverterSvcImpl implements EqmtInverterSvc {

	@Autowired
	private EqmtInverterMapper storeInverterMapper;
	
	private static final Logger LOGGER = LoggerFactory.getLogger( EqmtInverterSvc.class );
	
	@Override
	public List<GridStoreInverterVo> retrieveStoreInverter(HashMap<String, Object> params) {
		LOGGER.info( "retrieveStoreInverterList : " + params );
		
		return storeInverterMapper.retrieveStoreInverter(params);
	}
	 
}
