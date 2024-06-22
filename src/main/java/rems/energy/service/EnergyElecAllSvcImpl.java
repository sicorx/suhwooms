package rems.energy.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import rems.common.persistence.CommonMapper;
import rems.energy.model.EpAlarmResultListVo;
import rems.energy.model.EpDashBoardVo;
import rems.energy.model.EpPeakStatusVo;
import rems.energy.model.EpPredictVo;
import rems.energy.model.EpStatusVo;
import rems.energy.model.EpUsedAreaChrtVo;
import rems.energy.model.EpUsedAreaListVo;
import rems.energy.model.EpUsedAreaVo;
import rems.energy.model.EpUsedListVo;
import rems.energy.persistence.EnergyElecAllMapper;
import rems.system.model.ComCodeVo;
import rems.system.model.GridStoreMgntVo;
import rems.system.model.UserVo;

@Service
public class EnergyElecAllSvcImpl implements EnergyElecAllSvc {

	@Autowired
	private EnergyElecAllMapper mapper;
	
	@Autowired
	private CommonMapper commonMapper;	
		
	@Override
	public EpStatusVo retrieveEpStatus(UserVo userVo) {
		return mapper.retrieveEpStatus(userVo);
	}
	
	
	@Override
	public EpStatusVo retrieveEpTotalStatus(HashMap<String,Object> params) {
		return mapper.retrieveEpTotalStatus(params);
	}
	
	@Override
	public List<EpStatusVo> retrieveEpMonthStatus(HashMap<String, Object> params) {
		return mapper.retrieveEpMonthStatus(params);
	}
	
	@Override
	public List<EpStatusVo> retrieveEpDayStatus(HashMap<String, Object> params) {
		return mapper.retrieveEpDayStatus(params);
	}

	@Override
	public EpPredictVo retrievePredictUse(UserVo userVo) {
		return mapper.retrievePredictUse(userVo);
	}

	@Override
	public List<EpStatusVo> retrieveUseMonth(UserVo userVo) {
		return mapper.retrieveUseMonth(userVo); 
	}
	
	@Override
	public List<EpStatusVo> retrieveGhouseGasMonth(UserVo userVo) {
		return mapper.retrieveGhouseGasMonth(userVo); 
	}
	
	@Transactional
	@Override
	public List<EpPeakStatusVo> retrievePeakMonthStatus(HashMap<String,Object> param) {
		
		List<EpPeakStatusVo> list = mapper.retrievePeakMonthStatus(param);
		
		int cnt = commonMapper.selectTotalCnt();
		if( cnt != 0 )		
			list.get(0).setTotal(String.valueOf(cnt));			
		
		return list;				
	}
	
	@Override
	public List<HashMap<String, Object>> retrieveExcelPeakMonthStatusList(HashMap<String,Object> param) {
		
		List<HashMap<String, Object>> list = mapper.retrieveExcelPeakMonthStatusList(param);
		
		return list;				
	}
	
	@Override
	public List<EpPeakStatusVo> retrievePeakMonth(HashMap<String,Object> param) {
		return mapper.retrievePeakMonth(param);
	}
	
	
	
	@Override
	public EpUsedAreaVo retrieveUsedArea(UserVo userVo) {
		return mapper.retrieveUsedArea(userVo);
	}

	@Override
	public EpUsedAreaChrtVo retrieveUsedAreaChrt(UserVo userVo) {
		return mapper.retrieveUsedAreaChrt(userVo);
	}
	
	@Override
	public List<EpUsedAreaListVo> retrieveUsedAreaList(HashMap<String, String> param) {
		return mapper.retrieveUsedAreaList(param);
	}
	
	@Override
	public List<EpUsedListVo> retrieveUsedList(UserVo userVo) {
		return mapper.retrieveUsedList(userVo);
	}
	
	@Override
	public List<EpUsedListVo> retrieveUsedDailyList(UserVo userVo) {
		return mapper.retrieveUsedDailyList(userVo);
	}
	
	@Override
	public List<HashMap<String, String>> retrieveMainUseHourlyChrt(UserVo userVo) {
		return mapper.retrieveMainUseHourlyChrt(userVo);
	}
	
	@Override
	public List<ComCodeVo> retrieveComCodeList(ComCodeVo params) {		
		return mapper.retrieveComCodeList( params );
	}	
	
	@Override
	public List<EpAlarmResultListVo> retrieveAlarmResultList(HashMap<String, Object> param) {		
		return mapper.retrieveAlarmResultList( param );
	}
	
	
	@Override
	public EpAlarmResultListVo retrieveAlarmResultCntList(HashMap<String, Object> param) {		
		return mapper.retrieveAlarmResultCntList( param );
	}
	
	@Override
	public EpDashBoardVo retrieveDashBoardWatageStatus(HashMap<String, Object> param) {		
		return mapper.retrieveDashBoardWatageStatus( param );
	}
	
}
