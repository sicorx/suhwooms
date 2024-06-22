package rems.energy.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import rems.energy.model.AnhAreaDistListVo;
import rems.energy.model.AnhAreaDistVo;
import rems.energy.model.AnhAreaListVo;
import rems.energy.model.AnhStatusVo;
import rems.energy.model.AnhTempVo;
import rems.energy.model.AnhUsedAreaChrtVo;
import rems.energy.persistence.EnergyAnhElecMapper;
import rems.system.model.ComCodeVo;
import rems.system.model.UserVo;

@Service
public class EnergyAnhElecSvcImpl implements EnergyAnhElecSvc {

	@Autowired
	private EnergyAnhElecMapper energyAnhElecMapper;
		
	@Override
	public AnhStatusVo retrieveAnhStatus(UserVo userVo) {
		return energyAnhElecMapper.retrieveAnhStatus(userVo);
	}

	@Override
	public List<AnhStatusVo> retrieveEnergyUsePerMonth(UserVo userVo) {
		return energyAnhElecMapper.retrieveEnergyUsePerMonth(userVo);
	}
	
	@Override
	public AnhTempVo retrieveAnhTemp(UserVo userVo) {
		return energyAnhElecMapper.retrieveAnhTemp(userVo);
	}

	@Override
	public AnhAreaDistVo retrieveAnhAreaDist(UserVo userVo) {
		return energyAnhElecMapper.retrieveAnhAreaDist(userVo);
	}
	
	@Override
	public AnhUsedAreaChrtVo retrieveUsedAreaChrt(UserVo userVo) {
		return energyAnhElecMapper.retrieveUsedAreaChrt(userVo);
	}
	
	@Override
	public List<AnhAreaDistListVo> retrieveAnhAreaDistList(HashMap<String, String> param) {
		return energyAnhElecMapper.retrieveAnhAreaDistList(param);
	}
	
	@Override
	public List<AnhAreaListVo> retrieveAnhDistList(HashMap<String, String> param) {
		return energyAnhElecMapper.retrieveAnhDistList(param);
	}
	
	@Override
	public List<AnhAreaListVo> retrieveUsedDailyDistList(UserVo userVo) {
		return energyAnhElecMapper.retrieveUsedDailyDistList(userVo);
	}

	@Override
	public List<HashMap<String, String>> retrieveUsedHourlyChrt(UserVo userVo) {
		return energyAnhElecMapper.retrieveUsedHourlyChrt(userVo);
	}
	
	@Override
	public List<ComCodeVo> retrieveComCodeList(ComCodeVo params) {		
		return energyAnhElecMapper.retrieveComCodeList( params );
	}		
}