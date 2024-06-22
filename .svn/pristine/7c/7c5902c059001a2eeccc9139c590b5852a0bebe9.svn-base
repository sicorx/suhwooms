package rems.energy.persistence;

import java.util.HashMap;
import java.util.List;

import rems.energy.model.EpAlarmResultListVo;
import rems.energy.model.EpDashBoardVo;
import rems.energy.model.EpPeakStatusVo;
import rems.energy.model.EpPredictVo;
import rems.energy.model.EpStatusVo;
import rems.energy.model.EpUsedAreaChrtVo;
import rems.energy.model.EpUsedAreaListVo;
import rems.energy.model.EpUsedAreaVo;
import rems.energy.model.EpUsedListVo;
import rems.system.model.ComCodeVo;
import rems.system.model.UserVo;

public interface EnergyElecAllMapper {

	public EpStatusVo retrieveEpStatus(UserVo userVo);
	
	public EpStatusVo retrieveEpTotalStatus(HashMap<String, Object> params);	
	
	public List<EpStatusVo> retrieveEpMonthStatus(HashMap<String, Object> params);
	
	public List<EpStatusVo> retrieveEpDayStatus(HashMap<String, Object> params);
	
	public EpPredictVo retrievePredictUse(UserVo userVo);
	
	public List<EpStatusVo> retrieveUseMonth(UserVo userVo);
	
	public List<EpStatusVo> retrieveGhouseGasMonth(UserVo userVo);
	
	public List<EpPeakStatusVo> retrievePeakMonthStatus(HashMap<String,Object> params);
	
	public List<HashMap<String, Object>> retrieveExcelPeakMonthStatusList(HashMap<String,Object> params);
	
	public List<EpPeakStatusVo> retrievePeakMonth(HashMap<String,Object> param);
	
	public EpUsedAreaVo retrieveUsedArea(UserVo userVo);
	
	public EpUsedAreaChrtVo retrieveUsedAreaChrt(UserVo userVo);
	
	public List<EpUsedAreaListVo> retrieveUsedAreaList(HashMap<String, String>	param);
	
	public List<EpUsedListVo> retrieveUsedList(UserVo userVo);
	
	public List<EpUsedListVo> retrieveUsedDailyList(UserVo userVo);
	
	public List<ComCodeVo> retrieveComCodeList(ComCodeVo params);
	
	public List<HashMap<String, String>> retrieveMainUseHourlyChrt(UserVo userVo);	
	
	public List<EpAlarmResultListVo> retrieveAlarmResultList(HashMap<String, Object> param);
	
	public EpAlarmResultListVo retrieveAlarmResultCntList(HashMap<String, Object> param);
	
	public EpDashBoardVo retrieveDashBoardWatageStatus(HashMap<String, Object> param);
}
