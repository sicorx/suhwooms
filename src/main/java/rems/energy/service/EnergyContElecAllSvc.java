package rems.energy.service;

import java.util.HashMap;
import java.util.List;

import rems.energy.model.EpContDemandListVo;
import rems.energy.model.EpContExcessChrtVo;
import rems.energy.model.EpContOverStoreListVo;
import rems.energy.model.EpContOverStoreVo;
import rems.system.model.ComCodeVo;

public interface EnergyContElecAllSvc {
	
	//계약전력 대비 초과사용 발생 매장현황
	public List <EpContOverStoreVo> retrieveEpContList(HashMap<String, Object> params);

	//면적당 계약전력 분포
	public EpContExcessChrtVo retrieveEpContChrt(HashMap<String, Object> params);

	//면적당 계약전력 요약
	public EpContOverStoreVo retrieveEpContOverStore(HashMap<String, Object> params);
	
	//면적당 계약전력 목록
	public List <EpContOverStoreListVo> retrieveEpContOverStoreList(HashMap<String, Object> params);

	//최대 수요전력
	public List <EpContDemandListVo> retrieveMonthDemandList(HashMap<String, Object> params);
	
	public List<HashMap<String, Object>> retrieveExcelMonthDemandList(HashMap<String, Object> params);
	
	public List <EpContDemandListVo> retrieveDailyDemandList(HashMap<String, Object> params);
	
	public List <EpContDemandListVo> retrieveMonthDemandChart(HashMap<String, Object> params);
	
	public List<ComCodeVo> retrieveComCodeList(ComCodeVo params);

}
