package rems.system.persistence;

import java.util.HashMap;

public interface ExcelUtilMapper {

	public int insertStrInfoDB(HashMap<String, Object> params);
	public int insertGwInfoDB(HashMap<String, Object> params);
	public int insertRemsPartCntDB(HashMap<String, Object> params);
	public int insertStrConfDB(HashMap<String, Object> params);
	public int insertTemonInfoDB(HashMap<String, Object> params);
	public int insertInvInfoDB(HashMap<String, Object> params);	
	
	public int insertElectricEntDB(HashMap<String, Object> params );
	
	public String getStrCdValue(HashMap<String, Object> params);	
	public String getGwIdValue(HashMap<String, Object> params);
	
	public void deleteInfoDB(HashMap<String, Object> params);
	
}
