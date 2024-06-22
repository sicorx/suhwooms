package rems.system.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import rems.system.model.GridDimmTimePolicyMgntVo;
import rems.system.model.GridDimmWeatherPolicyMgntVo;
import rems.system.persistence.DimmPolicyMgntMapper;

@Service
public class DimmPolicyMgntSvcImpl implements DimmPolicyMgntSvc {

	@Autowired
	private DimmPolicyMgntMapper dimmPolicyMgntMapper;
	
	private static final Logger LOGGER = LoggerFactory.getLogger( DimmPolicyMgntSvcImpl.class );
	
	
	@Override
	public List<GridDimmTimePolicyMgntVo> retrieveDimmTimePolicyList(HashMap<String, Object> params) {
		LOGGER.info( "retrieveDimmTimePolicyList : " + params );
		
		return dimmPolicyMgntMapper.retrieveDimmTimePolicyList(params);
	}
	
	@Override
	public List<GridDimmWeatherPolicyMgntVo> retrieveDimmWeatherPolicyList(HashMap<String, Object> params) {
		LOGGER.info( "retrieveDimmWeatherPolicyList : " + params );
		
		return dimmPolicyMgntMapper.retrieveDimmWeatherPolicyList(params);
	}

	@Override
	public boolean saveDimmTimePolicyMgnt(GridDimmTimePolicyMgntVo params) {
		LOGGER.info( "GridDimmTimePolicyMgntList : " + params );
		
		boolean rslt   = true;
		int updateRslt = 0;

		String TimeSunDimmList = params.getTimeSunDimmList();
		String TimeunSunDimmList = params.getTimeUnSunDimmList();
		
		String[] splitSunDimmList = TimeSunDimmList.split(":");
		String[] splitunSunDimmList = TimeunSunDimmList.split(":");
		
		for(int i = 0 ; i < 5 ; i++ ){
			
			rslt   = true;
			
			HashMap<String,Object> map = new HashMap<String,Object>();
			
			map.put( "dim_cd", i);
			map.put( "sundimmtime", splitSunDimmList[i] );
			map.put( "unsundimmtime", splitunSunDimmList[i] );
			map.put( "companyCd",  params.getCompanyCd() );
			map.put( "regiId", params.getRegiId() );
			map.put( "regiDttm", params.getRegiIdDttm() );
			
			updateRslt = dimmPolicyMgntMapper.saveDimmTimePolicyMgnt(map);
			
				if( updateRslt == 0 ){
					rslt = false; 
					break;
					}
		}
		return rslt;
	}
	
	@Override
	public boolean saveDimmWeatherPolicyMgnt(GridDimmWeatherPolicyMgntVo params) {
		
		LOGGER.info( "GridDimmWeatherPolicyMgntList : " + params );
		
		boolean rslt   = true;
		
		int updateRslt = 0;
		
		String sunDayDimmList 		= params.getSunDayDimmList();
		String unSunDayDimmList 	= params.getUnSunDayDimmList();
		String sunNightDimmList 	= params.getSunNightDimmList();
		String unSunNightDimmList 	= params.getUnSunNightDimmList();
		String weatherList 			= params.getWeatherList();
						
		String[] splitSunDayDimmList	 		= sunDayDimmList.split(":");
		String[] splitUnUnSunDayDimmList		= unSunDayDimmList.split(":");
		String[] splitSunNightDimmList 			= sunNightDimmList.split(":");
		String[] splitUnSunNightDimmList 		= unSunNightDimmList.split(":");
		String[] splitweatherList 				= weatherList.split(":");
				
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		for(int i = 0 ; i < 12 ; i++ ){
			
			map.put( "weatherCd", i);
			map.put( "companyCd",  		params.getCompanyCd() );
			map.put( "regiId", 			params.getRegiId() );
			map.put( "regiDttm", 		params.getRegiIdDttm() );
			map.put( "finalModId", 		params.getFinalId() );
			map.put( "finalModDttm", 	params.getFinalModDttm() );
			
			map.put( "weatherdesc",  	splitweatherList[i] );
			map.put( "sundaydimm", 		splitSunDayDimmList[i] );
			map.put( "unsundaydimm", 	splitUnUnSunDayDimmList[i] );
			map.put( "sunnightdimm", 	splitSunNightDimmList[i] );
			map.put( "unsunnightdimm", 	splitUnSunNightDimmList[i] );
			
			updateRslt = dimmPolicyMgntMapper.saveDimmWeatherPolicyMgnt(map);
			
			if( updateRslt == 0 ){
				break;
			}
			
		}
		return rslt;
	}
}
