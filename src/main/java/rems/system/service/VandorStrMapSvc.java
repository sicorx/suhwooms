package rems.system.service;

import java.util.HashMap;
import java.util.List;

import rems.common.model.SelectVo;
import rems.system.model.GridMaintainEngineerMgntVo;
import rems.system.model.VandorStrMapVo;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.service
 * @Class Name : VandorStrMapSvc.java
 * @Description : 업체매장할당 서비스 인터페이스
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 2. 16.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 2. 16. 오후 12:59:46
 * @version 2.0
 * 
 */
public interface VandorStrMapSvc {
	
	// 할당된 매장목록 검색
	List<VandorStrMapVo> searchMapedStrList(HashMap<String, Object> params);
		
	// 할당매장선택 목록
	List<VandorStrMapVo> searchCompanyStrList(HashMap<String, Object> params);

	// 할당된매장 삭제
	boolean deleteStrMappingVendor(HashMap<String, Object> params);
	
	// 할당된매장 등록
	boolean insertStrMappingVendor(HashMap<String, Object> params);
	
	// 엑셀
	public List<HashMap<String, Object>> searchCompanyStrListExcel(HashMap<String, Object> params);
	
	
	
	List<SelectVo> retrieveVendorList(HashMap<String, Object> params);
	
	List<SelectVo> retrieveAllVandorCdList();

	List<GridMaintainEngineerMgntVo> searchVendorEngineerStrList(HashMap<String, Object> params);
	
}
