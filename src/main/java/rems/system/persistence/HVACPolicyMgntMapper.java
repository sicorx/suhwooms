package rems.system.persistence;

import java.util.HashMap;

import rems.system.model.HVACPolicyMgntVo;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.persistence
 * @Class Name : HVACPolicyMgntMapper.java
 * @Description : 냉난방정책 맵퍼
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 1. 25.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 1. 25. 오전 10:23:47
 * @version 2.0
 * 
 */
public interface HVACPolicyMgntMapper {

	// 냉난방정책 상세내역
	HVACPolicyMgntVo retrieveSeasonPolicyMgnt(HashMap<String, Object> params);
	
	// 냉난방정책 저장
	int saveAirConditionPolicyMgnt(HashMap<String, String> map);

}
