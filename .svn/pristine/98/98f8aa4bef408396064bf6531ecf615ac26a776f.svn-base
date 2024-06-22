package rems.system.service;

import java.util.HashMap;
import java.util.List;

import rems.common.model.SelectVo;
import rems.system.model.GridTempPolicyMgntVo;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.service
 * @Class Name : TempPolicyMgntSvc.java
 * @Description : 권고온도 서비스 인터페이스
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 1. 24.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 1. 24. 오후 6:19:14
 * @version 2.0
 * 
 */
public interface TempPolicyMgntSvc {
	
	// 권고온도 내역
	public List<GridTempPolicyMgntVo> retrieveRemsTempPolicyList(HashMap<String, Object> params);
	
	// 권고온도 상세내역
	public GridTempPolicyMgntVo retrieveRemsTempPolicy(HashMap<String, Object> params);
	
	// 권고온도 저장
	public boolean saveTempPolicyMgnt(GridTempPolicyMgntVo params);
	
	// 금년, 차년 select
	public List<SelectVo> retrieveYearList();
	
}