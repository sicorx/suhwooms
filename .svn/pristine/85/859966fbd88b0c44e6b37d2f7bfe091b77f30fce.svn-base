package rems.system.service;

import java.util.HashMap;
import java.util.List;

import rems.common.model.SelectVo;
import rems.system.model.GridUserMgntVo;

public interface UserMgntSvc {
	
	public List<GridUserMgntVo> retrieveRemsUserList(HashMap<String, Object> params);
	
	public GridUserMgntVo retrieveRemsUserMgntDtl(HashMap<String, Object> params);
	
	public boolean checkUserId(String params);

	public boolean saveRemsUserMgnt(GridUserMgntVo params);
	
	public boolean deleteRemsUserMgnt(HashMap<String, Object> params);
	public boolean deleteRemsUserAuthMgnt(HashMap<String, Object> params);
	
	public List<SelectVo> retrieveAuthHList(String params);
	
	public List<SelectVo> retrieveAuthMList(String params);
	
	public List<SelectVo> retrieveAuthSList(String params);
	
	public List<SelectVo> retrieveAuthTList(String params);
	
	public List<SelectVo> retrieveVendorList(HashMap<String, Object> params);
	
	public List<SelectVo> retrieveElectricEntList(HashMap<String, Object> params);
	
}
