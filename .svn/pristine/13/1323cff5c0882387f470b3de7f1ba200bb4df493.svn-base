package rems.eqmt.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import rems.eqmt.model.GridTemonStatusVo;
import rems.eqmt.persistence.EqmtStoreTemonMapper;

@Service
public class EqmtStoreTemonSvcImpl implements EqmtStoreTemonSvc {

	@Autowired
	private EqmtStoreTemonMapper mapper;
	
	private static final Logger LOGGER = LoggerFactory.getLogger( EqmtInverterSvcImpl.class );
	
	@Override
	public List<GridTemonStatusVo> retrieveStoreTemonList(HashMap<String, Object> params) {
		LOGGER.info( "retrieveStoreTemonList : " + params );
		
		return mapper.retrieveStoreTemonList(params);
	}
	 
}
