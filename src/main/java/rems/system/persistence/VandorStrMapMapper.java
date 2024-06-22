package rems.system.persistence;

import java.util.HashMap;
import java.util.List;

import rems.common.model.SelectVo;
import rems.system.model.GridMaintainEngineerMgntVo;
import rems.system.model.VandorStrMapVo;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.persistence
 * @Class Name : VandorStrMapMapper.java
 * @Description : 업체매장할당 서비스 맵퍼
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 2. 16.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 2. 16. 오후 1:04:42
 * @version 2.0
 * 
 */
public interface VandorStrMapMapper {

	// 할당된 매장목록 검색
	List<VandorStrMapVo> searchMapedStrList(HashMap<String, Object> params);
		
	// 할당매장선택 목록
	List<VandorStrMapVo> searchCompanyStrList(HashMap<String, Object> params);

	// 엔지니어 맵핑 삭제
	int deleteEngineerStrMapping(HashMap<String, Object> mapParams);
		
	// 할당된매장 삭제
	int deleteStrMappingVendor(HashMap<String, Object> mapParams);	

	// 할당된매장 등록
	int insertStrMappingVendor(HashMap<String, Object> mapParams);
	
	// 엑셀
	public List<HashMap<String, Object>> searchCompanyStrListExcel(HashMap<String, Object> params);

	
	
	
	
	
	
	
	
	List<SelectVo> retrieveVendorList(HashMap<String, Object> params);

	List<SelectVo> retrieveAllVandorCdList();

	List<GridMaintainEngineerMgntVo> searchVendorEngineerStrList(HashMap<String, Object> params);

}
