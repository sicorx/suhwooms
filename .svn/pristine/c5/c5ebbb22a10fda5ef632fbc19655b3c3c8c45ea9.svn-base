package rems.management.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import rems.management.model.GridBleVo;
import rems.management.persistence.BleMgntMapper;

@Service
public class BleMgntSvcImpl implements BleMgntSvc {

	@Autowired
	private BleMgntMapper mapper;
	
	private static final Logger LOGGER = LoggerFactory.getLogger( BleMgntSvcImpl.class );
	
	@Override
	public List<GridBleVo> retrieveBleMgnt(HashMap<String, Object> params) {
		LOGGER.info( "retrieveBleMgnt : " + params );
		
		return mapper.retrieveBleMgnt(params);
	}
	
	@Override
	public List<GridBleVo> retrieveBleMgntElecInfo(HashMap<String, Object> params) {
		LOGGER.info( "retrieveBleMgntElecInfo : " + params );
		
		return mapper.retrieveBleMgntElecInfo(params);	
	}
	
	
	@Override
	public List<GridBleVo> retrieveBleMgntSensorInfo(HashMap<String, Object> params) {
		LOGGER.info( "retrieveBleMgntSensorInfo : " + params );
		
		return mapper.retrieveBleMgntSensorInfo(params);
	}
	
	@Override
	public List<GridBleVo> retrieveBleMgntNetworkInfo(HashMap<String, Object> params) {
		LOGGER.info( "retrieveBleMgntNetworkInfo : " + params );
		
		return mapper.retrieveBleMgntNetworkInfo(params);
	}
	
	@Override
	public List<GridBleVo> retrieveBleMgntNetworkIp(HashMap<String, Object> params) {
		LOGGER.info( "retrieveBleMgntNetworkIp : " + params );
		
		return mapper.retrieveBleMgntNetworkIp(params);
	}
	
	
	@Override
	public List<GridBleVo> retrieveBleMgntSignInfo(HashMap<String, Object> params) {
		LOGGER.info( "retrieveBleMgntSignInfo : " + params );
		
		return mapper.retrieveBleMgntSignInfo(params);
	}
	
	@Override
	public int saveBleCheck(HashMap<String, Object> params) {
		LOGGER.info( "saveBleCheck : " + params );
		
		return mapper.saveBleCheck(params);
	}
	
	@Override
	public GridBleVo retrieveCloseCntMst(HashMap<String, Object> params) {
		LOGGER.info( "retrieveCloseCntMst : " + params );
		
		return mapper.retrieveCloseCntMst(params);
	}
	
	@Override
	public int saveCloseDataDetail(HashMap<String, Object> params) {
		LOGGER.info( "saveCloseDataDetail : " + params );
		
		return mapper.saveCloseDataDetail(params);
	}
	
	@Override
	public int saveCloseData(HashMap<String, Object> params) {
		LOGGER.info( "saveCloseData : " + params );
		
		return mapper.saveCloseData(params);
	}
	
	@Override
	public int saveCloseBaseDetail(HashMap<String, Object> params) {
		LOGGER.info( "saveCloseBaseDetail : " + params );
		
		return mapper.saveCloseBaseDetail(params);
	}
	
	@Override
	public int saveCloseBase(HashMap<String, Object> params) {
		LOGGER.info( "saveCloseBase : " + params );
		
		return mapper.saveCloseBase(params);
	}
	
	@Override
	public List<GridBleVo> retrieveRealData(HashMap<String, Object> params) {
		LOGGER.info( "retrieveRealData : " + params );
		
		return mapper.retrieveRealData(params);
	}
}
