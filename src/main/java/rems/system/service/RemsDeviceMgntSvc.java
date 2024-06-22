package rems.system.service;

import java.util.HashMap;
import java.util.List;

import rems.system.model.GridRemsDeviceMgntVo;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.service
 * @Class Name : RemsDeviceMgntSvc.java
 * @Description : 렘스장비 서비스 인터페이스
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 2. 9.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 2. 9. 오전 10:49:19
 * @version 2.0
 * 
 */
public interface RemsDeviceMgntSvc {
	
	// 렘스장비 목록
	public List<GridRemsDeviceMgntVo> retrieveStoreRemsMgnt(HashMap<String, Object> params);

	//엑셀다운로드
	public List<HashMap<String,Object>> downloadstoreRemsMgntExcel(HashMap<String, Object> params);
	
	// 렘스장비 저장
	public boolean saveStoreRemsMgnt(GridRemsDeviceMgntVo params);
	
	// 렘스장비 지우기
	public int delStoreRemsMgnt(HashMap<String, Object> params);
	
}
