package rems.system.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import rems.common.model.SelectVo;
import rems.system.model.GridOrgMgntVo;
import rems.system.model.GridStoreMgntVo;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.service
 * @Class Name : OrgMgntSvc.java
 * @Description : 조직 서비스 인터페이스
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 2. 9.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 2. 9. 오후 3:04:48
 * @version 2.0
 * 
 */
public interface OrgMgntSvc {
	
	// 조직 목록
	List<Map<String, Object>> retrieveOrgList(HashMap<String, Object> params);
	
	// 조직 저장
	void saveOrgBatch(HashMap<String, Object> insertMap, HashMap<String, Object> updateMap, HashMap<String, Object> deleteMap);
	
	// 매장 목록
	List<GridStoreMgntVo> retrieveStrList(HashMap<String, Object> params);
	
	// 매장에 조직코드 저장
	boolean updateStrMgntOrgCd(HashMap<String, Object> params);
		
	// 매장 삭제(매장에서 조직코드 null)
	boolean updateStrMgntOrgCdNull(HashMap<String, Object> params);
	
	
	
	List<SelectVo> retrieveDepth1CdList(HashMap<String, Object> params);

	List<GridOrgMgntVo> searchOrgList(HashMap<String, Object> params);

	boolean retrieveSaveOrgMgnt(GridOrgMgntVo gomVo);

	

	GridOrgMgntVo searchOrgCd(HashMap<String, Object> params);

	boolean deleteOrgMgnt(HashMap<String, Object> params);

}
