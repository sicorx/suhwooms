package rems.system.persistence;

import java.util.HashMap;
import java.util.List;

import rems.system.model.GridRemsDeviceMgntVo;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.persistence
 * @Class Name : RemsDeviceMgntMapper.java
 * @Description : 렘스장비 서비스 맵퍼
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 2. 9.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 2. 9. 오전 10:51:35
 * @version 2.0
 * 
 */
public interface RemsDeviceMgntMapper {

	// 렘스장비 목록
	public List<GridRemsDeviceMgntVo> retrieveStoreRemsMgnt(HashMap<String, Object> params);
	
	// 렘스장비 저장
	public int saveStoreRemsMgnt(GridRemsDeviceMgntVo params);
	
	// 램스장비 지우기
	public int delStoreRemsMgnt(HashMap<String, Object> params);
	
	//엑셀다운로드
	public List<HashMap<String,Object>> downloadstoreRemsMgntExcel(HashMap<String, Object> params);
}
