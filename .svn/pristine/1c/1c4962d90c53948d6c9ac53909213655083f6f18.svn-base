package rems.system.service;

import java.util.HashMap;
import java.util.List;

import rems.system.model.GwVo;
 
/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.service
 * @Class Name : GwMgntSvc.java
 * @Description : 게이트웨이 서비스 인터페이스
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 2. 8.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 2. 8. 오후 1:45:16
 * @version 2.0
 * 
 */
public interface GwMgntSvc {
	
	// 게이트웨이 목록
	public List<GwVo> retrieveGwListMgnt(HashMap<String, Object> params);
	
	// 게이트웨이 중복 확인
	public boolean checkGwId(HashMap<String, Object> params);
	
	// 게이트웨이 저장 
	public boolean saveGWMgnt(GwVo params);
	
	// 게이트웨이 지우기
	public int delGWMgnt(HashMap<String, Object> params);
	
	public int getGwId();
	
	//엑셀 다운로드
	public List<HashMap<String,Object>> retrieveGwListExcelMgnt(HashMap<String, Object> params);

}
