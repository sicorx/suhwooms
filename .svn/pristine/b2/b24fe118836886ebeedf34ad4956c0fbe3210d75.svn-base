package rems.system.persistence;
 
import java.util.HashMap;
import java.util.List;

import rems.system.model.GwVo;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.persistence
 * @Class Name : GwMgntMapper.java
 * @Description : 게이트웨이 서비스 맵퍼
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 2. 8.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 2. 8. 오후 1:47:10
 * @version 2.0
 * 
 */
public interface GwMgntMapper {

	// 게이트웨이 목록
	public List<GwVo> retrieveGwListMgnt(HashMap<String, Object> params);
	
	// 게이트웨이 중복 확인
	public int checkGwId(HashMap<String, Object> params);
	
	// 게이트웨이 저장 
	public int saveGWMgnt(GwVo params);
	
	// 게이트웨이 지우기
	public int delGWMgnt(HashMap<String, Object> params);
		
	//엑셀다운로드
	public List<HashMap<String,Object>> retrieveGwListExcelMgnt(HashMap<String, Object> params);
	
	public int getGwId();
	
}
