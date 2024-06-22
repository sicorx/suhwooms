package rems.energy.persistence;

import java.util.HashMap;
import java.util.List;

import rems.common.model.AreaVo;
import rems.common.model.SelectVo;
import rems.energy.model.SemsVo;

public interface EnergySemsMapper {

	List<SemsVo> retrieveSems(HashMap<String, Object> params);

	List<SelectVo> retrieveVendorList(HashMap<String, Object> params);

	// SENS 할당현황 excel 다운로드
	public List<HashMap<String, Object>> retrieveExcelSems(HashMap<String, Object> params);
}
