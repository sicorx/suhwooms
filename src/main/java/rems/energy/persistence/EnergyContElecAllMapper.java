package rems.energy.persistence;

import java.util.HashMap;
import java.util.List;

import rems.energy.model.EpContDemandListVo;
import rems.energy.model.EpContExcessChrtVo;
import rems.energy.model.EpContOverStoreListVo;
import rems.energy.model.EpContOverStoreVo;
import rems.system.model.ComCodeVo;

public interface EnergyContElecAllMapper {

	public EpContOverStoreVo retrieveEpCont(HashMap<String, Object>	params);
	
	public List<EpContOverStoreVo> retrieveEpContList(HashMap<String, Object> params);
	
	public EpContExcessChrtVo retrieveEpContChrt(HashMap<String, Object> params);
	
	public EpContOverStoreVo retrieveEpContOverStore(HashMap<String, Object> params);
	
	public List <EpContOverStoreListVo> retrieveEpContOverStoreList(HashMap<String, Object> params);
	
	public List <EpContDemandListVo> retrieveMonthDemandList(HashMap<String, Object> params);
	
	public List<HashMap<String, Object>> retrieveExcelMonthDemandList(HashMap<String, Object> params);
	
	public List <EpContDemandListVo> retrieveDailyDemandList(HashMap<String, Object> params);
	
	public List <EpContDemandListVo> retrieveMonthDemandChart(HashMap<String, Object> params);

	public List<ComCodeVo> retrieveComCodeList(ComCodeVo params);
}
