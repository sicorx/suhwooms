package rems.system.persistence;

import java.util.HashMap;
import java.util.List;

import rems.common.model.SelectVo;
import rems.system.model.GridCompanyMgntVo;

public interface CompanyMgntMapper {

	public List<GridCompanyMgntVo> retrieveRemsCompanyList(HashMap<String, Object> params);
	
	public GridCompanyMgntVo retrieveRemsCompanyMgntDtl(HashMap<String, Object> params);
	
	public int checkCompanyCd(String params);
	
	public int checkCompanyStrCd(String params);
	
	public int saveRemsCompanyMgnt(GridCompanyMgntVo params);
	
	public int deleteRemsCompanyMgnt(GridCompanyMgntVo params);
	
	public List<SelectVo> retrieveCountryList();
}
