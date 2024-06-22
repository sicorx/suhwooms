package rems.energy.service;

import java.util.HashMap;
import java.util.List;

import rems.energy.model.AnhAreaDistListVo;
import rems.energy.model.AnhAreaDistVo;
import rems.energy.model.AnhAreaListVo;
import rems.energy.model.AnhStatusVo;
import rems.energy.model.AnhTempVo;
import rems.energy.model.AnhUsedAreaChrtVo;
import rems.system.model.ComCodeVo;
import rems.system.model.UserVo;

public interface EnergyAnhElecSvc {

	public AnhStatusVo retrieveAnhStatus(UserVo userVo);
	
	public List<AnhStatusVo> retrieveEnergyUsePerMonth(UserVo userVo);
	
	public AnhTempVo retrieveAnhTemp(UserVo userVo);
	
	public AnhAreaDistVo retrieveAnhAreaDist(UserVo userVo);
	
	public AnhUsedAreaChrtVo retrieveUsedAreaChrt(UserVo userVo);
	
	public List<AnhAreaDistListVo> retrieveAnhAreaDistList(HashMap<String, String> param);
	
	public List<AnhAreaListVo> retrieveAnhDistList(HashMap<String, String> param);
	
	public List<AnhAreaListVo> retrieveUsedDailyDistList(UserVo userVo);
	
	public List<HashMap<String, String>> retrieveUsedHourlyChrt(UserVo userVo);
	
	public List<ComCodeVo> retrieveComCodeList(ComCodeVo params);
	
}