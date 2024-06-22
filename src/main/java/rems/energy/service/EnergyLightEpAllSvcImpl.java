package rems.energy.service;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import rems.energy.model.EpLightStatusVo;
import rems.energy.model.EpLightUsedListVo;
import rems.energy.model.EpWeatherStatusListVo;
import rems.energy.persistence.EnergyLightAllMapper;
import rems.system.model.UserVo;

@Service
public class EnergyLightEpAllSvcImpl implements EnergyLightEpAllSvc {

	@Autowired
	private EnergyLightAllMapper energyLightAllMapper;
	
	private static final Logger LOGGER = LoggerFactory.getLogger( EnergyLightEpAllSvcImpl.class );
	
	@Override
	public EpLightStatusVo retrieveEpLightStatus(UserVo userVo) {
		
		LOGGER.info( "retrieveTotal : " + userVo );
		
		return energyLightAllMapper.retrieveEpLightStatus(userVo);
	}

	@Override
	public List<EpLightStatusVo> retrieveUseMonthLight(UserVo userVo) {
		// TODO Auto-generated method stub
		return energyLightAllMapper.retrieveUseMonthLight(userVo);
	}

	@Override
	public ArrayList<EpWeatherStatusListVo> retrieveWeatherStatusList(UserVo userVo) {
		// TODO Auto-generated method stub
		return energyLightAllMapper.retrieveWeatherStatusList(userVo);
	}
	
	@Override
	public List<EpLightUsedListVo> retrieveLightUsedList(UserVo userVo) {
		// TODO Auto-generated method stub
		return energyLightAllMapper.retrieveLightUsedList(userVo);
	}

	@Override
	public List<EpLightUsedListVo> retrieveLightUsedDailyList(UserVo userVo) {
		// TODO Auto-generated method stub
		return energyLightAllMapper.retrieveLightUsedDailyList(userVo);
	}
	
}
