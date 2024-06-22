package rems.system.persistence;

import java.util.HashMap;
import java.util.List;

import rems.system.model.GridMaintainEngineerMgntVo;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.persistence
 * @Class Name : EngineerStrMapMapper.java
 * @Description : 엔지니어매장할당 서비스 맵퍼
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 3. 2.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 3. 2. 오후 6:07:13
 * @version 2.0
 * 
 */
public interface EngineerStrMapMapper {

	// 엔지니어 목록
	List<GridMaintainEngineerMgntVo> searchVendorEngineerList(HashMap<String, Object> params);

	// 엔지니어 할당된 매장 목록
	List<GridMaintainEngineerMgntVo> searchEngineerStrList(HashMap<String, Object> params);

	// 할당매장선택 목록
	List<GridMaintainEngineerMgntVo> searchStrEngineerList(HashMap<String, Object> params);
	
	// 할당된 매장 삭제
	int deleteStrMappingEngineer(HashMap<String, Object> params);
		
	// 할당된 매장 등록
	int insertStrMappingEngineer(HashMap<String, Object> params);
	
}
