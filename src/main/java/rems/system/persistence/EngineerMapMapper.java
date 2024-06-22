package rems.system.persistence;

import java.util.HashMap;
import java.util.List;

import rems.system.model.GridMaintainEngineerMgntVo;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.persistence
 * @Class Name : EngineerMapMapper.java
 * @Description : 매장할당현황조회 서비스 맵퍼
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 3. 6.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 3. 6. 오후 4:03:56
 * @version 2.0
 * 
 */
public interface EngineerMapMapper {

	// 매장할당현황조회 목록
	List<GridMaintainEngineerMgntVo> retrieveEngineerStrList(HashMap<String, Object> params);
	//엑셀
	public List<HashMap<String, Object>> retrieveExcelEngineerStrList(HashMap<String, Object> params);
}
