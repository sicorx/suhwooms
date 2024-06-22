package rems.energy.service;

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

public interface EnergyElecAllSvc {

	public EpStatusVo retrieveEpStatus(UserVo userVo);
		
	// 전체 매장 전력사용현황
	public EpStatusVo retrieveEpTotalStatus(HashMap<String,Object> params);		
		
	// 전체 월별 전력량
	public List<EpStatusVo> retrieveEpMonthStatus(HashMap<String, Object> params);
	
	// 전체 일별 전력량
	public List<EpStatusVo> retrieveEpDayStatus(HashMap<String,Object> params);	
	
	public EpPredictVo retrievePredictUse(UserVo userVo);
	
	public List<EpStatusVo> retrieveUseMonth(UserVo userVo);
	
	// 온실 가스 월별 사용량
	public List<EpStatusVo> retrieveGhouseGasMonth(UserVo userVo);
	
	// 피크 제어 매장
	public List<EpPeakStatusVo> retrievePeakMonthStatus(HashMap<String,Object> params);
	
	public List<HashMap<String, Object>> retrieveExcelPeakMonthStatusList(HashMap<String,Object> params);
	
	// 피크제어매장현황
	public List<EpPeakStatusVo> retrievePeakMonth(HashMap<String,Object> params);
	
	public EpUsedAreaVo retrieveUsedArea(UserVo userVo);
	
	public EpUsedAreaChrtVo retrieveUsedAreaChrt(UserVo userVo);
	
	public List<EpUsedAreaListVo> retrieveUsedAreaList(HashMap<String, String> param);
	
	public List<EpUsedListVo> retrieveUsedList(UserVo userVo);
	
	public List<EpUsedListVo> retrieveUsedDailyList(UserVo userVo);
	
	public List<HashMap<String, String>> retrieveMainUseHourlyChrt(UserVo userVo);
	
	public List<ComCodeVo> retrieveComCodeList(ComCodeVo params);
	
	
	public List<EpAlarmResultListVo> retrieveAlarmResultList(HashMap<String, Object> param);
	
	
	public EpAlarmResultListVo retrieveAlarmResultCntList(HashMap<String, Object> param);

	public EpDashBoardVo retrieveDashBoardWatageStatus(HashMap<String, Object> param);
}
