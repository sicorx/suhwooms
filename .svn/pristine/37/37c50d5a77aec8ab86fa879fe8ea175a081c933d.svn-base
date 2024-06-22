package rems.system.service;

import java.util.HashMap;
import java.util.List;

import rems.system.model.GridMaintainEngineerMgntVo;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.service
 * @Class Name : EngineerStrMapSvc.java
 * @Description : 엔지니어매장할당 서비스 인터페이스
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 3. 2.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 3. 2. 오후 5:59:31
 * @version 2.0
 * 
 */
public interface EngineerStrMapSvc {
	
	// 엔지니어 목록
	List<GridMaintainEngineerMgntVo> searchVendorEngineerList(HashMap<String, Object> params);

	// 엔지니어 할당된 매장 목록	
	List<GridMaintainEngineerMgntVo> searchEngineerStrList(HashMap<String, Object> params);
	
	// 할당매장선택 목록
	List<GridMaintainEngineerMgntVo> searchStrEngineerList(HashMap<String, Object> params);
	
	// 할당된 매장 삭제
	boolean deleteStrMappingEngineer(HashMap<String, Object> params);
	
	// 할당된 매장 등록
	boolean insertStrMappingEngineer(HashMap<String, Object> params);

}
