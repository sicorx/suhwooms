package rems.system.service;

import java.util.HashMap;
import java.util.List;

import rems.common.model.SelectVo;
import rems.system.model.GridCompanyMgntVo;

public interface CompanyMgntSvc {
	
	public List<GridCompanyMgntVo> retrieveRemsCompanyList(HashMap<String, Object> params);
	
	public GridCompanyMgntVo retrieveRemsCompanyMgntDtl(HashMap<String, Object> params);
	
	public boolean checkCompanyCd(String params);
	
	public boolean checkCompanyStrCd(String params);

	public boolean saveRemsCompanyMgnt(GridCompanyMgntVo params);
	
	public boolean deleteRemsCompanyMgnt(GridCompanyMgntVo params);
	
	public List<SelectVo> retrieveCountryList();
}
