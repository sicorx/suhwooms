package rems.system.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import rems.common.model.SelectVo;
import rems.system.model.GridOrgMgntVo;
import rems.system.model.GridStoreMgntVo;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.persistence
 * @Class Name : OrgMgntMapper.java
 * @Description : 조직 서비스 맵퍼
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 2. 9.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 2. 9. 오후 3:06:38
 * @version 2.0
 * 
 */
public interface OrgMgntMapper {

	// 조직 목록
	List<Map<String, Object>> retrieveOrgList(HashMap<String, Object> params);
	
	// 조직 삭제
	void deleteOrgBatch(HashMap<String, Object> params);

	// 매장 삭제(삭제된 조직코드를 매장에서 null)
	void updateOrgCdNullStrMgnt(HashMap<String, Object> params);
		
	// 조직 수정
	void updateOrgBatch(HashMap<String, Object> params);
	
	// 조직 등록
	void insertOrgBatch(HashMap<String, Object> params);
	
	// 매장 목록
	List<GridStoreMgntVo> retrieveStrList(HashMap<String, Object> params);
	
	// 매장에 조직코드 저장
	int updateStrMgntOrgCd(HashMap<String, Object> params);
		
	// 매장 삭제(매장에서 조직코드 null)
	int updateStrMgntOrgCdNull(HashMap<String, Object> params);
	
	
	
	List<SelectVo> retrieveDepth1CdList(HashMap<String, Object> params);

	List<GridOrgMgntVo> searchOrgList(HashMap<String, Object> params);

	String getOrgCdCnt(GridOrgMgntVo gomVo);

	int retrieveSaveOrgMgnt(GridOrgMgntVo gomVo);

	

	GridOrgMgntVo searchOrgCd(HashMap<String, Object> params);

	int deleteOrgMgnt(HashMap<String, Object> params);
}
