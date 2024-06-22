package rems.energy.persistence;

import java.util.ArrayList;
import java.util.List;

import rems.energy.model.EpLightStatusVo;
import rems.energy.model.EpLightUsedListVo;
import rems.energy.model.EpWeatherStatusListVo;
import rems.system.model.UserVo;

public interface EnergyLightAllMapper {

	public EpLightStatusVo retrieveEpLightStatus(UserVo userVo);
	
	public List<EpLightStatusVo> retrieveUseMonthLight(UserVo userVo);
	
	public ArrayList <EpWeatherStatusListVo> retrieveWeatherStatusList(UserVo userVo);

	public List<EpLightUsedListVo> retrieveLightUsedList(UserVo userVo);
	
	public List<EpLightUsedListVo> retrieveLightUsedDailyList(UserVo userVo);
	
}
