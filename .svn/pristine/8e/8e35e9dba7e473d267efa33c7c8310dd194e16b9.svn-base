package rems.system.persistence;

import java.util.HashMap;
import java.util.List;

import rems.system.model.GridMaintainEngineerMgntVo;
import rems.system.model.GridUserMgntVo;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.persistence
 * @Class Name : MaintainEngineerMngtMapper.java
 * @Description : 엔지니어관리 서비스 맵퍼
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 3. 8.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 3. 8. 오후 4:31:07
 * @version 2.0
 * 
 */
public interface MaintainEngineerMngtMapper {
	
	// 엔지니어 목록
	List<GridMaintainEngineerMgntVo> searchMaintainEngineerList(HashMap<String, Object> params);

	// 엔지니어 저장
	int saveEngineerMgnt(GridUserMgntVo gumVo);


	int saveEngineerAuthMgnt(GridUserMgntVo gumVo);

	//엑셀다운로드
	public List<HashMap<String, Object>> downloadMaintainEngineerListrExcel(HashMap<String, Object> params);

	
}