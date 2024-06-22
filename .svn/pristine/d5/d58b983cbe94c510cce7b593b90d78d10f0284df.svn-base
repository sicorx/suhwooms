package rems.system.persistence;

import java.util.HashMap;
import java.util.List;

import rems.common.model.SelectVo;
import rems.system.model.GridUserMgntVo;

public interface UserMgntMapper {

	public List<GridUserMgntVo> retrieveRemsUserList(HashMap<String, Object> params);
	
	public GridUserMgntVo retrieveRemsUserMgntDtl(HashMap<String, Object> params);
	
	public int checkUserId(String params);
	
	public int saveRemsUserMgnt(GridUserMgntVo params);
	
	public int saveRemsHUserMgnt(GridUserMgntVo params);
	
	public int saveRemsMUserMgnt(GridUserMgntVo params);
	
	public int saveRemsTUserMgnt(GridUserMgntVo params);
	
	public int saveRemsSUserMgnt(GridUserMgntVo params);
	
	public int saveRemsUserAuth(GridUserMgntVo params);
	
	public int deleteRemsUserMgnt(HashMap<String, Object> params);
	
	public int deleteRemsUserAuthMgnt(HashMap<String, Object> params);	
	
	public int saveRemsStoreMapMst(GridUserMgntVo params);
	
	public int deleteRemsStoreMapMst(GridUserMgntVo params);
	
	public List<SelectVo> retrieveAuthHList(String params);
	
	public List<SelectVo> retrieveAuthMList(String params);
	
	public List<SelectVo> retrieveAuthSList(String params);
	
	public List<SelectVo> retrieveAuthTList(String params);
	
	public List<SelectVo> retrieveVendorList(HashMap<String, Object> params);
	
	public List<SelectVo> retrieveElectricEntList(HashMap<String, Object> params);

	public int saveRemsUserStrMap(GridUserMgntVo params);
	
	
}
