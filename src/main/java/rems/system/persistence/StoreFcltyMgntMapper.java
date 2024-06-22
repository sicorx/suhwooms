package rems.system.persistence;

import java.util.HashMap;
import java.util.List;

import rems.system.model.GridStoreFcltyMgntVo;

public interface StoreFcltyMgntMapper {

	public List<GridStoreFcltyMgntVo> retrieveStoreFcltyMgnt(HashMap<String, Object> params);
	
	public GridStoreFcltyMgntVo retrieveStoreFcltyMgntDtl(HashMap<String, Object> params);
	
	public List<GridStoreFcltyMgntVo> retrieveStoreFcltyMgntDtlList(HashMap<String, Object> params);
	
	public int saveStoreFcltyMgnt(GridStoreFcltyMgntVo params);
	
	public int saveStoreFcltyMgntList(GridStoreFcltyMgntVo params);
	
	public int saveStoreFcltyMgnt_init(HashMap<String, Object> params );
	
	public int delStoreFcltyMgnt(HashMap<String, Object> params );
	
}
