package rems.system.persistence;

import java.util.HashMap;
import java.util.List;

import rems.system.model.GridVendorMgntVo;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.persistence
 * @Class Name : VendorMgntMapper.java
 * @Description : 유지보수업체 서비스 맵퍼
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 1. 26.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 1. 26. 오후 3:32:40
 * @version 2.0
 * 
 */
public interface VendorMgntMapper {

	// 유지보수업체 목록
	public List<GridVendorMgntVo> retrieveRemsVendorList(HashMap<String, Object> params);

	// 업체코드 중복 확인
	public int checkVendorCd(HashMap<String, Object> params);
	
	// 유지보수업체 저장
	public int saveRemsVendorMgnt(GridVendorMgntVo params);

	// 엔지니어 등록 유무 체크
	public int checkEngineerTF(GridVendorMgntVo params);
	
}
