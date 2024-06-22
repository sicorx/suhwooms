package rems.system.persistence;

import java.util.HashMap;
import java.util.List;

import rems.common.model.SelectVo;
import rems.system.model.GridTempPolicyMgntVo;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.persistence
 * @Class Name : TempPolicyMgntMapper.java
 * @Description : 권고온도 서비스 맵퍼
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 1. 25.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 1. 25. 오전 10:21:21
 * @version 2.0
 * 
 */
public interface TempPolicyMgntMapper {

	// 권고온도 내역
	public List<GridTempPolicyMgntVo> retrieveRemsTempPolicyList(HashMap<String, Object> params);
	
	// 권고온도 상세내역
	public GridTempPolicyMgntVo retrieveRemsTempPolicy(HashMap<String, Object> params);
	
	// 권고온도 저장
	public int saveTempPolicyMgnt(HashMap<String, String> params);
	
	// 금년, 차년 select
	public List<SelectVo> retrieveYearList();
	
}
