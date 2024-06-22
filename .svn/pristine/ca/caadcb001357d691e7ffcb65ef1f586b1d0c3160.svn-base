package rems.system.service;

import java.util.HashMap;
import java.util.List;

import rems.system.model.GridMaintainEngineerMgntVo;
import rems.system.model.GridUserMgntVo;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.service
 * @Class Name : MaintainEngineerMngtSvc.java
 * @Description : 엔지니어관리 서비스 인터페이스
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 3. 8.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 3. 8. 오후 4:28:21
 * @version 2.0
 * 
 */
public interface MaintainEngineerMngtSvc {
	
	// 엔지니어 목록
	List<GridMaintainEngineerMgntVo> searchMaintainEngineerList(HashMap<String, Object> params);

	// 엔지니어 저장
	boolean saveEngineerMgnt(GridUserMgntVo gumVo);

	//엑셀다운로드
	public List<HashMap<String, Object>> downloadMaintainEngineerListrExcel(HashMap<String, Object> params);
	// List<GridMaintainEngineerMgntVo> searchMaintainEngineerExcelList(HashMap<String, Object> params);

}
