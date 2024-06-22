package rems.system.service;

import java.util.HashMap;
import java.util.List;

import rems.common.model.UserMngVo;
import rems.system.model.GridStoreMgntVo;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.service
 * @Class Name : MultOperMgntSvc.java
 * @Description : 복수경영주 서비스 인터페이스
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 2. 1.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 2. 1. 오후 2:47:42
 * @version 2.0
 * 
 */
public interface MultOperMgntSvc {
	
	// 경영자 목록
	public List<UserMngVo> retrieveUserList(HashMap<String, Object> params);

	// 소유매장 목록
	public List<GridStoreMgntVo> retrieveRemsStoreMgnt(HashMap<String, Object> params);
	
	// 전체매장 목록
	public List<GridStoreMgntVo> retrieveOperRemsStoreMgnt(HashMap<String, Object> params);
	
	// 소유매장 삭제
	public boolean deleteStrMapMgnt(HashMap<String, Object> params);
	
	// 소유매장 등록
	public boolean saveStrMapMgnt(HashMap<String, Object> params);
}
