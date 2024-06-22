package rems.energy.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import rems.common.persistence.CommonMapper;
import rems.energy.model.EpContDemandListVo;
import rems.energy.model.EpContExcessChrtVo;
import rems.energy.model.EpContOverStoreListVo;
import rems.energy.model.EpContOverStoreVo;
import rems.energy.persistence.EnergyContElecAllMapper;
import rems.system.model.ComCodeVo;

@Service
public class EnergyContElecAllSvcImpl implements EnergyContElecAllSvc {

	@Autowired
	private EnergyContElecAllMapper energyContElecAllMapper;
	
	@Autowired
	private CommonMapper commonMapper;
	
	private static final Logger LOGGER = LoggerFactory.getLogger( EnergyElecAllSvcImpl.class );
	
	
	@Override
	public List <EpContOverStoreVo> retrieveEpContList(HashMap<String, Object> params) {
		
		LOGGER.info( "retrieveEpContList" );
		
		return energyContElecAllMapper.retrieveEpContList(params);
		
	}
	
	@Override
	public EpContExcessChrtVo retrieveEpContChrt(HashMap<String, Object> params) {
		
		LOGGER.info( "retrieveEpContChrt" );
		
		return energyContElecAllMapper.retrieveEpContChrt(params);
	}

	//면적당 계약전력 요약
	@Override
	public EpContOverStoreVo retrieveEpContOverStore(HashMap<String, Object> params) {
		
		LOGGER.info( "retrieveEpContOverStore" );
		
		return energyContElecAllMapper.retrieveEpContOverStore(params);
	}
	
	@Override
	public List <EpContOverStoreListVo> retrieveEpContOverStoreList(HashMap<String, Object> params) {
		
		LOGGER.info( "retrieveEpContOverStoreList" );
		
		return energyContElecAllMapper.retrieveEpContOverStoreList(params);
	}
	
	@Transactional
	@Override
	public List <EpContDemandListVo> retrieveMonthDemandList(HashMap<String, Object> params) {
		
		LOGGER.info( "retrieveMonthDemandList" );
		
		List<EpContDemandListVo> list = energyContElecAllMapper.retrieveMonthDemandList(params);
		
		int cnt = commonMapper.selectTotalCnt();
		if( cnt != 0 )		
			list.get(0).setTotal(String.valueOf(cnt));				
		
		return list;		
	}
	
	@Override
	public List<HashMap<String, Object>> retrieveExcelMonthDemandList(HashMap<String, Object> params) {
		LOGGER.info( "retrieveExcelMonthDemandList" );
		
		List<HashMap<String, Object>> list = energyContElecAllMapper.retrieveExcelMonthDemandList(params);
		
		return list;		
	}

	@Override
	public List <EpContDemandListVo> retrieveDailyDemandList(HashMap<String, Object> params) {

		LOGGER.info( "retrieveDailyDemandList" );
		
		return energyContElecAllMapper.retrieveDailyDemandList(params);
	}
	
	@Override
	public List <EpContDemandListVo> retrieveMonthDemandChart(HashMap<String, Object> params) {

		LOGGER.info( "retrieveMonthDemandChart" );
		
		return energyContElecAllMapper.retrieveMonthDemandChart(params);
	}
	
	@Override
	public List<ComCodeVo> retrieveComCodeList(ComCodeVo params) {		

		LOGGER.info( "retrieveComCodeList" );
		
		return energyContElecAllMapper.retrieveComCodeList( params );
	}	
}
