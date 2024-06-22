package rems.system.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import rems.system.model.ExcelDataVo;

public interface ExcelUtilSvc {

	public List<ExcelDataVo> insertArticleInBoard(File destFile);
	
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
